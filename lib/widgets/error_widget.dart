import 'package:flutter/material.dart';

import '../configs/text_theme.dart';
import '../configs/themes.dart';

class ErrorWidget extends StatelessWidget {
  ErrorWidget({Key? key, required this.errorText}) : super(key: key);
  String errorText;

  @override
  Widget build(BuildContext context) {
    return Text(
      errorText,
      style: WebTextTheme().normalText(WebColor.otherColor1),
    );
  }
}
