import 'package:flutter/material.dart';

import '../configs/text_theme.dart';
import '../configs/themes.dart';

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
          style: WebTextTheme().mediumBigText(WebColor.textColor1),
        ),
      ),
    );
  }
}
