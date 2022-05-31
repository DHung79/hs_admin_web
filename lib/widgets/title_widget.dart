import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          title,
          style: AppTextTheme.mediumBigText(AppColor.text1),
        ),
      ),
    );
  }
}
