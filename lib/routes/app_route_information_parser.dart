import 'package:flutter/material.dart';
import 'route_names.dart';
import 'route_path.dart';

class AppRouteInforParser extends RouteInformationParser<AppRoutePath> {
  @override
  Future<AppRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    final name = uri.path;

    if (name == initialRoute) {
      return AppRoutePath.initial();
    }
    //authentication
    if (name == homeRoute) {
      return AppRoutePath.home();
    }

    if (name == authenticationRoute) {
      return AppRoutePath.authentication();
    }

    if (name == forgotPasswordRoute) {
      return AppRoutePath.forgotPassword();
    }

    if (name == otpRoute) {
      return AppRoutePath.otp();
    }

    if (name == resetPasswordRoute) {
      return AppRoutePath.resetPassword();
    }

    if (name == userManagementRoute) {
      return AppRoutePath.userManagement();
    }

    if (name == createUserRoute) {
      return AppRoutePath.createUser();
    }

    if (name.startsWith(editUserRoute)) {
      if (name.length > editUserRoute.length) {
        final id = name.substring(editUserRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.editUser(id);
      }
      return AppRoutePath.userManagement();
    }

    if (name.startsWith(userInfoRoute)) {
      if (name.length > userInfoRoute.length) {
        final id = name.substring(userInfoRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.userInfo(id);
      }
      return AppRoutePath.userManagement();
    }

    if (name == taskerManagementRoute) {
      return AppRoutePath.taskerManagement();
    }

    if (name == createTaskerRoute) {
      return AppRoutePath.createTasker();
    }

    if (name.startsWith(editTaskerRoute)) {
      if (name.length > editTaskerRoute.length) {
        final id = name.substring(editTaskerRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.editTasker(id);
      }
      return AppRoutePath.taskerManagement();
    }

    if (name.startsWith(taskerInfoRoute)) {
      if (name.length > taskerInfoRoute.length) {
        final id = name.substring(taskerInfoRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.taskerInfo(id);
      }
      return AppRoutePath.taskerManagement();
    }

    if (name == serviceManageRoute) {
      return AppRoutePath.serviceManage();
    }

    if (name == orderManageRoute) {
      return AppRoutePath.orderManage();
    }

    if (name == notificationManageRoute) {
      return AppRoutePath.notificationManage();
    }

    if (name == payManageRoute) {
      return AppRoutePath.payManage();
    }

    if (name == settingManageRoute) {
      return AppRoutePath.settingManage();
    }

    return AppRoutePath.unknown();
  }

  @override
  RouteInformation restoreRouteInformation(AppRoutePath configuration) {
    if (configuration.isUnknown) {
      return const RouteInformation(location: pageNotFoundRoute);
    }
    return RouteInformation(location: configuration.name);
  }
}
