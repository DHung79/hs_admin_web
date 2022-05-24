import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../configs/text_theme.dart';
import '../configs/themes.dart';
import '../core/authentication/auth.dart';

// ignore: must_be_immutable
class InputWidget extends StatefulWidget {
  InputWidget(
      {Key? key,
      this.isWidth,
      this.suffixIcon,
      this.prefixIcon,
      required this.style,
      required this.colorBorder,
      required this.hintText,
      this.index = 0,
      this.showPassword = false,
      required this.controller,
      this.errorMessage = '',
      this.autovalidate,
      this.formKey})
      : super(key: key);
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  final TextStyle style;
  final Color colorBorder;
  final int index;
  final String hintText;
  final bool? isWidth;
  bool showPassword;
  TextEditingController controller = TextEditingController();
  String errorMessage;
  AutovalidateMode? autovalidate;
  final GlobalKey<FormState>? formKey;

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: widget.isWidth! ? const BoxConstraints(maxWidth: 500) : null,
      child: TextFormField(
        obscureText: widget.showPassword,
        cursorColor: WebColor.textColor7,
        style: widget.style,
        decoration: InputDecoration(
          filled: true,
          fillColor: WebColor.shapeColor1,
          hintText: widget.hintText,
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          hintStyle: WebTextTheme().mediumBodyText(WebColor.textColor7),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.colorBorder,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.colorBorder,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        controller: widget.controller,
        onSaved: (value) {
          widget.controller.text = value!.trim();
        },
        onChanged: (value) {
          setState(() {
            if (widget.errorMessage.isNotEmpty) {
              widget.errorMessage = '';
            }
          });
        },
        validator: widget.index == 0 || widget.index == 2 || widget.index == 3
            ? (value) {
                if (value!.isEmpty || value.trim().isEmpty) {
                  return widget.errorMessage = 'Không được để trống';
                }
                if (!isEmail(value.trim())) {
                  return widget.errorMessage = 'Không đúng định dạng email';
                }
                return null;
              }
            : (value) {
                if (value!.isEmpty) {
                  return widget.errorMessage = 'Không được để trống';
                }
                if (value.length < 6) {
                  return widget.errorMessage = 'Mật khẩu phải từ 6 kí tự';
                }
                if (value.length > 50) {
                  return widget.errorMessage = 'Tối đa 50 kí tự';
                }
                return null;
              },
      ),
    );
  }

  _forgotPassword() {
    setState(() {
      widget.errorMessage = '';
    });
    if (widget.formKey!.currentState!.validate()) {
      widget.formKey!.currentState!.save();
      AuthenticationBlocController().authenticationBloc.add(
            ForgotPassword(email: widget.controller.text),
          );
    } else {
      setState(() {
        widget.autovalidate = AutovalidateMode.onUserInteraction;
      });
    }
  }
}
