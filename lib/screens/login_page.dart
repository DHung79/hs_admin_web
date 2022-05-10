import 'package:flutter/material.dart';
import 'package:hs_admin_web/widgets/title_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';
import '/configs/themes.dart';

import '../configs/text_theme.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool showPassword = false;
  void hideShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Row(
          children: [
            Container(
              color: WebColor.primaryColor1,
              width: MediaQuery.of(context).size.width * 0.4,
              height: MediaQuery.of(context).size.height,
              child: Image.asset('assets/images/logodemo.png'),
            ),
            SizedBox(
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
                      child: Column(
                        children: [
                          InputWidget(
                            hintText: 'Tài khoản',
                            index: 0,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InputWidget(
                            hintText: 'Mật khẩu',
                            index: 1,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    errorTextWidget('Tài khoản hoặc mật khẩu không đúng'),
                    const SizedBox(
                      height: 24,
                    ),
                    rowCheckBox(context),
                    const SizedBox(
                      height: 24,
                    ),
                    const ButtonWidget(
                      text: 'ĐĂNG NHẬP',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Text errorTextWidget(errorText) {
    return Text(
      errorText,
      style: WebTextTheme().normalText(WebColor.otherColor1),
    );
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
            onTap: () {},
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
}
