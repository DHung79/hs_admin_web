import 'package:flutter/material.dart';
import 'package:hs_admin_web/main.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../../theme/app_theme.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  bool isMini = false;
  @override
  Widget build(BuildContext context) {
    final List<SideBarItem> _sideBarItems = [
      SideBarItem(
        icon: SvgIcons.group,
        title: 'Quản lí người dùng',
        route: userManagementRoute,
      ),
      SideBarItem(
        icon: SvgIcons.broom,
        title: 'Quản lí người giúp việc',
        route: taskerManageRoute,
      ),
      SideBarItem(
        icon: SvgIcons.listCheck,
        title: 'Quản lí dịch vụ',
        route: serviceManageRoute,
      ),
      SideBarItem(
        icon: SvgIcons.noteblockTextLine,
        title: 'Quản lí đặt hàng',
        route: orderManageRoute,
      ),
      SideBarItem(
        title: 'Quản lí thông báo đẩy',
        icon: SvgIcons.bellRing,
        route: notificationManageRoute,
      ),
      SideBarItem(
        icon: SvgIcons.wallet,
        title: 'Quản lí thanh toán',
        route: payManageRoute,
      ),
      SideBarItem(
        icon: SvgIcons.settingTwo,
        title: 'Cài đặt',
        route: settingManageRoute,
      ),
    ];
    final screenSize = MediaQuery.of(context).size;
    if (screenSize.width < 1000) {
      isMini = true;
    }
    return Container(
      width: isMini ? 119 : 356,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Image.asset(
                'assets/images/logo_white.png',
                width: 100,
              ),
            ),
            if (!isMini)
              const SizedBox(
                height: 16,
              ),
            SizedBox(
              height: screenSize.height - 200,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: _sideBarItems.length,
                itemBuilder: (context, index) {
                  final item = _sideBarItems[index];
                  return _buildItem(
                    svgIcon: item.icon,
                    title: item.title,
                    active: selectedPage == index,
                    onPressed: () {
                      setState(() {
                        selectedPage = index;
                        navigateTo(item.route);
                      });
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: isMini ? EdgeInsets.zero : const EdgeInsets.all(8),
                    child: _buildItem(
                      svgIcon: SvgIcons.sidebarLeft,
                      title: 'Thu nhỏ',
                      active: false,
                      mainAxisAlignment: isMini
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.end,
                      onPressed: () {
                        setState(() {
                          isMini = !isMini;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({
    IconData? icon,
    SvgIconData? svgIcon,
    Function()? onPressed,
    required bool active,
    required String title,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 0),
      child: InkWell(
        splashFactory: NoSplash.splashFactory,
        onTap: onPressed,
        // splashColor: Colors.white,
        highlightColor: Colors.transparent,
        hoverColor: Colors.white12,
        child: Container(
          constraints: const BoxConstraints(minHeight: 56),
          child: Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              icon != null
                  ? Icon(
                      icon,
                      size: 24,
                      color: active ? AppColor.shade6 : AppColor.text7,
                    )
                  : SvgIcon(
                      svgIcon,
                      size: 24,
                      color: active ? AppColor.shade6 : AppColor.text7,
                    ),
              if (!isMini)
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Text(
                    title,
                    style: AppTextTheme.normalText(
                      active ? AppColor.shade6 : AppColor.text7,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class SideBarItem {
  final SvgIconData icon;
  final String title;
  final String route;
  SideBarItem({
    required this.icon,
    required this.title,
    required this.route,
  });
}
