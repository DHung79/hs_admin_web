import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_admin_web/main.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import 'package:hs_admin_web/screens/onboarding/components/forgot_password_form.dart';
import '../../theme/app_theme.dart';
import '/core/authentication/auth.dart';
import 'components/login_form.dart';
import 'components/otp_form.dart';
import 'components/reset_password_form.dart';

class AuthenticationScreen extends StatefulWidget {
  final int form;
  const AuthenticationScreen({
    Key? key,
    this.form = 0,
  }) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    ScreenUtil.init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<AuthenticationBloc, AuthenticationState>(
        bloc: AuthenticationBlocController().authenticationBloc,
        listener: (context, state) {
          if (state is AppAutheticated) {
            navigateTo(userManagementRoute);
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: AuthenticationBlocController().authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            return Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      width: screenSize.width * 2 / 5,
                    ),
                    Expanded(
                      child: _buildContent(),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: AppColor.primary1,
                      width: screenSize.width * 2 / 5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/images/logo_width.png',
                            width: 240,
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (widget.form == 1) {
      return ForgotPasswordForm(
        onNavigator: () {
          navigateTo(authenticationRoute);
        },
      );
    } else if (widget.form == 2) {
      return OTPForm(
        onNavigator: () {
          navigateTo(forgotPasswordRoute);
        },
      );
    } else if (widget.form == 3) {
      return ResetPasswordForm(
        onNavigator: () {
          navigateTo(authenticationRoute);
        },
      );
    } else {
      return LoginForm(
        onNavigator: () {
          navigateTo(forgotPasswordRoute);
        },
      );
    }
  }
}
