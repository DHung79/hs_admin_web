import 'package:flutter/material.dart';

import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';

class DataTableWidget extends StatefulWidget {
  const DataTableWidget({Key? key}) : super(key: key);

  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: WebColor.shapeColor2,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: WebColor.shadowColor.withOpacity(0.24),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 16)
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                propertyRecords(
                  title: 'No.',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.085,
                ),
                propertyRecords(
                  title: 'Tên',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.145,
                  icon: true,
                ),
                propertyRecords(
                  title: 'Email',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.272,
                  icon: true,
                ),
                propertyRecords(
                  title: 'Số điện thoại',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.162,
                  icon: true,
                ),
                propertyRecords(
                  title: 'Địa chỉ',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.188,
                  icon: true,
                ),
                propertyRecords(
                  title: 'Hoạt động',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.149,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container propertyRecords({
    bool icon = false,
    required double widthSize,
    required String title,
  }) {
    return Container(
      width: widthSize,
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        Text(
          title,
          style: WebTextTheme().mediumHeaderAndTitle(WebColor.shadowColor),
        ),
        const SizedBox(
          width: 10,
        ),
        if (icon)
          SvgIcon(
            SvgIcons.filter,
            color: WebColor.textColor7,
            size: 18,
          ),
      ]),
    );
  }
}
