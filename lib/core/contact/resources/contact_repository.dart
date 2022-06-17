import 'dart:async';
import '../../../main.dart';
import '../../rest/models/rest_api_response.dart';
import 'contact_api_provider.dart';

class ContactRepository {
  final _provider = ContactApiProvider();

  Future<ApiResponse<T?>> fetchAllData<T extends BaseModel>({
    required Map<String, dynamic> params,
  }) =>
      _provider.fetchAllContacts<T>(params: params);

  Future<ApiResponse<T?>>
      editObject<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.editContact<T, K>(
            editModel: editModel,
            id: id,
          );
}
