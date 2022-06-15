import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import '../../../core/authentication/bloc/authentication/authentication_bloc.dart';
import '../../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../../core/authentication/bloc/authentication/authentication_state.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/input_widget.dart';

class LoginForm extends StatefulWidget {
  final Function()? onNavigator;
  const LoginForm({
    Key? key,
    this.onNavigator,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool? _isKeepSession = false;
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _showPassword = false;
  bool _processing = false;
  Timer? _delayLogin;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  void dispose() {
    _delayLogin?.cancel();
    super.dispose();
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
            _showError(state.errorCode);
          } else if (state is LoginLastUser) {
            _emailController.text = state.username;
            setState(() {
              _isKeepSession = state.isKeepSession;
            });
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 22),
                      child: Text(
                        'ĐĂNG NHẬP',
                        style: AppTextTheme.mediumBigText(AppColor.text1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InputWidget(
                        controller: _emailController,
                        style: AppTextTheme.mediumBodyText(AppColor.black),
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
                            if (_processing && _errorMessage.isEmpty) {
                              _processing = false;
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InputWidget(
                        controller: _passwordController,
                        obscureText: !_showPassword,
                        hintText: 'Mật khẩu',
                        style: AppTextTheme.mediumBodyText(
                          AppColor.black,
                        ),
                        borderColor: AppColor.text7,
                        suffixIcon: TextButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: _showPassword
                              ? SvgIcon(
                                  SvgIcons.removeRedEye,
                                  color: AppColor.text7,
                                  size: 24,
                                )
                              : SvgIcon(
                                  SvgIcons.eyeOff,
                                  color: AppColor.text7,
                                  size: 24,
                                ),
                        ),
                        onSaved: (value) {
                          _passwordController.text = value!.trim();
                        },
                        onChanged: (value) {
                          setState(() {
                            if (_errorMessage.isNotEmpty) {
                              _errorMessage = '';
                            }
                            if (_processing && _errorMessage.isEmpty) {
                              _processing = false;
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
                        onFieldSubmitted: (value) => login(),
                      ),
                    ),
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          _errorMessage,
                          style: AppTextTheme.normalText(AppColor.others1),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: rowCheckBox(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 32),
                      child: AppButtonTheme.fillRounded(
                        color: AppColor.primary1,
                        constraints: const BoxConstraints(minHeight: 52),
                        borderRadius: BorderRadius.circular(4),
                        child: Text(
                          'ĐĂNG NHẬP',
                          style: AppTextTheme.headerTitle(AppColor.text2),
                        ),
                        onPressed: !_processing ? login : null,
                      ),
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
      _processing = true;
      _delayLogin = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (timer.tick == 1) {
          timer.cancel();
          setState(() {
            _processing = false;
          });
        }
      });
    });

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

  Widget rowCheckBox(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 2),
              child: SizedBox(
                height: 18,
                width: 18,
                child: Checkbox(
                  splashRadius: 0,
                  activeColor: AppColor.primary2,
                  checkColor: Colors.white,
                  value: _isKeepSession,
                  onChanged: (value) {
                    setState(() {
                      _isKeepSession = value!;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(11),
              child: Text(
                'Nhớ tài khoản',
                style: AppTextTheme.mediumBodyText(AppColor.text3),
              ),
            )
          ],
        ),
        InkWell(
          hoverColor: AppColor.transparent,
          highlightColor: AppColor.transparent,
          splashColor: AppColor.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
            child: Text(
              'Quên mật khẩu',
              style: AppTextTheme.mediumBodyText(
                AppColor.text7,
              ),
            ),
          ),
          onTap: widget.onNavigator,
        )
      ],
    );
  }

  _showError(String errorCode) {
    setState(() {
      _errorMessage = showError(errorCode, context);
    });
  }
}
