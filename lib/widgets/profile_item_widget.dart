import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ProfileItemWidget extends StatelessWidget {
  final SvgIconData icon;
  final String title;
  final void Function()? onTap;
  final Color? color;
  final double? sizeWidth;

  const ProfileItemWidget({
    Key? key,
    this.sizeWidth,
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
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
              color: color ?? AppColor.text1,
              size: 24,
            ),
            const SizedBox(
              width: 16,
            ),
            Text(
              title,
              style: AppTextTheme.normalText(color ?? AppColor.text1),
            )
          ]),
        ),
      ),
    );
  }
}
