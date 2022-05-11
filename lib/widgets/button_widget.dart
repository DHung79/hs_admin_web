import 'package:flutter/material.dart';

import '../configs/text_theme.dart';
import '../configs/themes.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);
  final String text;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      height: 52.0,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: WebColor.primaryColor1,
          padding: const EdgeInsets.only(
            top: 16,
            bottom: 16,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: WebTextTheme().headerAndTitle(WebColor.textColor2),
        ),
      ),
    );
  }
}
