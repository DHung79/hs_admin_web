import 'package:rxdart/rxdart.dart';
import '../../../main.dart';
import '../../base/blocs/block_state.dart';
import '../../rest/api_helpers/api_exception.dart';
import '../../rest/models/rest_api_response.dart';
import '../service.dart';

class ServiceBloc {
  final _repository = ServiceRepository();
  final _allDataFetcher = BehaviorSubject<ApiResponse<ListServiceModel?>>();
  final _serviceDataFetcher = BehaviorSubject<ApiResponse<ServiceModel?>>();
  final _allDataState = BehaviorSubject<BlocState>();

  Stream<ApiResponse<ListServiceModel?>> get allData => _allDataFetcher.stream;
  Stream<ApiResponse<ServiceModel?>> get serviceData =>
      _serviceDataFetcher.stream;
  Stream<BlocState> get allDataState => _allDataState.stream;
  bool _isFetching = false;

  fetchAllData({Map<String, dynamic>? params}) async {
    if (_isFetching) return;
    _isFetching = true;
    // Start fetching data.
    _allDataState.sink.add(BlocState.fetching);
    try {
      // Await response from server.
      final data =
          await _repository.fetchAllData<ListServiceModel>(params: params!);
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
      final data = await _repository
          .fetchDataById<ServiceModel, EditServiceModel>(id: id);
      if (_serviceDataFetcher.isClosed) return;
      if (data.error != null) {
        // Error exist
        _serviceDataFetcher.sink.addError(data.error!);
      } else {
        // Adding response data.
        _serviceDataFetcher.sink.add(data);
      }
    } on AppException catch (e) {
      _serviceDataFetcher.sink.addError(e);
    }
    // Complete fetching.
    _allDataState.sink.add(BlocState.completed);
    _isFetching = false;
  }

  Future<ServiceModel> deleteObject({String? id}) async {
    try {
      // Await response from server.
      final data = await _repository.deleteObject<ServiceModel>(id: id);
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

  Future<ServiceModel> createObject({
    EditServiceModel? editModel,
  }) async {
    try {
      // Await response from server.
      final data =
          await _repository.createObject<ServiceModel, EditServiceModel>(
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

  Future<ServiceModel> editObject({
    EditServiceModel? editModel,
    String? id,
  }) async {
    try {
      // Await response from server.
      final data = await _repository.editObject<ServiceModel, EditServiceModel>(
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
    _serviceDataFetcher.close();
  }
}
