import 'package:flutter/material.dart';
import 'package:hs_admin_web/main.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../../theme/app_theme.dart';
import 'sidebar_item.dart';

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    final List<SideBarItem> _sideBarItems = [
      SideBarItem(
        icon: SvgIcons.group,
        title: 'Quản lí người dùng',
        route: userManagementRoute,
      ),
      SideBarItem(
        icon: SvgIcons.clean,
        title: 'Quản lí người giúp việc',
        route: taskerManageRoute,
      ),
      SideBarItem(
        icon: SvgIcons.checkList,
        title: 'Quản lí dịch vụ',
        route: serviceManageRoute,
      ),
      SideBarItem(
        icon: SvgIcons.note,
        title: 'Quản lí đặt hàng',
        route: orderManageRoute,
      ),
      SideBarItem(
        title: 'Quản lí thông báo đẩy',
        icon: SvgIcons.noti,
        route: notificationManageRoute,
      ),
      SideBarItem(
        icon: SvgIcons.wallet,
        title: 'Quản lí thanh toán',
        route: payManageRoute,
      ),
      SideBarItem(
        icon: SvgIcons.setting,
        title: 'Cài đặt',
        route: settingManageRoute,
      ),
    ];
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 32, 0, 0),
            child: Image.asset(
              'assets/images/logodemo.png',
              width: 100,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _sideBarItems.length,
            itemBuilder: (context, index) {
              final item = _sideBarItems[index];
              return SideBarButton(
                icon: item.icon,
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
        ],
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
