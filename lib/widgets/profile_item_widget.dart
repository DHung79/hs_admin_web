import 'package:flutter/material.dart';
import '../configs/svg_constants.dart';
import '../configs/text_theme.dart';
import '../configs/themes.dart';

class ProfileItemWidget extends StatelessWidget {
  final SvgIconData icon;
  final String title;
  final void Function()? onTap;
  final Color color;
  final double? sizeWidth;

  const ProfileItemWidget({
    Key? key,
    this.sizeWidth,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color = WebColor.textColor1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: sizeWidth,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(children: [
            SvgIcon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: WebTextTheme().normalText(color),
            )
          ]),
        ),
      ),
    );
  }
}
