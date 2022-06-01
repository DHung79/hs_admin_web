import 'package:flutter/material.dart';
import '../../core/admin/model/admin_model.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';

class AppBarWidget extends StatefulWidget {
  final AdminModel admin;
  final void Function() onPressed;
  final String routeName;
  final String subTitle;

  const AppBarWidget({
    Key? key,
    required this.onPressed,
    required this.routeName,
    required this.subTitle,
    required this.admin,
  }) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
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
    return Row(
      children: [
        Text(
          widget.subTitle,
          style: AppTextTheme.mediumHeaderTitle(
            AppColor.text1,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Text(
          widget.routeName,
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
                SvgIcons.comment,
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
                SvgIcons.bell,
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
    final List<DialogItem> _adminMenuItems = [
      DialogItem(
        svgIcon: SvgIcons.person,
        title: 'Hồ Sơ',
        onPressed: () {},
      ),
      DialogItem(
        svgIcon: SvgIcons.setting,
        title: 'Cài đặt',
        onPressed: () {},
      ),
      DialogItem(
          title: ScreenUtil.t(I18nKey.signOut)!,
          svgIcon: SvgIcons.logout,
          onPressed: () {
            AuthenticationBlocController().authenticationBloc.add(UserLogOut());
          }),
    ];
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
            Text(
              widget.admin.name,
              style: AppTextTheme.normalText(
                AppColor.text1,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            const CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage('assets/images/logo.png'),
            )
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
        item.onPressed;
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
