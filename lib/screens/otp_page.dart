import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../theme/app_theme.dart';
import '../widgets/button_widget.dart';
import '../widgets/input_widget.dart';
import '../widgets/title_widget.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key}) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  TextEditingController controller = TextEditingController();
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
              color: AppColor.primary1,
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
                      margin: const EdgeInsets.only(bottom: 16),
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
                              color: AppColor.text7,
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Text(
                              'Thay đổi email',
                              style:
                                  AppTextTheme.mediumBodyText(AppColor.text7),
                            )
                          ],
                        ),
                      ),
                    ),
                    const TitleWidget(title: 'QUÊN MẬT KHẨU'),
                    Form(
                      key: _formKey,
                      child: InputWidget(
                        controller: controller,
                        style: AppTextTheme.mediumBodyText(
                          AppColor.text7,
                        ),
                        borderColor: AppColor.text7,
                        hintText: 'Nhập mã OTP',
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    errorTextWidget('Mã OTP sai vui lòng nhập lại'),
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

  Text errorTextWidget(errorText) {
    return Text(
      errorText,
      style: AppTextTheme.normalText(AppColor.others1),
    );
  }
}
