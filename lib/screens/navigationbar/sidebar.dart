import 'package:flutter/material.dart';
import 'package:hs_admin_web/main.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../theme/app_theme.dart';
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
      ),
      SideBarItem(
        icon: SvgIcons.clean,
        title: 'Quản lí người giúp việc',
      ),
      SideBarItem(
        icon: SvgIcons.checkList,
        title: 'Quản lí dịch vụ',
      ),
      SideBarItem(
        icon: SvgIcons.note,
        title: 'Quản lí đặt hàng',
      ),
      SideBarItem(
        title: 'Quản lí thông báo đẩy',
        icon: SvgIcons.noti,
      ),
      SideBarItem(
        icon: SvgIcons.wallet,
        title: 'Quản lí thanh toán',
      ),
      SideBarItem(
        icon: SvgIcons.setting,
        title: 'Cài đặt',
      ),
    ];
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      color: Colors.white,
      child: Column(
        children: [
          Image.asset(
            'assets/images/logodemo.png',
            width: 100,
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
                    if (selectedPage == 0) {
                      navigateTo(userManageRoute);
                      
                    } else if (selectedPage == 1) {
                      navigateTo(taskerManageRoute);
                    } else if (selectedPage == 2) {
                      navigateTo(serviceManageRoute);
                    } else if (selectedPage == 3) {
                      navigateTo(orderManageRoute);
                    } else if (selectedPage == 4) {
                      navigateTo(notificationManageRoute);
                    } else if (selectedPage == 5) {
                      navigateTo(payManageRoute);
                    } else {
                      navigateTo(settingManageRoute);
                    }
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
  SideBarItem({
    required this.icon,
    required this.title,
  });
}
