import 'dart:async';
import '../../../main.dart';
import '../../rest/models/rest_api_response.dart';
import 'task_api_provider.dart';

class TaskRepository {
  final _provider = TaskApiProvider();

  Future<ApiResponse<T?>> deleteObject<T extends BaseModel>({
    String? id,
  }) =>
      _provider.deleteTask<T>(
        id: id,
      );

  Future<ApiResponse<T?>> fetchAllData<T extends BaseModel>({
    required Map<String, dynamic> params,
  }) =>
      _provider.fetchAllTasks<T>(params: params);

  Future<ApiResponse<T?>> fetchDataById<T extends BaseModel>({
    String? id,
  }) =>
      _provider.fetchTaskById<T>(
        id: id,
      );
}
