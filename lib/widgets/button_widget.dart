import 'package:flutter/material.dart';

import '../configs/text_theme.dart';
import '../configs/themes.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          text,
          style: WebTextTheme().headerAndTitle(WebColor.textColor2),
        ),
      ),
    );
  }
}
