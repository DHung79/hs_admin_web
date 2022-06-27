import 'package:universal_html/html.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DisplayImage extends StatelessWidget {
  final String imageUrl;

  const DisplayImage(
    this.imageUrl, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      imageUrl,
      (int _) => ImageElement(src: imageUrl)
        ..style.width = '100%'
        ..style.height = '100%'
        ..draggable = false,
    );
    return SizedBox(
      width: 100,
      height: 100,
      child: HtmlElementView(
        viewType: imageUrl,
      ),
    );
  }
}
