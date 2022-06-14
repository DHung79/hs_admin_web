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

  AppRoutePath.userManagement()
      : name = userManagementRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.createUser()
      : name = createUserRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.editUser(String id)
      : name = editUserRoute + id,
        routeId = '',
        isUnknown = false;

  AppRoutePath.userInfo(String id)
      : name = userInfoRoute + id,
        routeId = '',
        isUnknown = false;

  AppRoutePath.taskerManagement()
      : name = taskerManagementRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.createTasker()
      : name = createTaskerRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.editTasker(String id)
      : name = editTaskerRoute + id,
        routeId = '',
        isUnknown = false;

  AppRoutePath.taskerInfo(String id)
      : name = taskerInfoRoute + id,
        routeId = '',
        isUnknown = false;

  AppRoutePath.serviceManagement()
      : name = serviceManagementRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.createService()
      : name = createServiceRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.editService(String id)
      : name = editServiceRoute + id,
        routeId = '',
        isUnknown = false;

  AppRoutePath.serviceDetail(String id)
      : name = serviceDetailRoute + id,
        routeId = '',
        isUnknown = false;

  AppRoutePath.tasks()
      : name = tasksRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.taskDetail(String id)
      : name = taskDetailRoute + id,
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
      : name = payManagementRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.setting()
      : name = settingRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.profile()
      : name = profileRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.editProfile()
      : name = editProfileRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.contact()
      : name = contactRoute,
        routeId = '',
        isUnknown = false;

  AppRoutePath.editContact()
      : name = editContactRoute,
        routeId = '',
        isUnknown = false;

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

    if (name == userManagementRoute) {
      return AppRoutePath.userManagement();
    }
    if (name == createUserRoute) {
      return AppRoutePath.createUser();
    }
    if (name != null && name.startsWith(editUserRoute)) {
      if (name.length > editUserRoute.length) {
        final id = name.substring(editUserRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.editUser(id);
      }
      return AppRoutePath.userManagement();
    }
    if (name != null && name.startsWith(userInfoRoute)) {
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
    if (name != null && name.startsWith(editTaskerRoute)) {
      if (name.length > editTaskerRoute.length) {
        final id = name.substring(editTaskerRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.editTasker(id);
      }
      return AppRoutePath.taskerManagement();
    }
    if (name != null && name.startsWith(taskerInfoRoute)) {
      if (name.length > taskerInfoRoute.length) {
        final id = name.substring(taskerInfoRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.taskerInfo(id);
      }
      return AppRoutePath.taskerManagement();
    }

    if (name == serviceManagementRoute) {
      return AppRoutePath.serviceManagement();
    }
    if (name == createServiceRoute) {
      return AppRoutePath.createService();
    }
    if (name != null && name.startsWith(editServiceRoute)) {
      if (name.length > editServiceRoute.length) {
        final id = name.substring(editServiceRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.editService(id);
      }
      return AppRoutePath.serviceManagement();
    }
    if (name != null && name.startsWith(serviceDetailRoute)) {
      if (name.length > serviceDetailRoute.length) {
        final id = name.substring(serviceDetailRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.serviceDetail(id);
      }
      return AppRoutePath.serviceManagement();
    }

    if (name == tasksRoute) {
      return AppRoutePath.tasks();
    }
    if (name != null && name.startsWith(taskDetailRoute)) {
      if (name.length > taskDetailRoute.length) {
        final id = name.substring(taskDetailRoute.length, name.length);
        if (id.isNotEmpty) return AppRoutePath.taskDetail(id);
      }
      return AppRoutePath.tasks();
    }

    if (name == notificationManageRoute) {
      return AppRoutePath.notificationManage();
    }
    if (name == addNotificationRoute) {
      return AppRoutePath.addNotification();
    }
    if (name == payManagementRoute) {
      return AppRoutePath.payManage();
    }
    
    if (name == settingRoute) {
      return AppRoutePath.setting();
    }
    if (name == profileRoute) {
      return AppRoutePath.profile();
    }
    if (name == editProfileRoute) {
      return AppRoutePath.editProfile();
    }
    if (name == contactRoute) {
      return AppRoutePath.contact();
    }
    if (name == editContactRoute) {
      return AppRoutePath.editContact();
    }
    return AppRoutePath.unknown();
  }
}
