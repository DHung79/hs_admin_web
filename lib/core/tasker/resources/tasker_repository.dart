import 'dart:async';
import '../../../main.dart';
import '../../rest/models/rest_api_response.dart';
import 'tasker_api_provider.dart';

class TaskerRepository {
  final _provider = TaskerApiProvider();

  Future<ApiResponse<T?>>
      fetchAllData<T extends BaseModel, K extends EditBaseModel>({
    required Map<String, dynamic> params,
  }) =>
          _provider.fetchAllTaskers<T>(params: params);

  Future<ApiResponse<T?>>
      fetchDataById<T extends BaseModel, K extends EditBaseModel>({
    String? id,
  }) =>
          _provider.fetchTaskerById<T>(
            id: id,
          );

  Future<ApiResponse<T?>>
      createObject<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.createTasker<T, K>(
            editModel: editModel,
          );

  Future<ApiResponse<T?>>
      editObject<T extends BaseModel, K extends EditBaseModel>({
    K? editModel,
    String? id,
  }) =>
          _provider.editTaskerById<T, K>(
            editModel: editModel,
            id: id,
          );

  Future<ApiResponse<T?>>
      deleteObject<T extends BaseModel, K extends EditBaseModel>({
    String? id,
  }) =>
          _provider.deleteTaskerById<T>(
            id: id,
          );
}
