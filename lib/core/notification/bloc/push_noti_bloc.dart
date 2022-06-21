import 'package:rxdart/rxdart.dart';
import '../../../main.dart';
import '../../base/blocs/block_state.dart';
import '../../rest/api_helpers/api_exception.dart';
import '../../rest/models/rest_api_response.dart';
import '../push_noti.dart';

class PushNotiBloc {
  final _repository = PushNotiRepository();
  final _allDataFetcher = BehaviorSubject<ApiResponse<ListPushNotiModel?>>();
  final _pushNotiDataFetcher = BehaviorSubject<ApiResponse<PushNotiModel?>>();
  final _allDataState = BehaviorSubject<BlocState>();

  Stream<ApiResponse<ListPushNotiModel?>> get allData => _allDataFetcher.stream;
  Stream<ApiResponse<PushNotiModel?>> get notiData => _pushNotiDataFetcher.stream;
  Stream<BlocState> get allDataState => _allDataState.stream;
  bool _isFetching = false;

  fetchAllData({Map<String, dynamic>? params}) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      final data = await _repository
          .fetchAllData<ListPushNotiModel, EditPushNotiModel>(params: params!);
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
          await _repository.fetchDataById<PushNotiModel, EditPushNotiModel>(id: id);
      if (_pushNotiDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _pushNotiDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _pushNotiDataFetcher.sink.add(data);
      }
    } on AppException catch (e) {
      _pushNotiDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  Future<PushNotiModel> deleteObject({String? id}) async {
    try {
      // Await response from server.
      final data =
          await _repository.deleteObject<PushNotiModel, EditPushNotiModel>(id: id);
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

  Future<PushNotiModel> createObject({
    EditPushNotiModel? editModel,
  }) async {
    try {
      // Await response from server.
      final data = await _repository.createObject<PushNotiModel, EditPushNotiModel>(
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

  Future<PushNotiModel> editObject({
    EditPushNotiModel? editModel,
    String? id,
  }) async {
    try {
      // Await response from server.
      final data = await _repository.editObject<PushNotiModel, EditPushNotiModel>(
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

  dispose() {
    _allDataFetcher.close();
    _allDataState.close();
    _pushNotiDataFetcher.close();
  }
}
