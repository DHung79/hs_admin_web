import 'package:flutter/material.dart';
import 'package:hs_admin_web/screens/notification_manage/add_notification.dart';
import 'package:hs_admin_web/screens/order_manage/info_order.dart';
import 'package:hs_admin_web/screens/service_manage/add_service.dart';
import 'package:hs_admin_web/screens/service_manage/detail_service.dart';
import 'package:hs_admin_web/screens/setting_manage/contact_info.dart';
import 'package:hs_admin_web/screens/setting_manage/edit_contact.dart';
import 'package:hs_admin_web/screens/setting_manage/profile_edit.dart';
import 'package:hs_admin_web/screens/setting_manage/profile_setting.dart';
import 'package:hs_admin_web/screens/user_manage/add_user.dart';
import 'package:hs_admin_web/screens/user_manage/user_manage.dart';
import '../screens/change_password_page.dart';
import '../screens/forgot_password_page.dart';
import '../screens/notification_manage/notifcation_manage.dart';
import '../screens/onboarding/authentication.dart';
import '../screens/not_found/page_not_found_screen.dart';
import '../screens/order_manage/order_manage.dart';
import '../screens/pay_manage/pay_manage.dart';
import '../screens/service_manage/service_manage.dart';
import '../screens/setting_manage/setting_manage.dart';
import '../screens/tasker_manage/info_tasker.dart';
import '../screens/tasker_manage/tasker_manage.dart';
import '../screens/user_manage/edit_user.dart';
import '../screens/user_manage/info_user.dart';
import 'no_animation_transition_delegate.dart';
import 'route_names.dart';
import 'route_path.dart';

class AppRouterDelegate extends RouterDelegate<AppRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  AppRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  String _routePath = '';

  @override
  AppRoutePath get currentConfiguration => AppRoutePath.routeFrom(_routePath);

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      transitionDelegate: NoAnimationTransitionDelegate(),
      pages: [
        _pageFor(_routePath),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        notifyListeners();

        return true;
      },
    );
  }

  _pageFor(String route) {
    return MaterialPage(
      key: const ValueKey('HomeService'),
      child: _screenFor(route),
    );
  }

  _screenFor(String route) {
    if (route == initialRoute || route == authenticationRoute) {
      return const LoginPage();
    }

    if (route == userManageRoute) {
      return const UserManage();
    }

    if (route == addUserRoute) {
      return const InfoUser();
    }

    if (route == inforTaskerRoute) {
      return const InfoTasker();
    }

    if (route == taskerManageRoute) {
      return const TaskerManage();
    }

    if (route == serviceManageRoute) {
      return ServiceManage();
    }
    if (route == addServiceRoute) {
      return const AddService();
    }
    if (route == detailServiceRoute) {
      return const DetailService();
    }

    if (route == orderManageRoute) {
      return OrderManage();
    }
    if (route == infoOrderRoute) {
      return InfoOrder();
    }

    if (route == notificationManageRoute) {
      return const NotificationManage();
    }
    if (route == addNotificationRoute) {
      return const AddNotification();
    }

    if (route == payManageRoute) {
      return const PayManage();
    }

    if (route == settingManageRoute) {
      return const Setting();
    }
    if (route == profileSettingRoute) {
      return const ProfileSetting();
    }
    if (route == contactInfoRoute) {
      return const ContactInfo();
    }
    if (route == editContactRoute) {
      return const EditContact();
    }
    if (route == editProfileRoute) {
      return const EditProfile();
    }

    if (route == forgotPasswordRoute) {
      return const ForgotPassWord();
    }

    if (route == changePasswordRoute) {
      return const ChangePassword();
    }

    // if (route == roleRoute) {
    //   return const UserManagementScreen(tab: 1);
    // }
    // if (route == createRoleRoute) {
    //   return const UserManagementScreen();
    // }
    // if (route.startsWith(editRoleRoute)) {
    //   if (route.length > editRoleRoute.length) {
    //     final id = route.substring(editRoleRoute.length + 1, route.length);
    //     if (id.isNotEmpty) return UserManagementScreen(id: id);
    //   }
    //   return const UserManagementScreen(tab: 1);
    // }

    return PageNotFoundScreen(route);
  }

  @override
  Future<void> setNewRoutePath(AppRoutePath configuration) async {
    _routePath = configuration.name!;
  }

  void navigateTo(String name) {
    _routePath = name;
    notifyListeners();
  }
}
