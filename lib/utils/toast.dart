import 'package:flutter/material.dart';
import 'package:hs_admin_web/configs/text_theme.dart';
import 'package:oktoast/oktoast.dart';

enum ToastType { success, warning, failure }

class Toast {
  static void success({required String message}) {
    showToast(message,
        duration: const Duration(seconds: 1),
        // backgroundColor: WebColor.success,
        position: ToastPosition.bottom,
        textStyle: WebTextTheme().mediumBodyText(Colors.white),
        textPadding: const EdgeInsets.all(8.0));
  }

  static void error({required String message}) {
    showToast(message,
        duration: const Duration(seconds: 1),
        // backgroundColor: WebColor.error,
        position: ToastPosition.bottom,
        textStyle: WebTextTheme().mediumBodyText(Colors.white),
        textPadding: const EdgeInsets.all(8.0));
  }

  static void warn({required String message}) {
    showToast(message,
        duration: const Duration(seconds: 1),
        // backgroundColor: WebColor.warn,
        position: ToastPosition.bottom,
        textStyle: WebTextTheme().mediumBodyText(Colors.white),
        textPadding: const EdgeInsets.all(8.0));
  }
}
