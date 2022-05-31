import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'input_widget.dart';

class FormUserWidget extends StatefulWidget {
  final String? initialValue;
  final String? title;
  final String hintText;
  final TextEditingController controller;
  final bool isWidth;
  final bool showTitle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final EdgeInsetsGeometry padding;

  const FormUserWidget({
    Key? key,
    this.title,
    this.padding = const EdgeInsets.all(16.0),
    required this.controller,
    required this.hintText,
    required this.isWidth,
    this.showTitle = false,
    this.suffixIcon,
    this.prefixIcon,
    this.initialValue,
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
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(
                widget.title!,
                style: AppTextTheme.mediumBodyText(
                  AppColor.shadow,
                ),
              ),
            ),
          InputWidget(
            initialValue: widget.initialValue,
            controller: widget.controller,
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            style: AppTextTheme.mediumBodyText(
              AppColor.text3,
            ),
            hintText: widget.hintText,
          ),
        ],
      ),
    );
  }
}
