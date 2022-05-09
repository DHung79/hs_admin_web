import 'package:flutter/material.dart';
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
                      margin: const EdgeInsets.only(bottom: 24),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'ĐĂNG NHẬP',
                          style:
                              WebTextTheme().mediumBigText(WebColor.textColor1),
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: WebColor.textColor7, width: 2),
                              ),
                            ),
                            child: TextFormField(
                              cursorColor: WebColor.textColor7,
                              style: WebTextTheme()
                                  .mediumBodyText(WebColor.textColor7),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: WebColor.shapeColor1,
                                hintText: 'Tài khoản',
                                hintStyle: WebTextTheme()
                                    .mediumBodyText(WebColor.textColor7),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 3,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                    color: WebColor.textColor7, width: 2),
                              ),
                            ),
                            child: TextFormField(
                              obscureText: showPassword,
                              cursorColor: WebColor.textColor7,
                              style: WebTextTheme()
                                  .mediumBodyText(WebColor.textColor7),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              showCursor: true,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: WebColor.shapeColor1,
                                hintText: 'Mật khẩu',
                                suffixIcon: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      showPassword = !showPassword;
                                    });
                                  },
                                  child: Icon(
                                    showPassword == true
                                        ? Icons.remove_red_eye
                                        : Icons.remove_red_eye_outlined,
                                    color: WebColor.textColor7,
                                  ),
                                ),
                                hintStyle: WebTextTheme()
                                    .mediumBodyText(WebColor.textColor7),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Tài khoản hoặc mật khẩu không đúng',
                      style: WebTextTheme().normalText(WebColor.otherColor1),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                fillColor: MaterialStateProperty.all(
                                    WebColor.textColor3),
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
                                  style: WebTextTheme()
                                      .mediumBodyText(WebColor.textColor3),
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
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 3,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: WebColor.primaryColor1,
                          padding: const EdgeInsets.only(
                            top: 16,
                            bottom: 16,
                          ),
                        ),
                        onPressed: () {},
                        child: Text(
                          'ĐĂNG NHẬP',
                          style: WebTextTheme()
                              .headerAndTitle(WebColor.textColor2),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
