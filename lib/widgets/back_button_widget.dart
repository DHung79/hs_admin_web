import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
              SvgIcons.arrowIosBack,
              color: AppColor.text7,
              size: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Trở về',
              style: AppTextTheme.normalText(
                AppColor.text7,
              ),
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
