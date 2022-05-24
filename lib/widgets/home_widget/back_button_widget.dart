import 'package:flutter/material.dart';

import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';

class BackButtonWidget extends StatelessWidget {
  final void Function() onPressed;
  const BackButtonWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 19),
      child: TextButton(
        style: TextButton.styleFrom(maximumSize: const Size.fromWidth(100)),
        child: Row(
          children: [
            SvgIcon(
              SvgIcons.arrowBack,
              color: WebColor.textColor7,
              size: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Trở về',
              style: WebTextTheme().normalText(
                WebColor.textColor7,
              ),
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
