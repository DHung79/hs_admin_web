import 'package:flutter/material.dart';

import '../../configs/text_theme.dart';
import '../../configs/themes.dart';

class LineContent extends StatelessWidget {
  final bool even;
  final String title;
  final String line1a;
  final String line1b;
  final String line2a;
  final String line2b;
  final String line3a;
  final String line3b;
  final String? line4a;
  final String? line4b;

  const LineContent({
    Key? key,
    this.even = false,
    required this.title,
    required this.line1a,
    required this.line1b,
    required this.line2a,
    required this.line2b,
    required this.line3a,
    required this.line3b,
    this.line4a,
    this.line4b,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: WebTextTheme().normalHeaderAndTitle(WebColor.shadowColor),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  lineProfile(
                    name: line1a,
                    description: line1b,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  lineProfile(
                    name: line2a,
                    description: line2b,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  lineProfile(
                    name: line3a,
                    description: line3b,
                  ),
                  if (even)
                    const SizedBox(
                      height: 16,
                    ),
                  if (even)
                    lineProfile(
                      name: line4a!,
                      description: line4b!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

Row lineProfile({required String name, required String description}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        name,
        style: WebTextTheme().normalText(WebColor.testColor8),
      ),
      Flexible(
        child: Text(
          description,
          style: WebTextTheme().normalText(WebColor.textColor3),
          maxLines: 5,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
