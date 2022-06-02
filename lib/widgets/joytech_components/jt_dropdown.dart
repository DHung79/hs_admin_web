import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class JTDropdownButtonFormField<T> extends StatelessWidget {
  final void Function(T?)? onSaved;
  final String? Function(T?)? validator;
  final List<Map<String, dynamic>> dataSource;
  final T defaultValue;
  final void Function(T?)? onChanged;
  final void Function()? onTap;
  final double? width;
  final double? height;
  final BoxDecoration? decoration;

  const JTDropdownButtonFormField({
    Key? key,
    required this.defaultValue,
    required this.dataSource,
    this.onSaved,
    this.validator,
    this.onChanged,
    this.onTap,
    this.width = 70,
    this.height = 44,
    this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    T _displayedValue = defaultValue;
    if (_displayedValue == null) {
      // Get the first value of the `dataSource`
      if (dataSource.isEmpty) {
        return const Text('DataSource must not be empty');
      }
      _displayedValue = dataSource[0]['name'];
    }
    if (_displayedValue == null) {
      return const Text('Could not find the default value');
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2(
              isExpanded: true,
              value: _displayedValue,
              buttonDecoration: decoration,
              buttonPadding: const EdgeInsets.symmetric(horizontal: 10),
              dropdownOverButton: true,
              dropdownDecoration: decoration,
              dropdownPadding: EdgeInsets.zero,
              icon: SvgIcon(
                SvgIcons.expandMore,
                color: AppColor.text7,
                size: 24,
              ),
              style: onChanged != null
                  ? AppTextTheme.normalText(AppColor.text1)
                  : AppTextTheme.normalText(AppColor.text7),
              onChanged: onChanged,
              items: dataSource
                  .map<DropdownMenuItem<T>>((Map<String, dynamic> value) {
                return DropdownMenuItem<T>(
                  value: value['value'] as T,
                  child: Text(
                    value['name'],
                    style: AppTextTheme.normalText(AppColor.text1),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
