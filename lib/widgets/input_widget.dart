import 'package:flutter/material.dart';

import '../configs/text_theme.dart';
import '../configs/themes.dart';

// ignore: must_be_immutable
class InputWidget extends StatefulWidget {
  InputWidget(
      {Key? key,
      required this.hintText,
      this.password = false,
      this.showPassword = false})
      : super(key: key);
  final bool password;
  final String hintText;
  bool showPassword;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: WebColor.textColor7, width: 2),
        ),
      ),
      child: TextFormField(
        obscureText: widget.showPassword,
        cursorColor: WebColor.textColor7,
        style: WebTextTheme().mediumBodyText(WebColor.textColor7),
        decoration: InputDecoration(
          filled: true,
          fillColor: WebColor.shapeColor1,
          hintText: widget.hintText,
          suffixIcon: widget.password == true
              ? TextButton(
                  onPressed: () {
                    setState(() {
                      widget.showPassword = !widget.showPassword;
                    });
                  },
                  child: Icon(
                    widget.showPassword == true
                        ? Icons.remove_red_eye
                        : Icons.remove_red_eye_outlined,
                    color: WebColor.textColor7,
                  ),
                )
              : null,
          hintStyle: WebTextTheme().mediumBodyText(WebColor.textColor7),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
