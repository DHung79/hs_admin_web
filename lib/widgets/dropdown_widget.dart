import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

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
            style: AppTextTheme.mediumBodyText(AppColor.shadow),
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            color: AppColor.shade1,
            padding: const EdgeInsets.symmetric(
              vertical: 19,
              horizontal: 16,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Chọn hình thức thanh toán',
                    style: AppTextTheme.mediumBodyText(AppColor.text7),
                  ),
                  SvgIcon(
                    SvgIcons.check,
                    color: AppColor.shadow,
                    size: 24,
                  )
                ]),
          )
        ],
      ),
    );
  }
}
