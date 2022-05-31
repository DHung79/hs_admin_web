import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class WarningWidget extends StatefulWidget {
  final String ask;
  final void Function()? onPressed;
  const WarningWidget({
    Key? key,
    required this.ask,
    this.onPressed,
  }) : super(key: key);

  @override
  State<WarningWidget> createState() => _WarningWidgetState();
}

class _WarningWidgetState extends State<WarningWidget> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      child: Container(
        color: AppColor.text1.withOpacity(0.3),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
            color: AppColor.text2,
            borderRadius: BorderRadius.circular(10),
          ),
          width: 414,
          height: 240,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cảnh báo',
                  style: AppTextTheme.mediumHeaderTitle(
                    AppColor.text7,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Divider(
                  color: AppColor.shade1,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.ask,
                  style: AppTextTheme.normalText(
                    AppColor.text1,
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
                Row(
                  children: [
                    _buttonWarning(
                      text: 'Hủy bỏ',
                      icon: SvgIcons.close,
                      onpressed: widget.onPressed,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    _buttonWarning(
                      text: 'Xác nhận',
                      icon: SvgIcons.circleCheck,
                      onpressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }

  SizedBox _buttonWarning({
    required String text,
    required SvgIconData icon,
    required void Function()? onpressed,
  }) {
    return SizedBox(
      width: 175,
      child: TextButton(
        onPressed: onpressed,
        style: TextButton.styleFrom(
          backgroundColor: AppColor.shade1,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgIcon(
            icon,
            color: AppColor.text3,
            size: 24,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: AppTextTheme.headerTitle(AppColor.text3),
          )
        ]),
      ),
    );
  }
}
