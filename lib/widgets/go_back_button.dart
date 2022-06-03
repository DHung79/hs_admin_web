import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GoBackButton extends StatelessWidget {
  final void Function() onPressed;
  const GoBackButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: AppColor.transparent,
      splashColor: AppColor.transparent,
      highlightColor: AppColor.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIcon(
              SvgIcons.arrowIosBack,
              size: 24,
              color: AppColor.text7,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                'Trở về',
                style: AppTextTheme.normalText(AppColor.text7),
              ),
            )
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}
