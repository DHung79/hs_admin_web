import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import '../../core/authentication/bloc/authentication/authentication_bloc.dart';
import '../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../core/authentication/bloc/authentication/authentication_state.dart';
import '../../main.dart';
import '../../routes/route_names.dart';
import '../../theme/app_theme.dart';
import '../../widgets/input_widget.dart';
import '../../widgets/title_widget.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key, required this.state}) : super(key: key);
  final AuthenticationState state;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool isChecked = false;

  final _formKey = GlobalKey<FormState>();
  bool? _isKeepSession = false;
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _showPassword = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(GetLastUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBlocController().authenticationBloc,
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            setState(() {
              _errorMessage = state.message;
            });
          } else if (state is LoginLastUser) {
            _emailController.text = state.username;
            setState(
              () {
                _isKeepSession = state.isKeepSession;
              },
            );
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 500, minWidth: 350),
              child: Form(
                key: _formKey,
                autovalidateMode: _autovalidate,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const TitleWidget(title: 'ĐĂNG NHẬP'),
                    InputWidget(
                      controller: _emailController,
                      style: AppTextTheme.mediumBodyText(AppColor.text7),
                      borderColor: AppColor.text7,
                      hintText: 'Tài khoản',
                      onSaved: (value) {
                        _emailController.text = value!.trim();
                      },
                      onChanged: (value) {
                        setState(() {
                          if (_errorMessage.isNotEmpty) {
                            _errorMessage = '';
                          }
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty || value.trim().isEmpty) {
                          return ValidatorText.empty(
                              fieldName: ScreenUtil.t(I18nKey.email)!);
                        }
                        if (!isEmail(value.trim())) {
                          return ValidatorText.invalidFormat(
                              fieldName: ScreenUtil.t(I18nKey.email)!);
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InputWidget(
                      controller: _passwordController,
                      suffixIcon: TextButton(
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                        child: Icon(
                          _showPassword == true
                              ? Icons.remove_red_eye
                              : Icons.remove_red_eye_outlined,
                          color: AppColor.text7,
                          size: 24,
                        ),
                      ),
                      style: AppTextTheme.mediumBodyText(
                        AppColor.text7,
                      ),
                      borderColor: AppColor.text7,
                      hintText: 'Mật khẩu',
                      onSaved: (value) {
                        _passwordController.text = value!.trim();
                      },
                      onChanged: (value) {
                        setState(() {
                          if (_errorMessage.isNotEmpty) {
                            _errorMessage = '';
                          }
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ValidatorText.empty(
                              fieldName: ScreenUtil.t(I18nKey.password)!);
                        }
                        if (value.length < 6) {
                          return ValidatorText.atLeast(
                              fieldName: ScreenUtil.t(I18nKey.password)!,
                              atLeast: 6);
                        }
                        if (value.length > 50) {
                          return ValidatorText.moreThan(
                              fieldName: ScreenUtil.t(I18nKey.password)!,
                              moreThan: 50);
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: rowCheckBox(context),
                    ),
                    AppButtonTheme.fillRounded(
                      color: AppColor.primary1,
                      constraints: const BoxConstraints(minHeight: 52),
                      borderRadius: BorderRadius.circular(4),
                      child: Text(
                        'ĐĂNG NHẬP',
                        style: AppTextTheme.headerTitle(AppColor.text2),
                      ),
                      onPressed: login,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  login() {
    setState(() {
      _errorMessage = '';
    });

    if (widget.state is AuthenticationLoading) return;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthenticationBlocController().authenticationBloc.add(
            UserLogin(
              email: _emailController.text,
              password: _passwordController.text,
              keepSession: _isKeepSession!,
              isMobile: false,
            ),
          );
    } else {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  SizedBox rowCheckBox(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                fillColor: MaterialStateProperty.all(AppColor.text3),
                checkColor: Colors.white,
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 11.0,
                  bottom: 11.0,
                  right: 11.0,
                  left: 11.0,
                ),
                child: Text(
                  'Nhớ tài khoản',
                  style: AppTextTheme.mediumBodyText(AppColor.text3),
                ),
              )
            ],
          ),
          InkWell(
            onTap: () => navigateTo(forgotPasswordRoute),
            child: Text(
              'Quên mật khẩu',
              style: AppTextTheme.mediumBodyText(
                AppColor.text7,
              ),
            ),
          )
        ],
      ),
    );
  }

  Column errorTextWidget(errorText) {
    return Column(
      children: [
        const SizedBox(
          height: 24,
        ),
        Text(
          errorText,
          style: AppTextTheme.normalText(AppColor.others1),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
