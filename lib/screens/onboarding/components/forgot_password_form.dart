import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/main.dart';
import 'package:validators/validators.dart';
import '../../../core/authentication/auth.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/input_widget.dart';

class ForgotPasswordForm extends StatefulWidget {
  final Function()? onNavigator;
  const ForgotPasswordForm({
    Key? key,
    this.onNavigator,
  }) : super(key: key);

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';
  bool _processing = false;
  Timer? _delayForgotPassword;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  void dispose() {
    _delayForgotPassword?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
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
          }
          if (state is ForgotPasswordDoneState) {
            navigateTo(otpRoute);
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
                    _gobBack(),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 34, 10, 22),
                      child: Text(
                        'QUÊN MẬT KHẨU',
                        style: AppTextTheme.mediumBigText(AppColor.text1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InputWidget(
                        controller: _emailController,
                        borderColor: AppColor.text7,
                        hintText: 'Nhập email',
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
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          _errorMessage,
                          style: AppTextTheme.normalText(AppColor.others1),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 12, 0, 32),
                      child: AppButtonTheme.fillRounded(
                        color: AppColor.primary1,
                        constraints: const BoxConstraints(minHeight: 52),
                        borderRadius: BorderRadius.circular(4),
                        child: Text(
                          'TIẾP TỤC',
                          style: AppTextTheme.headerTitle(AppColor.text2),
                        ),
                        onPressed: !_processing ? _forgotPassword : null,
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

  Widget _gobBack() {
    return Row(
      children: [
        InkWell(
          hoverColor: AppColor.transparent,
          splashColor: AppColor.transparent,
          highlightColor: AppColor.transparent,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgIcon(
                  SvgIcons.keyboardBackspace,
                  size: 24,
                  color: AppColor.text7,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Text(
                    'Đăng nhập',
                    style: AppTextTheme.mediumBodyText(AppColor.text7),
                  ),
                )
              ],
            ),
          ),
          onTap: widget.onNavigator,
        ),
      ],
    );
  }

  _forgotPassword() {
    setState(() {
      _errorMessage = '';
      _processing = true;
      _delayForgotPassword =
          Timer.periodic(const Duration(seconds: 2), (timer) {
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
            ForgotPassword(email: _emailController.text),
          );
    } else {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  _showError(String errorCode) {
    setState(() {
      _errorMessage = showError(errorCode, context, fieldName: 'Email');
    });
  }
}
