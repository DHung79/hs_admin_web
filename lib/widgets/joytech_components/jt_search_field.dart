import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../debouncer/debouncer.dart';

class JTSearchField extends StatefulWidget {
  final TextEditingController controller;
  final TextStyle? style;
  final double? cursorHeight;
  final Color? cursorColor;
  final Color? fillColor;
  final InputBorder? border;
  final Color? hoverColor;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onFetch;
  final Function(String)? onChanged;
  const JTSearchField({
    Key? key,
    required this.controller,
    this.style,
    this.cursorHeight,
    this.cursorColor,
    this.fillColor,
    this.border,
    this.hoverColor,
    this.hintText,
    this.hintStyle,
    this.prefixIcon,
    this.suffixIcon,
    this.onFetch,
    this.onChanged,
  }) : super(key: key);

  @override
  State<JTSearchField> createState() => _JTSearchFieldState();
}

class _JTSearchFieldState extends State<JTSearchField> {
  late Debouncer _debouncer;
  @override
  void initState() {
    _debouncer = Debouncer(delayTime: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      style: widget.style ?? AppTextTheme.normalText(AppColor.text1),
      cursorHeight: widget.cursorHeight ?? 20,
      cursorColor: widget.cursorColor ?? AppColor.text7,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        fillColor: widget.fillColor ?? Colors.white,
        filled: true,
        hoverColor: widget.hoverColor ?? Colors.white,
        border: widget.border ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
      ),
      onChanged: (newValue) {
        widget.onChanged!(newValue);
        _debouncer.debounce(afterDuration: () {
          widget.onFetch!();
        });
      },
    );
  }
}
