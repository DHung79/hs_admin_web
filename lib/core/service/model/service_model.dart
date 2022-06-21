import '../../base/models/common_model.dart';
import '../../rest/models/rest_api_response.dart';

class ServiceModel extends BaseModel {
  final String __id;
  final String _name;
  final String _code;
  final String _image;
  final bool _isActive;
  final CategoryModel _categoryModel;
  final int _createdTime;
  final int _updatedTime;
  final List<TranslationModel> _translations = [];
  final List<OptionsModel> _options = [];
  final int _quantityType;
  final List<PaymentModel> _payments = [];

  ServiceModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _name = json['name'] ?? '',
        _code = json['code'] ?? '',
        _image = json['image'] ?? '',
        _isActive = json['is_active'] ?? false,
        _categoryModel = BaseModel.map<CategoryModel>(
          json: json,
          key: 'category',
        ),
        _createdTime = json['created_time'] ?? 0,
        _updatedTime = json['updated_time'] ?? 0,
        _quantityType = json['quantity_type'] ?? 0 {
    _payments.addAll(BaseModel.mapList<PaymentModel>(
      json: json,
      key: 'payments',
    ));
    _translations.addAll(BaseModel.mapList<TranslationModel>(
      json: json,
      key: 'translation',
    ));
    _options.addAll(BaseModel.mapList<OptionsModel>(
      json: json,
      key: 'options',
    ));
  }

  Map<String, dynamic> toJson() => {
        '_id': __id,
        'name': _name,
        'code': _code,
        'image': _image,
        'is_active': _isActive,
        'category': _categoryModel.toJson(),
        'created_time': _createdTime,
        'updated_time': _updatedTime,
        'quantity_type': _quantityType,
        'payment_type': _payments.map((e) => e.toJson()).toList(),
        'translation': _translations.map((e) => e.toJson()).toList(),
        'options': _options.map((e) => e.toJson()).toList(),
      };

  String get id => __id;
  String get name => _name;
  String get code => _code;
  String get image => _image;
  bool get isActive => _isActive;
  CategoryModel get categoryModel => _categoryModel;
  int get createdTime => _createdTime;
  int get updatedTime => _updatedTime;
  int get quantityType => _quantityType;
  List<PaymentModel> get payments => _payments;
  List<TranslationModel> get translations => _translations;
  List<OptionsModel> get options => _options;
}

class EditServiceModel extends EditBaseModel {
  String id = ''; // For editing
  String name = '';
  String code = '';
  String image = '';
  bool isActive = false;
  CategoryModel? categoryModel;
  int createdTime = 0;
  int updatedTime = 0;
  int quantityType = 0;
  List<TranslationModel> translations = [];
  List<OptionsModel> options = [];
  List<PaymentModel> payments = [];

  EditServiceModel.fromModel(ServiceModel? model) {
    id = model?.id ?? '';
    name = model?.name ?? '';
    code = model?.code ?? '';
    image = model?.image ?? '';
    isActive = model?.isActive ?? false;
    categoryModel = model?.categoryModel;
    createdTime = model?.createdTime ?? 0;
    updatedTime = model?.updatedTime ?? 0;
    translations = model?.translations ?? [];
    options = model?.options ?? [];
    quantityType = model?.quantityType ?? 0;
    payments = model?.payments ?? [];
  }

  Map<String, dynamic> toCreateJson() {
    Map<String, dynamic> params = {
      'name': name,
      'code': code,
      'image': image,
      'is_active': isActive,
      'categoryModel': categoryModel,
      'translations': translations,
      'options': options,
      'quantity': quantityType,
      'payments': payments,
    };

    return params;
  }

  Map<String, dynamic> toEditJson() {
    Map<String, dynamic> params = {
      'id': id,
      'name': name,
      'code': code,
      'image': image,
      'is_active': isActive,
      'categoryModel': categoryModel,
      'translations': translations,
      'options': options,
      'quantity': quantityType,
      'payments': payments,
    };
    return params;
  }
}

class PriceModel extends BaseModel {
  final String __id;
  final String _name;
  final String _price;
  final String _type;

  PriceModel.fromJson(Map<String, dynamic> json)
      : __id = json['_id'] ?? '',
        _name = json['name'] ?? '',
        _price = json['price'] ?? '',
        _type = json['type'] ?? '';

  Map<String, dynamic> toJson() => {
        '_id': __id,
        'name': _name,
        'price': _price,
        'type': _type,
      };

  String get id => __id;
  String get name => _name;
  String get price => _price;
  String get type => _type;
}

class PaymentModel extends BaseModel {
  String name;
  bool isActive;

  PaymentModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        isActive = json['is_active'] ?? false;

  Map<String, dynamic> toJson() => {
        'name': name,
        'is_active': isActive,
      };
}

class ListServiceModel extends BaseModel {
  List<ServiceModel> _data = [];
  Paging _metaData = Paging.fromJson({});

  ListServiceModel.fromJson(Map<String, dynamic> parsedJson) {
    List<ServiceModel> tmp = [];
    for (int i = 0; i < parsedJson['data'].length; i++) {
      var result = BaseModel.fromJson<ServiceModel>(parsedJson['data'][i]);
      tmp.add(result);
    }
    _data = tmp;
    _metaData = Paging.fromJson(parsedJson['meta_data']);
  }

  List<ServiceModel> get records => _data;
  Paging get meta => _metaData;
}

class CategoryModel extends BaseModel {
  final List _translation;
  final List _unit;

  CategoryModel.fromJson(Map<String, dynamic> json)
      : _translation = json['translation'] ?? [],
        _unit = json['unit'] ?? [];

  Map<String, dynamic> toJson() => {
        'translation': _translation,
        'unit': _unit,
      };

  List get translation => _translation;
  List get unit => _unit;
}

class TranslationModel extends BaseModel {
  final String _language;
  final String _name;
  final String __id;

  TranslationModel.fromJson(Map<String, dynamic> json)
      : _language = json['language'] ?? '',
        _name = json['name'] ?? '',
        __id = json['_id'] ?? '';

  Map<String, dynamic> toJson() => {
        'language': _language,
        'name': _name,
        '_id': __id,
      };

  String get language => _language;
  String get name => _name;
  String get id => __id;
}

class OptionsModel extends BaseModel {
  String name;
  int price;
  int quantity;
  String note;

  OptionsModel.fromJson(Map<String, dynamic> json)
      : name = json['name'] ?? '',
        price = json['price'] ?? 0,
        quantity = json['quantity'] ?? 0,
        note = json['note'] ?? '';

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'quantity': quantity,
        'note': note,
      };
}
