import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class JTConfirmDialog extends StatefulWidget {
  final String headerTitle;
  final String contentText;
  final TextStyle? headerTitleStyle;
  final TextStyle? contentTextStyle;
  final Function()? onComfirmed;
  final Function()? onCanceled;

  const JTConfirmDialog({
    Key? key,
    required this.headerTitle,
    required this.contentText,
    this.headerTitleStyle,
    this.contentTextStyle,
    this.onComfirmed,
    this.onCanceled,
  }) : super(key: key);

  @override
  State<JTConfirmDialog> createState() => _JTConfirmDialogState();
}

class _JTConfirmDialogState extends State<JTConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      const double dialogWidth = 414;
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          constraints: const BoxConstraints(
            minWidth: dialogWidth,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Text(
                    widget.headerTitle,
                    style: widget.headerTitleStyle ??
                        AppTextTheme.mediumHeaderTitle(AppColor.text7),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Divider(
                    thickness: 1.5,
                    color: AppColor.shade1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    widget.contentText,
                    style: widget.contentTextStyle ??
                        AppTextTheme.normalText(AppColor.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 16, 0, 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: AppButtonTheme.fillRounded(
                          constraints: const BoxConstraints(
                            minHeight: 52,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          color: AppColor.shade1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.close,
                                color: AppColor.text3,
                                size: 24,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Hủy bỏ',
                                  style:
                                      AppTextTheme.headerTitle(AppColor.text3),
                                ),
                              ),
                            ],
                          ),
                          onPressed: widget.onCanceled,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 1,
                        child: AppButtonTheme.fillRounded(
                          constraints: const BoxConstraints(
                            minHeight: 52,
                          ),
                          borderRadius: BorderRadius.circular(4),
                          color: AppColor.shade1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgIcon(
                                SvgIcons.checkCircleOutline,
                                color: AppColor.text3,
                                size: 24,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  'Xác nhận',
                                  style:
                                      AppTextTheme.headerTitle(AppColor.text3),
                                ),
                              ),
                            ],
                          ),
                          onPressed: widget.onComfirmed,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
