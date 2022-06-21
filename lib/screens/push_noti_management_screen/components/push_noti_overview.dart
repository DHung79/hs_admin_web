import 'package:flutter/material.dart';

class PushNotiOverView extends StatelessWidget {
  const PushNotiOverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 431,
            constraints: const BoxConstraints(minHeight: 229),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [],
            ),
          ),
        );
      },
    );
  }
}
