import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/authentication/auth.dart';
import '../../../../../main.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../widgets/input_widget.dart';
import '../../../../../widgets/joytech_components/joytech_components.dart';

class ChangePasswordDialog extends StatefulWidget {
  final String oldPassword;
  const ChangePasswordDialog({
    Key? key,
    required this.oldPassword,
  }) : super(key: key);

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _checkNewPasswordController = TextEditingController();
  bool _oldPasswordSecure = true;
  bool _newPasswordSecure = true;
  bool _checkNewPasswordSecure = true;
  String _errorMessage = '';
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      const double dialogWidth = 414;
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          constraints: const BoxConstraints(
            minWidth: dialogWidth,
          ),
          child: BlocListener<AuthenticationBloc, AuthenticationState>(
            bloc: AuthenticationBlocController().authenticationBloc,
            listener: (context, state) async {
              if (state is AuthenticationFailure) {
                _showError(state.errorCode);
              }
              if (state is ChangePasswordDoneState) {
                JTToast.init(context);
                Navigator.of(context).pop();
                await Future.delayed(const Duration(milliseconds: 400));
                JTToast.successToast(message: 'Bạn đã đổi mật khẩu thành công');
              }
            },
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidate,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 26),
                      child: Text(
                        'Đổi mật khẩu',
                        style: AppTextTheme.mediumHeaderTitle(
                          AppColor.primary2,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Divider(
                        thickness: 1,
                        color: AppColor.shade1,
                      ),
                    ),
                    _buildField(
                      controller: _oldPasswordController,
                      obscureText: _oldPasswordSecure,
                      hintText: 'Nhập mật khẩu cũ',
                      onPressed: () {
                        setState(() {
                          _oldPasswordSecure = !_oldPasswordSecure;
                        });
                      },
                      onSaved: (value) {
                        _oldPasswordController.text = value!.trim();
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
                            fieldName: 'Mật khẩu cũ',
                          );
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: _buildField(
                        controller: _newPasswordController,
                        obscureText: _newPasswordSecure,
                        hintText: 'Nhập mật khẩu',
                        onPressed: () {
                          setState(() {
                            _newPasswordSecure = !_newPasswordSecure;
                          });
                        },
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
                          if (value!.isEmpty || value.trim().isEmpty) {
                            return ValidatorText.empty(
                                fieldName: ScreenUtil.t(I18nKey.password)!);
                          }
                          if (value.trim().length < 6) {
                            return ValidatorText.atLeast(
                                fieldName: ScreenUtil.t(I18nKey.password)!,
                                atLeast: 6);
                          }
                          if (value.trim().length > 50) {
                            return ValidatorText.moreThan(
                                fieldName: ScreenUtil.t(I18nKey.password)!,
                                moreThan: 50);
                          }
                          return null;
                        },
                      ),
                    ),
                    _buildField(
                      controller: _checkNewPasswordController,
                      obscureText: _checkNewPasswordSecure,
                      hintText: 'Nhập lại mật khẩu',
                      onPressed: () {
                        setState(() {
                          _checkNewPasswordSecure = !_checkNewPasswordSecure;
                        });
                      },
                      onSaved: (value) {
                        _checkNewPasswordController.text = value!.trim();
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
                              fieldName: ScreenUtil.t(I18nKey.password)!);
                        }
                        if (value != _newPasswordController.text) {
                          return 'Mật khẩu không khớp';
                        }
                        return null;
                      },
                    ),
                    if (_errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: Text(
                          _errorMessage,
                          style: AppTextTheme.normalText(AppColor.others1),
                        ),
                      ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 40, 0, 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppButtonTheme.fillRounded(
                              constraints: const BoxConstraints(
                                minHeight: 52,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              color: AppColor.shade1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.close,
                                    color: AppColor.black,
                                    size: 24,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Hủy bỏ',
                                      style: AppTextTheme.headerTitle(
                                          AppColor.black),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: AppButtonTheme.fillRounded(
                              constraints: const BoxConstraints(
                                minHeight: 52,
                              ),
                              borderRadius: BorderRadius.circular(4),
                              color: AppColor.primary2,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgIcon(
                                    SvgIcons.checkCircleOutline,
                                    color: AppColor.white,
                                    size: 24,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'Xác nhận',
                                      style: AppTextTheme.headerTitle(
                                        AppColor.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              onPressed: _changePassword,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  _buildField({
    Function(String?)? onSaved,
    Function(String?)? onChanged,
    String? Function(String?)? validator,
    required void Function()? onPressed,
    required bool obscureText,
    required TextEditingController controller,
    required String hintText,
  }) {
    return InputWidget(
      controller: controller,
      obscureText: obscureText,
      hintText: hintText,
      borderColor: AppColor.text7,
      suffixIcon: TextButton(
        onPressed: onPressed,
        child: obscureText
            ? SvgIcon(
                SvgIcons.eyeOff,
                color: AppColor.text7,
                size: 24,
              )
            : SvgIcon(
                SvgIcons.removeRedEye,
                color: AppColor.text7,
                size: 24,
              ),
      ),
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
    );
  }

  _changePassword() {
    setState(() {
      _errorMessage = '';
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthenticationBlocController().authenticationBloc.add(
            ChangePassword(
              password: _oldPasswordController.text,
              newPassword: _newPasswordController.text,
            ),
          );
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
