import 'package:flutter/material.dart';

import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';

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
        color: WebColor.textColor1.withOpacity(0.3),
        child: Center(
            child: Container(
          decoration: BoxDecoration(
              color: WebColor.textColor2,
              borderRadius: BorderRadius.circular(10)),
          width: 414,
          height: 240,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cảnh báo',
                  style: WebTextTheme().mediumHeaderAndTitle(
                    WebColor.textColor7,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Divider(
                  color: WebColor.shapeColor1,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  widget.ask,
                  style: WebTextTheme().normalText(
                    WebColor.textColor1,
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
          backgroundColor: WebColor.shapeColor1,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SvgIcon(
            icon,
            color: WebColor.textColor3,
            size: 24,
          ),
          const SizedBox(
            width: 16,
          ),
          Text(
            text,
            style: WebTextTheme().headerAndTitle(WebColor.textColor3),
          )
        ]),
      ),
    );
  }
}
