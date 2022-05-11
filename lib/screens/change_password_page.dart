import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hs_admin_web/widgets/title_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';
import '/configs/themes.dart';

import '../configs/text_theme.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController AgainPasswordController = TextEditingController();
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
                    backPageWidget(context, 'Đăng nhập'),
                    const TitleWidget(title: 'QUÊN MẬT KHẨU'),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          InputWidget(
                            hintText: 'Mật khẩu',
                            index: 1,
                            controller: passwordController,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          InputWidget(
                            hintText: 'Nhập lại mật khẩu',
                            index: 1,
                            controller: AgainPasswordController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    errorTextWidget('Mật khẩu không khớp'),
                    const SizedBox(
                      height: 24,
                    ),
                    ButtonWidget(
                      text: 'XÁC NHẬN',
                      onPressed: () {},
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

  Container backPageWidget(BuildContext context, String text) {
    return Container(
      width: MediaQuery.of(context).size.width / 13,
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/icons/17079.svg',
              width: 24,
              height: 24,
              color: WebColor.textColor7,
            ),
            const SizedBox(
              width: 13,
            ),
            Text(
              text,
              style: WebTextTheme().mediumBodyText(WebColor.textColor7),
            )
          ],
        ),
      ),
    );
  }
}
