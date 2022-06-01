import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/notification_manage/add_notification.dart';
import '../screens/order_manage/info_order.dart';
import '../screens/service_manage/add_service.dart';
import '../screens/service_manage/detail_service.dart';
import '../screens/setting_manage/contact_info.dart';
import '../screens/setting_manage/edit_contact.dart';
import '../screens/setting_manage/profile_edit.dart';
import '../screens/setting_manage/profile_setting.dart';
import '../screens/notification_manage/notifcation_manage.dart';
import '../screens/onboarding/authentication.dart';
import '../screens/not_found/page_not_found_screen.dart';
import '../screens/order_manage/order_manage.dart';
import '../screens/pay_manage/pay_manage.dart';
import '../screens/service_manage/service_manage.dart';
import '../screens/setting_manage/setting_manage.dart';
import '../screens/tasker_manage/info_tasker.dart';
import '../screens/tasker_manage/tasker_manage.dart';
import '../screens/user_management_screen/components/info_user.dart';
import '../screens/user_management_screen/user_management_screen.dart';
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
    if (route == initialRoute || route == homeRoute) {
      return const HomeScreen();
    }
    if (route == authenticationRoute) {
      return const AuthenticationScreen();
    }
    if (route == forgotPasswordRoute) {
      return const AuthenticationScreen();
    }
    if (route == otpRoute) {
      return const AuthenticationScreen();
    }
    if (route == resetPasswordRoute) {
      return const AuthenticationScreen();
    }
    if (route == userManagementRoute) {
      return const UserManageScreen();
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
      return const ServiceManage();
    }
    if (route == addServiceRoute) {
      return const AddService();
    }
    if (route == detailServiceRoute) {
      return const DetailService();
    }
    if (route == orderManageRoute) {
      return const OrderManage();
    }
    if (route == infoOrderRoute) {
      return const InfoOrder();
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
