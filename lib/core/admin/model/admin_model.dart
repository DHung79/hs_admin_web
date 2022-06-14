import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class AdminModel extends BaseModel {
  final String __id;
  final String _name;
  final String _email;
  final String _address;
  final String _phoneNumber;
  final String _gender;
  final bool _superAdmin;
  final int _createdTime;
  final int _updatedTime;
  String _password;
  AdminModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _name = json['name'] ?? '',
        _email = json['email'] ?? '',
        _address = json['address'] ?? '',
        _phoneNumber = json['phoneNumber'] ?? '',
        _gender = json['gender'] ?? '',
        _superAdmin = json['super_admin'] ?? false,
        _createdTime = json['created_time'],
        _updatedTime = json['updated_time'],
        _password = '';

  Map<String, dynamic> toJson() => {
        "_id": __id,
        "name": _name,
        "email": _email,
        "address": _address,
        "phoneNumber": _phoneNumber,
        "gender": _gender,
        "super_admin": _superAdmin,
        "created_time": _createdTime,
        "updated_time": _updatedTime,
      };

  String get id => __id;
  String get name => _name;
  String get email => _email;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  String get gender => _gender;
  bool get superAdmin => _superAdmin;
  int get createdTime => _createdTime;
  int get updatedTime => _updatedTime;
  String get password => _password;
  set password(value) {
    _password = value;
  }
}

class EditAdminModel extends EditBaseModel {
  String id = ''; // For editing
  String name = '';
  String email = '';
  String address = '';
  String phoneNumber = '';
  String gender = '';
  String password = '';
  String newPassword = '';

  EditAdminModel.fromModel(AdminModel? model) {
    id = model?.id ?? '';
    name = model?.name ?? '';
    email = model?.email ?? '';
    address = model?.address ?? '';
    phoneNumber = model?.phoneNumber ?? '';
    gender = model?.gender ?? 'Male';
    password = model?.password ?? '';
    newPassword = '';
  }

  Map<String, dynamic> toEditInfoJson() {
    Map<String, dynamic> params = {
      'name': name,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'gender': gender,
    };
    return params;
  }

  Map<String, dynamic> toEditJson() {
    Map<String, dynamic> params = {
      'id': id,
      'name': name,
      'email': email,
      'address': address,
      'phone_number': phoneNumber,
      'gender': gender,
    };

    return params;
  }
}

class ListAdminModel extends BaseModel {
  List<AdminModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListAdminModel.fromJson(Map<String, dynamic> parsedJson) {
    List<AdminModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<AdminModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromJson(parsedJson['meta_data']);
  }

  List<AdminModel> get records => _data;
  Paging get meta => _metaData;
}
