import 'package:hs_admin_web/main.dart';

import '../../rest/models/rest_api_response.dart';

class Status extends BaseModel {
  String status = '';

  Status.fromJson(Map<String, dynamic>? json) {
    status = json?['status'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'status': status,
    };
    return data;
  }
}

class OtpModel extends BaseModel {
  String userId = '';

  OtpModel.fromJson(Map<String, dynamic>? json) {
    userId = json?['admin']['_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      'user_id': userId,
    };
    return data;
  }
}
