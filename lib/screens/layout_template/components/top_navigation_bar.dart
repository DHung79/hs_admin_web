import 'package:flutter/material.dart';
import '../../../core/admin/model/admin_model.dart';
import '../../../core/authentication/auth.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/joytech_components/joytech_components.dart';

class TopNavigationBar extends StatefulWidget {
  final AdminModel admin;
  final void Function() onPressed;
  final String routeName;
  final String subTitle;

  const TopNavigationBar({
    Key? key,
    required this.onPressed,
    required this.routeName,
    required this.subTitle,
    required this.admin,
  }) : super(key: key);

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _appbarTitle(),
          _actions(),
        ],
      ),
    );
  }

  _appbarTitle() {
    final screenSize = MediaQuery.of(context).size;
    final subTitle = widget.subTitle;
    String disPlaySubTitle = subTitle;
    if (subTitle.contains('/') && screenSize.width < 1200) {
      final subName =
          subTitle.substring(subTitle.indexOf(' / '), subTitle.length).trim();
      disPlaySubTitle = subName.substring(2, subName.length);
      if (disPlaySubTitle.contains('/') && screenSize.width < 800) {
        final subName = disPlaySubTitle
            .substring(disPlaySubTitle.indexOf(' / '), disPlaySubTitle.length)
            .trim();
        disPlaySubTitle = subName.substring(2, subName.length);
      }
    }

    return Row(
      children: [
        Text(
          widget.routeName,
          style: AppTextTheme.mediumHeaderTitle(
            AppColor.text1,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Text(
          disPlaySubTitle,
          style: AppTextTheme.normalText(
            AppColor.text7,
          ),
        ),
      ],
    );
  }

  _actions() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgIcon(
                SvgIcons.commentAlt,
                color: AppColor.text7,
                size: 24,
              ),
            ),
            onTap: () {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgIcon(
                SvgIcons.notifications,
                color: AppColor.text7,
              ),
            ),
            onTap: () {},
          ),
        ),
        _adminInfo(),
      ],
    );
  }

  _adminInfo() {
    final _adminMenuItems = [
      DialogItem(
        svgIcon: SvgIcons.user,
        title: 'Hồ Sơ',
        onPressed: () {
          navigateTo(profileRoute);
        },
      ),
      DialogItem(
        svgIcon: SvgIcons.settingTwo,
        title: 'Cài đặt',
        onPressed: () {
          navigateTo(settingRoute);
        },
      ),
      DialogItem(
        title: ScreenUtil.t(I18nKey.signOut)!,
        svgIcon: SvgIcons.logout,
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
    ];
    final screenSize = MediaQuery.of(context).size;

    return PopupMenuButton(
      offset: const Offset(0, 50),
      color: AppColor.white,
      onCanceled: () {},
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            if (screenSize.width > 1200)
              Text(
                widget.admin.name,
                style: AppTextTheme.normalText(
                  AppColor.text1,
                ),
              ),
            if (screenSize.width > 1200)
              const SizedBox(
                width: 16,
              ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                "assets/images/logo.png",
                width: 24,
                height: 24,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) {
        return _adminMenuItems.map((DialogItem item) {
          return PopupMenuItem<DialogItem>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  if (item.icon != null)
                    Icon(
                      item.icon,
                      color: AppColor.text1,
                      size: 24,
                    ),
                  if (item.svgIcon != null)
                    SvgIcon(
                      item.svgIcon!,
                      color: AppColor.text1,
                      size: 24,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      item.title,
                      style: AppTextTheme.normalText(AppColor.text1),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList();
      },
      onSelected: (DialogItem item) {
        item.onPressed!();
      },
    );
  }
}

class DialogItem {
  DialogItem({
    required this.title,
    this.route,
    this.subRoute,
    this.icon,
    this.svgIcon,
    this.children = const [],
    this.onPressed,
  });

  final String title;
  final String? route;
  final String? subRoute;
  final IconData? icon;
  final SvgIconData? svgIcon;
  final List<MenuItem> children;
  Function()? onPressed;
}
