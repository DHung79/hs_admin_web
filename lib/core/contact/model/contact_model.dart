import '../../rest/models/rest_api_response.dart';

class ContactModel extends BaseModel {
  final String _name;
  final String _description;

  ContactModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'] ?? '',
        _description = json['description'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': _description,
      };

  String get name => _name;
  String get description => _description;
}

class ListContactInfo extends BaseModel {
  List<ContactInfoModel> _data = [];

  ListContactInfo.fromJson(Map<String, dynamic> parsedJson) {
    List<ContactInfoModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<ContactInfoModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
  }

  List<ContactInfoModel> get data => _data;
}

class EditContactInfoModel extends EditBaseModel {
  List<EditContactModel> contacts = [];

  EditContactInfoModel.fromModel(ContactInfoModel? model) {
    List<EditContactModel> _contact = [];
    for (var c in model?.contacts ?? []) {
      _contact.add(EditContactModel.fromModel(c));
    }
    contacts = _contact;
  }

  Map<String, dynamic> toEditJson() {
    Map<String, dynamic> params = {
      'contacts': contacts.map((e) => e.toEditJson()).toList(),
    };
    return params;
  }
}

class EditContactModel extends EditBaseModel {
  String name = '';
  String description = '';

  EditContactModel.fromModel(ContactModel? model) {
    name = model?.name ?? '';
    description = model?.description ?? '';
  }

  Map<String, dynamic> toEditJson() {
    Map<String, dynamic> params = {
      'name': name,
      'description': description,
    };
    return params;
  }
}

class ContactInfoModel extends BaseModel {
  final String __id;
  final List<ContactModel> _contacts = [];

  ContactInfoModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '' {
    _contacts.addAll(BaseModel.mapList<ContactModel>(
      json: json,
      key: 'contacts',
    ));
  }

  Map<String, dynamic> toJson() => {
        '_id': __id,
        'contacts': _contacts.map((e) => e.toJson()),
      };
  String get id => __id;
  List<ContactModel> get contacts => _contacts;
}
