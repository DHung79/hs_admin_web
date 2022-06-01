import 'route_names.dart';

class AppRoutePath {
  final String? name;
  final String routeId;
  final bool isUnknown;

  AppRoutePath.initial()
      : name = initialRoute,
        routeId = '',
        isUnknown = false;
  //authentication
  AppRoutePath.authentication()
      : name = authenticationRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.home()
      : name = homeRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.forgotPassword()
      : name = forgotPasswordRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.otp()
      : name = otpRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.resetPassword()
      : name = resetPasswordRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.userManage()
      : name = userManageRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.addUser()
      : name = addUserRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.taskerManage()
      : name = taskerManageRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.infoTasker()
      : name = inforTaskerRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.serviceManage()
      : name = serviceManageRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.addService()
      : name = addServiceRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.detailService()
      : name = detailServiceRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.orderManage()
      : name = orderManageRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.infoOrder()
      : name = infoOrderRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.notificationManage()
      : name = notificationManageRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.addNotification()
      : name = addNotificationRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.payManage()
      : name = payManageRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.settingManage()
      : name = settingManageRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.contactInfo()
      : name = contactInfoRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.editContact()
      : name = editContactRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.profileSetting()
      : name = profileSettingRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.editProfile()
      : name = editProfileRoute,
        routeId = '',
        isUnknown = false;

  // AppRoutePath.roles()
  //     : name = roleRoute,
  //       routeId = '',
  //       isUnknown = false;
  // AppRoutePath.createRoles()
  //     : name = createRoleRoute,
  //       routeId = '',
  //       isUnknown = false;
  // AppRoutePath.editRoles(String id)
  //     : name = editRoleRoute + id,
  //       routeId = '',
  //       isUnknown = false;

  AppRoutePath.unknown()
      : name = null,
        routeId = '',
        isUnknown = true;

  static AppRoutePath routeFrom(String? name) {
    if (name == initialRoute) {
      return AppRoutePath.initial();
    }
    //authentication
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
    if (name == homeRoute) {
      return AppRoutePath.home();
    }
    if (name == userManageRoute) {
      return AppRoutePath.userManage();
    }
    if (name == addUserRoute) {
      return AppRoutePath.addUser();
    }
    if (name == taskerManageRoute) {
      return AppRoutePath.taskerManage();
    }
    if (name == inforTaskerRoute) {
      return AppRoutePath.infoTasker();
    }
    if (name == serviceManageRoute) {
      return AppRoutePath.serviceManage();
    }
    if (name == addServiceRoute) {
      return AppRoutePath.addService();
    }
    if (name == detailServiceRoute) {
      return AppRoutePath.detailService();
    }
    if (name == orderManageRoute) {
      return AppRoutePath.orderManage();
    }
    if (name == infoOrderRoute) {
      return AppRoutePath.infoOrder();
    }
    if (name == notificationManageRoute) {
      return AppRoutePath.notificationManage();
    }
    if (name == addNotificationRoute) {
      return AppRoutePath.addNotification();
    }
    if (name == payManageRoute) {
      return AppRoutePath.payManage();
    }
    if (name == settingManageRoute) {
      return AppRoutePath.settingManage();
    }
    if (name == profileSettingRoute) {
      return AppRoutePath.profileSetting();
    }
    if (name == contactInfoRoute) {
      return AppRoutePath.contactInfo();
    }
    if (name == editContactRoute) {
      return AppRoutePath.editContact();
    }
    if (name == editProfileRoute) {
      return AppRoutePath.editProfile();
    }

    // if (name == roleRoute) {
    //   return AppRoutePath.roles();
    // }
    // if (name == createRoleRoute) {
    //   return AppRoutePath.createRoles();
    // }
    // if (name != null && name.startsWith(editRoleRoute)) {
    //   if (name.length > editRoleRoute.length) {
    //     final id = name.substring(editRoleRoute.length, name.length);
    //     if (id.isNotEmpty) return AppRoutePath.editRoles(id);
    //   }
    //   return AppRoutePath.roles();
    // }
    return AppRoutePath.unknown();
  }
}
