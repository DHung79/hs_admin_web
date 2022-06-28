enum ApiClient { me, local }

const ApiClient client = ApiClient.me;

class ApiConstants {
  static String get apiDomain {
    switch (client) {
      case ApiClient.me:
        return 'https://homeservicedev-348702.as.r.appspot.com';
      case ApiClient.local:
        return 'http://localhost:3000';
    }
  }

  static String apiVersion = '/api';
  static String services = '/services';
  static String otp = '/verify-otp';
  static String forgotPassword = '/forgot-password';
  static String resetPassword = '/reset-password';
  static String changePassword = '/change-password';

  // Dashboard
  static String me = '/me';
  // Users
  static String users = '/users';
  //Admins
  static String admins = '/admins';
  static String admin = '/admin';
  static String contacts = '/contacts';
  //Taskers
  static String taskers = '/taskers';
  static String tasks = '/tasks';
  static String checkEmail = '/check-email';
  static String pushNoti = '/notifications';
  static String upload = '/upload';
  static String notification = '/notification';
  static String read = '/read';
  static String unreadTotal = '/unreadTotal';
  static String all = '/all';
  static String fcmToken = '/fcm-token';
  static String statistical = '/statistical';
  static String provinceApi = 'https://provinces.open-api.vn/api/?depth=2';
}
