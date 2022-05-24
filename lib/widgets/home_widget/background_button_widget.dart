import 'package:flutter/material.dart';

import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';

class BackgroundButton extends StatelessWidget {
  final SvgIconData icon;
  final Color color;
  final String text;
  final void Function()? onPressed;

  const BackgroundButton({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 16,
        ),
        child: Row(
          children: [
            SvgIcon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              text,
              style: WebTextTheme().mediumBodyText(Colors.white),
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
