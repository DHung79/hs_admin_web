import '../../rest/models/rest_api_response.dart';

class ContactModel extends BaseModel {
  final String _name;
  final String _description;

  ContactModel.fromJson(Map<String, dynamic> json)
      : _name = json['name'] ?? '',
        _description = json['description'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': _name,
        'description': _description,
      };

  String get name => _name;
  String get description => _description;
}

class SupportContactModel extends BaseModel {
  final List<ContactModel> _user = [];
  final List<ContactModel> _tasker = [];

  SupportContactModel.fromJson(Map<String, dynamic> json) {
    _user.addAll(BaseModel.mapList<ContactModel>(
      json: json,
      key: 'user',
    ));
    _tasker.addAll(BaseModel.mapList<ContactModel>(
      json: json,
      key: 'tasker',
    ));
  }

  Map<String, dynamic> toJson() => {
        'user': _user.map((e) => e.toJson()),
        'tasker': _tasker.map((e) => e.toJson()),
      };

  List<ContactModel> get user => _user;
  List<ContactModel> get tasker => _tasker;
}
