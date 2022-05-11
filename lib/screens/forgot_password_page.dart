import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hs_admin_web/main.dart';
import 'package:hs_admin_web/routes/route_names.dart';

import '../configs/text_theme.dart';
import '../configs/themes.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';
import '../widgets/title_widget.dart';

class ForgotPassWord extends StatefulWidget {
  const ForgotPassWord({Key? key}) : super(key: key);

  @override
  State<ForgotPassWord> createState() => _ForgotPassWordState();
}

class _ForgotPassWordState extends State<ForgotPassWord> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  AutovalidateMode autovalidate = AutovalidateMode.disabled;

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
                    backPageWidget(context),
                    const TitleWidget(title: 'QUÊN MẬT KHẨU'),
                    Form(
                      key: _formKey,
                      child: InputWidget(
                        hintText: 'Nhập email',
                        index: 2,
                        controller: controller,
                        formKey: _formKey,
                        autovalidate: autovalidate,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    errorTextWidget('Email không tồn tại'),
                    const SizedBox(
                      height: 24,
                    ),
                    ButtonWidget(
                      text: 'TIẾP TỤC',
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

  Container backPageWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 13,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: InkWell(
        onTap: () {
          navigateTo(authenticationRoute);
        },
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
              'Đăng nhập',
              style: WebTextTheme().mediumBodyText(WebColor.textColor7),
            )
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
}
