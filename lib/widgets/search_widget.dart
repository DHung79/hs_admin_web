import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function()? onClean;

  const SearchWidget({
    Key? key,
    required this.controller,
    this.onChanged,
    this.onClean,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 265,
      child: TextFormField(
        controller: controller,
        cursorHeight: 20,
        cursorColor: AppColor.text7,
        style: AppTextTheme.normalText(AppColor.text1),
        decoration: InputDecoration(
          hoverColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Tìm kiếm',
          hintStyle: AppTextTheme.normalText(AppColor.text7),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
              ),
              child: SvgIcon(
                SvgIcons.search,
                color: controller.text.isNotEmpty
                    ? AppColor.primary2
                    : AppColor.text7,
              ),
              onPressed: () {},
            ),
          ),
          suffixIcon: controller.text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                    ),
                    child: SvgIcon(
                      SvgIcons.close,
                      color: AppColor.others1,
                    ),
                    onPressed: onClean,
                  ),
                )
              : null,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
