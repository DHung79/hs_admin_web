import 'package:flutter/material.dart';
import 'package:hs_admin_web/configs/svg_constants.dart';
import 'package:hs_admin_web/configs/text_theme.dart';

import '../../configs/themes.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({Key? key}) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String dropdownValue = 'HÌnh';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hình thức thanh toán',
            style: WebTextTheme().mediumBodyText(WebColor.shadowColor),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: WebColor.shapeColor1,
            padding: const EdgeInsets.symmetric(
              vertical: 19,
              horizontal: 16,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chọn hình thức thanh toán',
                    style: WebTextTheme().mediumBodyText(WebColor.textColor7),
                  ),
                  SvgIcon(
                    SvgIcons.check,
                    color: WebColor.shadowColor,
                    size: 24,
                  )
                ]),
          )
        ],
      ),
    );
  }
}
