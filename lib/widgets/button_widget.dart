import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ButtonWidget extends StatelessWidget {
  final BoxConstraints? constraints;
  final String text;
  final Function()? onPressed;
  const ButtonWidget({
    Key? key,
    this.constraints = const BoxConstraints(minHeight: 52),
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: AppColor.primary1,
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextTheme.headerTitle(AppColor.text2),
        ),
      ),
    );
  }
}
