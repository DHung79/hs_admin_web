import 'dart:async';
import '../../../main.dart';
import '../../rest/models/rest_api_response.dart';
import 'contact_api_provider.dart';

class ContactRepository {
  final _provider = ContactApiProvider();

  Future<ApiResponse<T?>> deleteObject<T extends BaseModel>({
    String? id,
  }) =>
      _provider.deleteContact<T>(
        id: id,
      );

  Future<ApiResponse<T?>> fetchAllData<T extends BaseModel>({
    required Map<String, dynamic> params,
  }) =>
      _provider.fetchAllContacts<T>(params: params);

  Future<ApiResponse<T?>> fetchDataById<T extends BaseModel>({
    String? id,
  }) =>
      _provider.fetchContactById<T>(
        id: id,
      );
}
