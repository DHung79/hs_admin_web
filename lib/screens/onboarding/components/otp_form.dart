import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/authentication/auth.dart';
import '../../../main.dart';
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
  final _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';
  bool _processing = false;
  Timer? _delayResend;
  Timer? _delayCheckOtp;
  bool _lockResend = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  void dispose() {
    _delayCheckOtp?.cancel();
    _delayResend?.cancel();
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
          if (state is CheckOTPDoneState) {
            navigateTo(resetPasswordRoute);
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
                        'NHẬP MÃ OTP',
                        style: AppTextTheme.mediumBigText(AppColor.text1),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: InputWidget(
                        controller: _otpController,
                        borderColor: AppColor.text7,
                        hintText: 'Nhập mã OTP',
                        suffixIcon: _textFieldButton(),
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
                            return ValidatorText.empty(fieldName: 'Mã OTP');
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
                        onPressed: !_processing ? _checkOTP : null,
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
                  SvgIcons.keyboardBack,
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

  Widget _textFieldButton() {
    return InkWell(
      hoverColor: AppColor.transparent,
      splashColor: AppColor.transparent,
      highlightColor: AppColor.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        child: Text(
          'Gửi lại',
          style: AppTextTheme.mediumBodyText(
            _lockResend ? AppColor.text7 : AppColor.shade5,
          ),
        ),
      ),
      onTap: !_lockResend ? _resendOTP : null,
    );
  }

  _resendOTP() {
    setState(() {
      _errorMessage = '';
      _lockResend = true;
      _delayResend = Timer.periodic(const Duration(minutes: 5), (timer) {
        if (timer.tick == 1) {
          timer.cancel();
          setState(() {
            _lockResend = false;
          });
        }
      });
    });
    AuthenticationBlocController().authenticationBloc.add(ResendOTP());
  }

  _checkOTP() {
    setState(() {
      _processing = true;
      _delayCheckOtp = Timer.periodic(const Duration(seconds: 2), (timer) {
        if (timer.tick == 1) {
          timer.cancel();
          setState(() {
            _processing = false;
          });
        }
      });
      _errorMessage = '';
    });
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthenticationBlocController().authenticationBloc.add(
            CheckOTP(otp: _otpController.text),
          );
    } else {
      setState(() {
        _autovalidate = AutovalidateMode.onUserInteraction;
      });
    }
  }

  _showError(String errorCode) {
    setState(() {
      _errorMessage = showError(errorCode, context, fieldName: 'otp');
    });
  }
}
