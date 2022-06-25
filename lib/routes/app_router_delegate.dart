import 'package:flutter/material.dart';
import 'package:hs_admin_web/screens/push_noti_management_screen/push_noti_management_screen.dart';
import '../screens/setting_screen/setting_screen.dart';
import '../screens/task_management_screen/task_management_screen.dart';
import '../screens/service_management_screen/service_management_screen.dart';
import '../screens/onboarding/authentication_screen.dart';
import '../screens/not_found/page_not_found_screen.dart';
import '../screens/pay_manage/pay_manage.dart';
import '../screens/tasker_management_screen/tasker_management_screen.dart';
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
    if (route == initialRoute) {
      return const UserManagementScreen();
    }
    if (route == authenticationRoute) {
      return const AuthenticationScreen();
    }
    if (route == forgotPasswordRoute) {
      return const AuthenticationScreen(form: 1);
    }
    if (route == otpRoute) {
      return const AuthenticationScreen(form: 2);
    }
    if (route == resetPasswordRoute) {
      return const AuthenticationScreen(form: 3);
    }

    if (route == userManagementRoute) {
      return const UserManagementScreen();
    }
    if (route == createUserRoute) {
      return const UserManagementScreen(tab: 1);
    }
    if (route.startsWith(editUserRoute)) {
      if (route.length > editUserRoute.length) {
        final id = route.substring(editUserRoute.length + 1, route.length);
        if (id.isNotEmpty) return UserManagementScreen(id: id, tab: 3);
      }
      return const UserManagementScreen();
    }
    if (route.startsWith(userInfoRoute)) {
      if (route.length > userInfoRoute.length) {
        final id = route.substring(userInfoRoute.length + 1, route.length);
        if (id.isNotEmpty) return UserManagementScreen(id: id, tab: 2);
      }
      return const UserManagementScreen();
    }

    if (route == taskerManagementRoute) {
      return const TaskerManagementScreen();
    }
    if (route == createTaskerRoute) {
      return const TaskerManagementScreen(tab: 1);
    }
    if (route.startsWith(editTaskerRoute)) {
      if (route.length > editTaskerRoute.length) {
        final id = route.substring(editTaskerRoute.length + 1, route.length);
        if (id.isNotEmpty) return TaskerManagementScreen(id: id, tab: 3);
      }
      return const TaskerManagementScreen();
    }
    if (route.startsWith(taskerInfoRoute)) {
      if (route.length > taskerInfoRoute.length) {
        final id = route.substring(taskerInfoRoute.length + 1, route.length);
        if (id.isNotEmpty) return TaskerManagementScreen(id: id, tab: 2);
      }
      return const TaskerManagementScreen();
    }

    if (route == serviceManagementRoute) {
      return const ServiceManagementScreen();
    }
    if (route == createServiceRoute) {
      return const ServiceManagementScreen(tab: 1);
    }
    if (route.startsWith(editServiceRoute)) {
      if (route.length > editServiceRoute.length) {
        final id = route.substring(editServiceRoute.length + 1, route.length);
        if (id.isNotEmpty) return ServiceManagementScreen(id: id, tab: 3);
      }
      return const ServiceManagementScreen();
    }
    if (route.startsWith(serviceDetailRoute)) {
      if (route.length > serviceDetailRoute.length) {
        final id = route.substring(serviceDetailRoute.length + 1, route.length);
        if (id.isNotEmpty) return ServiceManagementScreen(id: id, tab: 2);
      }
      return const ServiceManagementScreen();
    }

    if (route == tasksRoute) {
      return const TaskManagementScreen();
    }
    if (route.startsWith(taskDetailRoute)) {
      if (route.length > taskDetailRoute.length) {
        final id = route.substring(taskDetailRoute.length + 1, route.length);
        if (id.isNotEmpty) return TaskManagementScreen(id: id);
      }
      return const TaskManagementScreen();
    }

    if (route == pushNotiManagementRoute) {
      return const PushNotiManagementScreen();
    }
    if (route == createPushNotiRoute) {
      return const PushNotiManagementScreen(tab: 1);
    }
    if (route.startsWith(editPushNotiRoute)) {
      if (route.length > editPushNotiRoute.length) {
        final id = route.substring(editPushNotiRoute.length + 1, route.length);
        if (id.isNotEmpty) return PushNotiManagementScreen(id: id, tab: 2);
      }
      return const PushNotiManagementScreen();
    }

    if (route == payManagementRoute) {
      return const PayManage();
    }

    if (route == settingRoute) {
      return const SettingScreen();
    }
    if (route == profileRoute) {
      return const SettingScreen(tab: 1);
    }
    if (route == editProfileRoute) {
      return const SettingScreen(tab: 3);
    }
    if (route == contactRoute) {
      return const SettingScreen(tab: 2);
    }
    if (route == editContactRoute) {
      return const SettingScreen(tab: 4);
    }

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
