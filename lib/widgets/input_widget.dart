import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

import '../configs/text_theme.dart';
import '../configs/themes.dart';
import '../core/authentication/auth.dart';

// ignore: must_be_immutable
class InputWidget extends StatefulWidget {
  InputWidget(
      {Key? key,
      required this.hintText,
      this.index = 0,
      this.showPassword = false,
      password,
      required this.controller,
      this.errorMessage = '',
      this.autovalidate,
      this.formKey})
      : super(key: key);
  final int index;
  final String hintText;
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

  Widget? index() {
    if (widget.index == 0) {
      return null;
    } else if (widget.index == 1) {
      return TextButton(
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
          size: 24,
        ),
      );
    } else if (widget.index == 2) {
      return TextButton(
        child: Text(
          'Kiểm tra',
          style: WebTextTheme().mediumBodyText(
            WebColor.testColor5,
          ),
        ),
        onPressed: _forgotPassword,
      );
    } else {
      return TextButton(
        child: Text(
          'Gửi lại',
          style: WebTextTheme().mediumBodyText(
            WebColor.testColor5,
          ),
        ),
        onPressed: () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 3,
      child: TextFormField(
        obscureText: widget.showPassword,
        cursorColor: WebColor.textColor7,
        style: WebTextTheme().mediumBodyText(WebColor.textColor7),
        decoration: InputDecoration(
          filled: true,
          fillColor: WebColor.shapeColor1,
          hintText: widget.hintText,
          suffixIcon: index(),
          hintStyle: WebTextTheme().mediumBodyText(WebColor.textColor7),
          enabledBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: WebColor.textColor7,
              width: 3,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: const BorderSide(
              color: WebColor.textColor7,
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
