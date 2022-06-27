import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class PushNotiModel extends BaseModel {
  final String __id;
  final String _title;
  final String _targetType;
  final String _description;
  final int _createdTime;
  final int _updatedTime;

  PushNotiModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _title = json['title'] ?? '',
        _targetType = json['target_type'] ?? '',
        _description = json['description'] ?? '',
        _createdTime = json['created_time'] ?? 0,
        _updatedTime = json['updated_time'] ?? 0;

  Map<String, dynamic> toJson() => {
        "_id": __id,
        "title": _title,
        "target_type": _targetType,
        "description": _description,
        "created_time": _createdTime,
        "updated_time": _updatedTime,
      };

  String get id => __id;
  String get title => _title;
  String get targetType => _targetType;
  String get description => _description;
  int get createdTime => _createdTime;
  int get updatedTime => _updatedTime;
}

class EditPushNotiModel extends EditBaseModel {
  String id = ''; // For editing
  String title = '';
  String targetType = 'Khách hàng';
  String description = '';

  EditPushNotiModel.fromModel(PushNotiModel? model) {
    id = model?.id ?? '';
    title = model?.title ?? '';
    targetType = model != null ? model.targetType : 'Khách hàng';
    description = model?.description ?? '';
  }

  Map<String, dynamic> toCreateJson() {
    Map<String, dynamic> params = {
      'title': title,
      "target_type": targetType,
      "description": description,
    };
    return params;
  }

  Map<String, dynamic> toEditJson() {
    Map<String, dynamic> params = {
      'id': id,
      'title': title,
      "target_type": targetType,
      "description": description,
    };

    return params;
  }
}

class ListPushNotiModel extends BaseModel {
  List<PushNotiModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListPushNotiModel.fromJson(Map<String, dynamic> parsedJson) {
    List<PushNotiModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<PushNotiModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromJson(parsedJson['meta_data']);
  }

  List<PushNotiModel> get records => _data;
  Paging get meta => _metaData;
}
