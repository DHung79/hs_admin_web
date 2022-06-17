import '/core/contact/model/contact_model.dart';
import '/core/task/model/task_model.dart';
import '/core/admin/model/admin_model.dart';
import '/core/authentication/models/status.dart';
import '/core/user/model/user_model.dart';
import '/core/logger/logger.dart';
import '/core/service/service.dart';
import '/core/tasker/model/tasker_model.dart';

class ApiError implements Exception {
  String _errorCode = '';
  String _errorMessage = '';

  ApiError.fromJson(Map<String, dynamic>? parsedJson) {
    if (parsedJson?['error_code'] != null) {
      _errorCode = parsedJson?['error_code']?.toString() ?? '';
    }
    _errorMessage = parsedJson?['error_message'] ?? '';
  }

  String get errorCode => _errorCode;
  String get errorMessage => _errorMessage;

  @override
  String toString() {
    return _errorMessage;
  }
}

class ApiResponse<T> {
  ApiError? _error;
  T? _model;

  ApiResponse(T? m, ApiError? e) {
    _model = m;
    _error = e;
  }

  ApiError? get error => _error;
  T? get model => _model;
}

class BaseModel {
  static T fromJson<T extends BaseModel>(Map<String, dynamic> json) {
    if (T == Status) {
      return Status.fromJson(json) as T;
    }
    if (T == UserModel) {
      return UserModel.fromJson(json) as T;
    }
    if (T == ListUserModel) {
      return ListUserModel.fromJson(json) as T;
    }

    if (T == AdminModel) {
      return AdminModel.fromJson(json) as T;
    }
    if (T == ListAdminModel) {
      return ListAdminModel.fromJson(json) as T;
    }
    if (T == TaskerModel) {
      return TaskerModel.fromJson(json) as T;
    }
    if (T == ListTaskerModel) {
      return ListTaskerModel.fromJson(json) as T;
    }
    if (T == ServiceModel) {
      return ServiceModel.fromJson(json) as T;
    }
    if (T == ListServiceModel) {
      return ListServiceModel.fromJson(json) as T;
    }

    if (T == CategoryModel) {
      return CategoryModel.fromJson(json) as T;
    }
    if (T == TranslationModel) {
      return TranslationModel.fromJson(json) as T;
    }
    if (T == OptionsModel) {
      return OptionsModel.fromJson(json) as T;
    }
    if (T == OtpModel) {
      return OtpModel.fromJson(json) as T;
    }
    if (T == PriceModel) {
      return PriceModel.fromJson(json) as T;
    }
    if (T == TaskModel) {
      return TaskModel.fromJson(json) as T;
    }
    if (T == ListTaskModel) {
      return ListTaskModel.fromJson(json) as T;
    }
    if (T == LocationModel) {
      return LocationModel.fromJson(json) as T;
    }
    if (T == SupportContactModel) {
      return SupportContactModel.fromJson(json) as T;
    }
    if (T == ContactModel) {
      return ContactModel.fromJson(json) as T;
    }
    if (T == PaymentModel) {
      return PaymentModel.fromJson(json) as T;
    }
    logError("Unknown BaseModel class: $T");
    throw Exception("Unknown BaseModel class: $T");
  }

  static List<T> mapList<T extends BaseModel>({
    required Map<String, dynamic> json,
    required String key,
    String defaultKey = '_id',
  }) {
    final _results = <T>[];
    if (json[key] != null && json[key] is List<dynamic>) {
      for (var val in json[key]) {
        if (val is String) {
          _results.add(BaseModel.fromJson<T>({defaultKey: val}));
        } else if (val is Map<String, dynamic>) {
          _results.add(BaseModel.fromJson<T>(val));
        } else {
          _results.add(BaseModel.fromJson<T>({}));
        }
      }
    }
    return _results;
  }

  static T listDynamic<T extends BaseModel>(List<dynamic> list) {
    // if (T == ListRoleModel) {
    //   return ListRoleModel.listDynamic(list) as T;
    // }

    logError("Unknown BaseModel class: $T");
    throw Exception("Unknown BaseModel class: $T");
  }

  static T map<T extends BaseModel>({
    required Map<String, dynamic> json,
    required String key,
    String defaultKey = '_id',
  }) {
    if (json.containsKey(key)) {
      final _val = json[key];
      if (_val is String) {
        return BaseModel.fromJson<T>({defaultKey: _val});
      } else if (_val is Map<String, dynamic>) {
        return BaseModel.fromJson<T>(_val);
      }
    }
    return BaseModel.fromJson({});
  }
}

class EditBaseModel {
  static T fromModel<T extends EditBaseModel>(BaseModel model) {
    if (T == EditUserModel) {
      return EditUserModel.fromModel(model as UserModel) as T;
    }
    if (T == EditTaskerModel) {
      return EditTaskerModel.fromModel(model as TaskerModel) as T;
    }
    if (T == EditServiceModel) {
      return EditServiceModel.fromModel(model as ServiceModel) as T;
    }
    logError("Unknown EditBaseModel class: $T");
    throw Exception("Unknown EditBaseModel class: $T");
  }

  static Map<String, dynamic> toCreateJson(EditBaseModel model) {
    if (model is EditServiceModel) {
      return model.toCreateJson();
    }
    if (model is EditUserModel) {
      return model.toCreateJson();
    }
    if (model is EditTaskerModel) {
      return model.toCreateJson();
    }
    return {};
  }

  static Map<String, dynamic> toEditProfileJson(EditBaseModel model) {
    if (model is EditAdminModel) {
      return model.toEditInfoJson();
    }
    return {};
  }

  static Map<String, dynamic> toEditJson(EditBaseModel model) {
    if (model is EditServiceModel) {
      return model.toEditJson();
    }
    if (model is EditUserModel) {
      return model.toEditJson();
    }
    if (model is EditTaskerModel) {
      return model.toEditJson();
    }
    if (model is EditAdminModel) {
      return model.toEditJson();
    }
    return {};
  }
}
