import 'package:flutter/material.dart';

import '../../configs/text_theme.dart';
import '../../configs/themes.dart';
import '../input_widget.dart';

class FormUserWidget extends StatefulWidget {
  final String? title;
  final String hintText;
  TextEditingController controller = TextEditingController();
  final bool isWidth;
  final bool showTitle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry padding;

  FormUserWidget({
    Key? key,
    this.title,
    this.padding = const EdgeInsets.all(16.0),
    required this.controller,
    required this.hintText,
    required this.isWidth,
    this.showTitle = false,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  State<FormUserWidget> createState() => _FormUserWidgetState();
}

class _FormUserWidgetState extends State<FormUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.showTitle)
            Column(
              children: [
                Text(
                  widget.title!,
                  style: WebTextTheme().mediumBodyText(
                    WebColor.shadowColor,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          InputWidget(
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            isWidth: widget.isWidth,
            colorBorder: WebColor.shadowColor,
            style: WebTextTheme().mediumBodyText(
              WebColor.textColor3,
            ),
            hintText: widget.hintText,
            controller: widget.controller,
          ),
        ],
      ),
    );
  }
}
