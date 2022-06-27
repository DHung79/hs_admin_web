import 'dart:async';
import '../../../main.dart';
import '../../rest/models/rest_api_response.dart';
import 'admin_api_provider.dart';

class AdminRepository {
  final _provider = AdminApiProvider();

  Future<ApiResponse<T?>>
      fetchAllData<T extends BaseModel, K extends EditBaseModel>({
    required Map<String, dynamic> params,
  }) =>
          _provider.fetchAllAdmin<T>(params: params);

  Future<ApiResponse<T?>>
      getProfile<T extends BaseModel, K extends EditBaseModel>() =>
          _provider.fetchAdminByToken<T>();

  Future<ApiResponse<T?>>
      fetchDataById<T extends BaseModel, K extends EditBaseModel>({
    String? id,
  }) =>
          _provider.fetchAdminById<T>(
            id: id,
          );

  Future<ApiResponse<T?>>
      editObject<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.editAdminById<T, K>(
            editModel: editModel,
            id: id,
          );

  Future<ApiResponse<T?>>
      deleteObject<T extends BaseModel, K extends EditBaseModel>({
    String? id,
  }) =>
          _provider.deleteAdminById<T>(
            id: id,
          );

  Future<ApiResponse<T?>>
      editProfile<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
  }) =>
          _provider.editProfile<T, K>(
            editModel: editModel,
          );

  upload<T extends BaseModel>({
    required file,
    Function(int)? onProgress,
    Function(T)? onCompleted,
    Function(String)? onFailed,
  }) =>
      _provider.upload<T>(
        file: file,
        onProgress: onProgress,
        onCompleted: onCompleted,
        onFailed: onFailed,
      );

  abortUpload() => _provider.abortUpload();

  Future<ApiResponse<T>> deleteImages<T extends BaseModel>(
          {required Map<String, dynamic> params}) =>
      _provider.deleteImages<T>(
        params: params,
      );
}
