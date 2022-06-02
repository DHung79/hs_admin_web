import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_admin_web/main.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../../core/authentication/auth.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/input_widget.dart';

class ResetPasswordForm extends StatefulWidget {
  final Function()? onNavigator;
  const ResetPasswordForm({
    Key? key,
    this.onNavigator,
  }) : super(key: key);

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _checkPasswordController = TextEditingController();
  bool _newPasswordSecure = true;
  bool _checkPasswordSecure = true;
  String _errorMessage = '';
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBlocController().authenticationBloc,
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            _showError(state.errorCode);
          } else if (state is ResetPasswordDoneState) {
            navigateTo(authenticationRoute);
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
                        'NHẬP MẬT KHẨU MỚI',
                        style: AppTextTheme.mediumBigText(AppColor.text1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InputWidget(
                        controller: _newPasswordController,
                        obscureText: _newPasswordSecure,
                        hintText: 'Nhập mật khẩu',
                        style: AppTextTheme.mediumBodyText(
                          AppColor.text7,
                        ),
                        borderColor: AppColor.text7,
                        suffixIcon: TextButton(
                          onPressed: () {
                            setState(() {
                              _newPasswordSecure = !_newPasswordSecure;
                            });
                          },
                          child: _newPasswordSecure
                              ? Icon(
                                  Icons.remove_red_eye,
                                  color: AppColor.text7,
                                  size: 24,
                                )
                              : SvgIcon(
                                  SvgIcons.removeRedEye,
                                  color: AppColor.text7,
                                  size: 24,
                                ),
                        ),
                        onSaved: (value) {
                          _newPasswordController.text = value!.trim();
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
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InputWidget(
                        controller: _checkPasswordController,
                        obscureText: _checkPasswordSecure,
                        hintText: 'Nhập lại mật khẩu',
                        style: AppTextTheme.mediumBodyText(
                          AppColor.text7,
                        ),
                        borderColor: AppColor.text7,
                        suffixIcon: TextButton(
                          onPressed: () {
                            setState(() {
                              _checkPasswordSecure = !_checkPasswordSecure;
                            });
                          },
                          child: _checkPasswordSecure
                              ? Icon(
                                  Icons.remove_red_eye,
                                  color: AppColor.text7,
                                  size: 24,
                                )
                              : SvgIcon(
                                  SvgIcons.removeRedEye,
                                  color: AppColor.text7,
                                  size: 24,
                                ),
                        ),
                        onSaved: (value) {
                          _checkPasswordController.text = value!.trim();
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
                          if (value != _newPasswordController.text) {
                            return 'Mật khẩu không khớp';
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
                          'XÁC NHẬN',
                          style: AppTextTheme.headerTitle(AppColor.text2),
                        ),
                        onPressed: _resetPassword,
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
                  SvgIcons.arrowIosBack,
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

  _resetPassword() {
    setState(() {
      _errorMessage = '';
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      navigateTo(authenticationRoute);
    } else {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  _showError(String errorCode) {
    setState(() {
      _errorMessage = showError(errorCode, context);
    });
  }
}
