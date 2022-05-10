import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../configs/text_theme.dart';
import '../configs/themes.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';
import '../widgets/title_widget.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();

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
                    Container(
                      constraints:
                          const BoxConstraints(maxWidth: 140, minWidth: 100),
                      padding: const EdgeInsets.only(top: 3, bottom: 3),
                      child: InkWell(
                        splashColor: Colors.transparent,
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
                              'Thay đổi email',
                              style: WebTextTheme()
                                  .mediumBodyText(WebColor.textColor7),
                            )
                          ],
                        ),
                      ),
                    ),
                    const TitleWidget(title: 'QUÊN MẬT KHẨU'),
                    Form(
                      key: _formKey,
                      child: InputWidget(
                        hintText: 'Nhập mã OTP',
                        index: 3,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    errorTextWidget('Mã OTP sai vui lòng nhập lại'),
                    const SizedBox(
                      height: 24,
                    ),
                    const ButtonWidget(
                      text: 'TIẾP TỤC',
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
}
