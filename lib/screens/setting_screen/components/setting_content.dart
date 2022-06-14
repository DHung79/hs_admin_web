import 'package:flutter/material.dart';
import '../../../core/authentication/auth.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/joytech_components/joytech_components.dart';

class SettingContent extends StatefulWidget {
  final String route;
  final Function() onFetch;
  final TextEditingController searchController;

  const SettingContent({
    Key? key,
    required this.route,
    required this.onFetch,
    required this.searchController,
  }) : super(key: key);

  @override
  State<SettingContent> createState() => _SettingContentState();
}

class _SettingContentState extends State<SettingContent> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Cài đặt',
            style: AppTextTheme.mediumBigText(AppColor.text3),
          ),
        ),
        _buildContent(),
      ],
    );
  }

  Widget _buildContent() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColor.text2,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: AppColor.shadow.withOpacity(0.24),
            blurStyle: BlurStyle.outer,
            blurRadius: 16,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppButtonTheme.fillRounded(
            color: AppColor.transparent,
            highlightColor: AppColor.shade1,
            constraints: const BoxConstraints(minHeight: 56),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgIcon(
                  SvgIcons.user,
                  color: AppColor.text3,
                  size: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Hồ sơ của bạn',
                    style: AppTextTheme.normalText(AppColor.text3),
                  ),
                ),
              ],
            ),
            onPressed: () {
              navigateTo(profileRoute);
            },
          ),
          AppButtonTheme.fillRounded(
            color: AppColor.transparent,
            highlightColor: AppColor.shade1,
            constraints: const BoxConstraints(minHeight: 56),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SvgIcon(
                  SvgIcons.telephone,
                  color: AppColor.text3,
                  size: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Thông tin liên lạc',
                    style: AppTextTheme.normalText(AppColor.text3),
                  ),
                ),
              ],
            ),
            onPressed: () {
              navigateTo(contactRoute);
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Divider(
              thickness: 1,
              color: AppColor.shade1,
            ),
          ),
          AppButtonTheme.fillRounded(
            color: AppColor.transparent,
            highlightColor: AppColor.shade1,
            constraints: const BoxConstraints(minHeight: 44),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgIcon(
                  SvgIcons.logout,
                  color: AppColor.text7,
                  size: 24,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Đăng xuất',
                    style: AppTextTheme.normalText(AppColor.text7),
                  ),
                ),
              ],
            ),
            onPressed: () {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return JTConfirmDialog(
                    headerTitle: 'Cảnh báo',
                    contentText: 'Bạn có chắc chắn muốn đăng xuất?',
                    onCanceled: () {
                      Navigator.of(context).pop();
                    },
                    onComfirmed: () {
                      AuthenticationBlocController()
                          .authenticationBloc
                          .add(UserLogOut());
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
