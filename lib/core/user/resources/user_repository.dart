import 'dart:async';
import '../../../main.dart';
import '../../rest/models/rest_api_response.dart';
import 'user_api_provider.dart';

class UserRepository {
  final _provider = UserApiProvider();

  Future<ApiResponse<T?>>
      fetchAllData<T extends BaseModel, K extends EditBaseModel>({
    required Map<String, dynamic> params,
  }) =>
          _provider.fetchAllUsers<T>(params: params);

  Future<ApiResponse<T?>>
      getProfile<T extends BaseModel, K extends EditBaseModel>() =>
          _provider.getProfile<T>();

  Future<ApiResponse<T?>>
      fetchDataById<T extends BaseModel, K extends EditBaseModel>({
    String? id,
  }) =>
          _provider.fetchUserById<T>(
            id: id,
          );

  Future<ApiResponse<T?>>
      deleteObject<T extends BaseModel, K extends EditBaseModel>({
    String? id,
  }) =>
          _provider.deleteUserById<T>(
            id: id,
          );

  Future<ApiResponse<T?>>
      editObject<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.editUserById<T, K>(
            editModel: editModel,
            id: id,
          );

  Future<ApiResponse<T?>>
      createObject<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.createUser<T, K>(
            editModel: editModel,
          );

  upload<T extends BaseModel>({
    required String userId,
    required file,
    Function(int)? onProgress,
    Function(T)? onCompleted,
    Function(String)? onFailed,
  }) =>
      _provider.upload<T>(
        userId: userId,
        file: file,
        onProgress: onProgress,
        onCompleted: onCompleted,
        onFailed: onFailed,
      );

  abortUpload() => _provider.abortUpload();
}
