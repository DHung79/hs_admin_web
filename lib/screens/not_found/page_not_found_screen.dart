import 'package:flutter/material.dart';
import '/theme/app_theme.dart';
import '../../main.dart';

class PageNotFoundScreen extends StatefulWidget {
  final String route;
  const PageNotFoundScreen(this.route, {Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PageNotFoundScreenState();
}

class _PageNotFoundScreenState extends State<PageNotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary1,
        leading: InkWell(
          child: const Icon(
            Icons.arrow_back_ios_outlined,
            size: 20,
          ),
          onTap: () {
            navigateTo(initialRoute);
          },
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.report_gmailerrorred_outlined,
            size: 120,
          ),
          Center(
            child: Text(
              'Không tìm thấy trang!',
              style: AppTextTheme.bigText(AppColor.black),
            ),
          ),
        ],
      ),
    );
  }
}
