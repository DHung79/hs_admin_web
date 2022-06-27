import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';
import '../../service/service.dart';
import '../../tasker/tasker.dart';
import '../../user/user.dart';

class TaskModel extends BaseModel {
  final LocationModel? _location;
  final UserModel? _user;
  final TaskerModel? _tasker;
  final ServiceModel? _service;
  final String __id;
  final String _address;
  final String _estimateTime;
  final int? _startTime;
  final int? _endTime;
  final int? _date;
  final String _note;
  final int? _status;
  final int? _language;
  final int? _failureReason;
  final int? _typeHome;
  final bool _isDeleted;
  final int? _deletedTime;
  final int? _createdTime;
  final int? _updatedTime;
  final int? _totalPrice;

  TaskModel.fromJson(Map<String, dynamic> json)
      : _location = BaseModel.map<LocationModel>(
          json: json,
          key: 'location_gps',
        ),
        _user = BaseModel.map<UserModel>(
          json: json,
          key: 'posted_user',
        ),
        _tasker = BaseModel.map<TaskerModel>(
          json: json,
          key: 'tasker',
        ),
        _service = BaseModel.map<ServiceModel>(
          json: json,
          key: 'service',
        ),
        __id = json['_id'] ?? '',
        _address = json['address'] ?? '',
        _estimateTime = json['estimate_time'] ?? '',
        _startTime = json['start_time'],
        _endTime = json['end_time'],
        _date = json['date'],
        _note = json['note'] ?? '',
        _status = json['status'],
        _language = json['language'],
        _failureReason = json['failure_reason'],
        _typeHome = json['type_home'],
        _isDeleted = json['is_deleted'] ?? false,
        _deletedTime = json['deleted_time'],
        _createdTime = json['created_time'],
        _updatedTime = json['updated_time'],
        _totalPrice = json['total_price'];

  Map<String, dynamic> toJson() => {
        'location_gps': _location?.toJson(),
        'posted_user': _user?.toJson(),
        'tasker': _tasker?.toJson(),
        'service': _service?.toJson(),
        '_id': __id,
        'address': _address,
        'estimate_time': _estimateTime,
        'start_time': _startTime,
        'end_time': _endTime,
        'date': _date,
        'note': _note,
        'status': _status,
        'language': _language,
        'failure_reason': _failureReason,
        'type_home': _typeHome,
        'is_deleted': _isDeleted,
        'deleted_time': _deletedTime,
        'created_time': _createdTime,
        'updated_time': _updatedTime,
      };

  LocationModel? get location => _location;
  UserModel? get user => _user;
  TaskerModel? get tasker => _tasker;
  ServiceModel? get service => _service;
  String get id => __id;
  String get address => _address;
  String get estimateTime => _estimateTime;
  int? get startTime => _startTime;
  int? get endTime => _endTime;
  int? get date => _date;
  String get note => _note;
  int? get status => _status;
  int? get language => _language;
  int? get failureReason => _failureReason;
  int? get typeHome => _typeHome;
  bool get isDeleted => _isDeleted;
  int? get deletedTime => _deletedTime;
  int? get createdTime => _createdTime;
  int? get updatedTime => _updatedTime;
  int? get totalPrice => _totalPrice;
}

class LocationModel extends BaseModel {
  final String _lat;
  final String _long;

  LocationModel.fromJson(Map<String, dynamic> json)
      : _lat = json['lat'] ?? '',
        _long = json['long'] ?? '';

  Map<String, dynamic> toJson() => {
        'lat': _lat,
        'long': _long,
      };

  String get lat => _lat;
  String get long => _long;
}

class ListTaskModel extends BaseModel {
  List<TaskModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListTaskModel.fromJson(Map<String, dynamic> parsedJson) {
    List<TaskModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<TaskModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromJson(parsedJson['meta_data']);
  }

  List<TaskModel> get records => _data;
  Paging get meta => _metaData;
}
