import 'package:flutter/material.dart';
import 'package:hs_admin_web/main.dart';

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

class EditContactModel extends EditBaseModel {
  String name = '';
  String description = '';
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  EditContactModel.fromModel(ContactModel? model) {
    name = model?.name ?? '';
    description = model?.description ?? '';
    nameController.text = name;
    descriptionController.text = description;
  }

  Map<String, dynamic> toEditJson() {
    Map<String, dynamic> params = {
      'name': name,
      'description': description,
    };
    return params;
  }
}

class EditContactInfoModel extends EditBaseModel {
  String id = '';
  List<EditContactModel> contactsUser = [];
  List<EditContactModel> contactsTasker = [];

  EditContactInfoModel.fromModel(ContactInfoModel? model)
      : id = model?.id ?? '' {
    List<EditContactModel> _contactsUser = [];
    for (var c in model?.contactsUser ?? []) {
      _contactsUser.add(EditContactModel.fromModel(c));
    }
    contactsUser = _contactsUser;
    List<EditContactModel> _contactsTasker = [];
    for (var c in model?.contactsTasker ?? []) {
      _contactsTasker.add(EditContactModel.fromModel(c));
    }
    contactsTasker = _contactsTasker;
  }

  Map<String, dynamic> toEditJson() {
    Map<String, dynamic> params = {
      'contact_user': contactsUser.map((e) => e.toEditJson()).toList(),
      'contact_tasker': contactsTasker.map((e) => e.toEditJson()).toList(),
    };
    return params;
  }
}

class EditListContactInfoModel extends EditBaseModel {
  List<EditContactModel> contacts = [];

  EditListContactInfoModel.fromModel(ListContactInfo? model) {
    List<EditContactModel> _contact = [];
    for (var c in model?.data ?? []) {
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

class ContactInfoModel extends BaseModel {
  final String __id;
  final List<ContactModel> _contactsUser = [];
  final List<ContactModel> _contactsTasker = [];

  ContactInfoModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '' {
    _contactsUser.addAll(BaseModel.mapList<ContactModel>(
      json: json['contacts'],
      key: 'contact_user',
    ));
    _contactsTasker.addAll(BaseModel.mapList<ContactModel>(
      json: json['contacts'],
      key: 'contact_tasker',
    ));
  }

  Map<String, dynamic> toJson() => {
        '_id': __id,
        'contact_user': _contactsUser.map((e) => e.toJson()).toList(),
        'contact_tasker': _contactsTasker.map((e) => e.toJson()).toList(),
      };
  String get id => __id;
  List<ContactModel> get contactsUser => _contactsUser;
  List<ContactModel> get contactsTasker => _contactsTasker;
}

class ListContactInfo extends BaseModel {
  List<ContactInfoModel> _data = [];

  ListContactInfo.listDynamic(List<dynamic> list) {
    List<ContactInfoModel> tmp = [];
    for (int i = 0; i < list.length; i++) {
      var result = BaseModel.fromJson<ContactInfoModel>(list[i]);
      tmp.add(result);
    }
    _data = tmp;
  }

  List<ContactInfoModel> get data => _data;
}
