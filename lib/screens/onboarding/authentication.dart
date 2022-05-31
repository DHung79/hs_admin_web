import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_admin_web/main.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../theme/app_theme.dart';
import '/core/authentication/auth.dart';
import 'login_form.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
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
            navigateTo(userManageRoute);
          }
        },
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          bloc: AuthenticationBlocController().authenticationBloc,
          builder: (BuildContext context, AuthenticationState state) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: AppColor.primary1,
                  width: screenSize.width * 2 / 5,
                  child: Image.asset('assets/images/logodemo.png'),
                ),
                Expanded(
                  child: LoginForm(state: state),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
