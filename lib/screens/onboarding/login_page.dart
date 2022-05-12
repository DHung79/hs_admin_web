import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_admin_web/screens/onboarding/splash_screen.dart';

import '../../configs/text_theme.dart';
import '../../configs/themes.dart';
import '../../core/authentication/bloc/authentication/authentication_bloc.dart';
import '../../core/authentication/bloc/authentication/authentication_event.dart';
import '../../core/authentication/bloc/authentication/authentication_state.dart';
import '../../core/authentication/bloc/authentication_bloc_controller.dart';
import '../../main.dart';
import '../../routes/route_names.dart';
import '../../widgets/button_widget.dart';
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
  late bool? _isKeepSession = false;
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  TextEditingController accountController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';

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
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: AuthenticationBlocController().authenticationBloc,
      listener: (context, state) {
        if (state is AuthenticationFailure) {
          print(state);
        } else if (state is LoginLastUser) {
          accountController.text = state.username;
          setState(
            () {
              _isKeepSession = state.isKeepSession;
            },
          );
        }
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        height: MediaQuery.of(context).size.height,
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitleWidget(title: 'ĐĂNG NHẬP'),
              Form(
                key: _formKey,
                autovalidateMode: _autovalidate,
                child: Column(
                  children: [
                    InputWidget(
                      hintText: 'Tài khoản',
                      controller: accountController,
                      index: 0,
                      errorMessage: errorMessage,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    InputWidget(
                      hintText: 'Mật khẩu',
                      index: 1,
                      controller: passwordController,
                      errorMessage: errorMessage,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              rowCheckBox(context),
              const SizedBox(
                height: 24,
              ),
              ButtonWidget(
                text: 'ĐĂNG NHẬP',
                onPressed: login,
              ),
            ],
          ),
        ),
      ),
    );
  }

  login() {
    setState(() {
      errorMessage = '';
    });
    if (widget.state is AuthenticationLoading) return const SplashScreen();

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      AuthenticationBlocController().authenticationBloc.add(
            UserLogin(
              email: accountController.text,
              password: passwordController.text,
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
                fillColor: MaterialStateProperty.all(WebColor.textColor3),
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
                  style: WebTextTheme().mediumBodyText(WebColor.textColor3),
                ),
              )
            ],
          ),
          InkWell(
            onTap: () => navigateTo(forgotPasswordRoute),
            child: Text(
              'Quên mật khẩu',
              style: WebTextTheme().mediumBodyText(
                WebColor.textColor7,
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
          style: WebTextTheme().normalText(WebColor.otherColor1),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
