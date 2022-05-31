import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/authentication/auth.dart';
import '../../../main.dart';
import '../../../routes/route_names.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/input_widget.dart';

class OTPForm extends StatefulWidget {
  final Function()? onNavigator;

  const OTPForm({
    Key? key,
    this.onNavigator,
  }) : super(key: key);

  @override
  State<OTPForm> createState() => _OTPFormState();
}

class _OTPFormState extends State<OTPForm> {
  TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBlocController().authenticationBloc,
        listener: (context, state) {
          if (state is AuthenticationFailure) {
            _showError(state.errorCode);
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
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 22),
                      child: Text(
                        'NHẬP MÃ OTP',
                        style: AppTextTheme.mediumBigText(AppColor.text1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InputWidget(
                        controller: _otpController,
                        style: AppTextTheme.mediumBodyText(AppColor.text7),
                        borderColor: AppColor.text7,
                        hintText: 'Nhập mã OTP',
                        onSaved: (value) {
                          _otpController.text = value!.trim();
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
                            return ValidatorText.empty(fieldName: 'mã OTP');
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
                        onPressed: _otp,
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
                  SvgIcons.arrowBack,
                  size: 24,
                  color: AppColor.text7,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13),
                  child: Text(
                    'Thay đổi Email',
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

  _otp() {
    setState(() {
      _errorMessage = '';
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      navigateTo(resetPasswordRoute);
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
