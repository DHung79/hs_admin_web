import 'package:rxdart/rxdart.dart';
import '../../../main.dart';
import '../../base/blocs/block_state.dart';
import '../../rest/api_helpers/api_exception.dart';
import '../../rest/models/rest_api_response.dart';
import '../user.dart';

class UserBloc {
  final _repository = UserRepository();
  final _allDataFetcher = BehaviorSubject<ApiResponse<ListUserModel?>>();
  final _userDataFetcher = BehaviorSubject<ApiResponse<UserModel?>>();
  final _allDataState = BehaviorSubject<BlocState>();

  Stream<ApiResponse<ListUserModel?>> get allData => _allDataFetcher.stream;
  Stream<ApiResponse<UserModel?>> get userData => _userDataFetcher.stream;
  Stream<BlocState> get allDataState => _allDataState.stream;
  bool _isFetching = false;

  fetchAllData({Map<String, dynamic>? params}) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      final data = await _repository.fetchAllData<ListUserModel, EditUserModel>(
          params: params!);
      if (_allDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _allDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _allDataFetcher.sink.add(data);
      }
    } on AppException catch (e) {
      _allDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  fetchDataById(String id) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      final data =
          await _repository.fetchDataById<UserModel, EditUserModel>(id: id);
      if (_userDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _userDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _userDataFetcher.sink.add(data);
      }
    } on AppException catch (e) {
      _userDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  Future<UserModel> deleteObject({String? id}) async {
    try {
      // Await response from server.
      final data =
          await _repository.deleteObject<UserModel, EditUserModel>(id: id);
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel> createObject({
    EditUserModel? editModel,
  }) async {
    try {
      // Await response from server.
      final data = await _repository.createObject<UserModel, EditUserModel>(
        editModel: editModel,
      );
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel> editObject({
    EditUserModel? editModel,
    String? id,
  }) async {
    try {
      // Await response from server.
      final data = await _repository.editObject<UserModel, EditUserModel>(
        editModel: editModel,
        id: id,
      );
      if (data.error != null) {
        // Error exist
        return Future.error(data.error!);
      } else {
        // Adding response data.
        return Future.value(data.model);
      }
    } on AppException catch (e) {
      return Future.error(e);
    }
  }

  uploadImage({
    required String userId,
    required image,
    Function(int)? onProgress,
    Function(UserModel)? onCompleted,
    Function(String)? onFailed,
  }) async {
    try {
      // Await response from server.
      _repository.upload<UserModel>(
        userId: userId,
        file: image,
        onProgress: onProgress,
        onCompleted: onCompleted,
        onFailed: onFailed,
      );
    } on AppException catch (e) {
      if (onFailed != null) {
        onFailed(e.toString());
      }
    }
  }

  dispose() {
    _allDataFetcher.close();
    _allDataState.close();
    _userDataFetcher.close();
  }
}
