import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class InputWidget extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final BoxConstraints? constraints;
  final TextStyle? style;
  final bool obscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? borderColor;
  final String? hintText;
  final Function(String?)? onSaved;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const InputWidget({
    Key? key,
    this.initialValue,
    this.controller,
    this.constraints = const BoxConstraints(minHeight: 52),
    this.style,
    this.obscureText = false,
    this.suffixIcon,
    this.prefixIcon,
    this.borderColor,
    this.hintText,
    this.onSaved,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: constraints,
      child: TextFormField(
        controller: controller,
        initialValue: initialValue,
        obscureText: obscureText,
        cursorColor: AppColor.text7,
        style: style,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(16),
          filled: true,
          fillColor: AppColor.shade1,
          hintText: hintText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: AppTextTheme.mediumBodyText(AppColor.text7),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? AppColor.shadow,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: borderColor ?? AppColor.shadow,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.others1,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onSaved: onSaved,
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }
}
