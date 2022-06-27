import 'package:universal_html/html.dart' as html;
import 'dart:convert';
import '../../models/rest_api_response.dart';

class MediaUploader {
  MediaUploader._();

  static html.Worker? _workder;

  static void upload<T extends BaseModel>({
    String? path,
    dynamic file,
    String? token,
    String? name,
    Function(int)? onProgress,
    Function(T)? onCompleted,
    Function(String)? onFailed,
  }) async {
    _workder = _createWorker(
      onProgress: onProgress,
      onCompleted: onCompleted,
      onFailed: onFailed,
    );
    Map<String, dynamic> params = {
      'file': file,
      'uri': path,
      'token': token,
    };
    _workder?.postMessage(params);
  }

  static abortUpload() {
    _workder?.postMessage({'message': 'cancel'});
  }

  static html.Worker? _createWorker<T extends BaseModel>({
    Function(int)? onProgress,
    Function(T)? onCompleted,
    Function(String)? onFailed,
  }) {
    var _worker = html.Worker('upload_worker.js');
    _worker.onMessage.listen((e) {
      if (e.data is String) {
        var body = e.data.toString();
        if (body.startsWith('done|')) {
          final _jsonStr = body.substring('done|'.length, body.length);
          var _json = json.decode(_jsonStr);
          final _file = BaseModel.fromJson<T>(_json);
          if (onCompleted != null) onCompleted(_file);
        } else if (body == 'error') {
          if (onFailed != null) onFailed(body);
        } else if (body == 'over-size') {
          if (onFailed != null) onFailed('Kích thước file tối đa là 32MB');
        } else {
          if (onFailed != null) onFailed(body);
        }
      } else if (e.data is int) {
        if (onProgress != null) onProgress(e.data);
      } else if (e.data != null) {
        if (onFailed != null) onFailed(e.data);
      }
    });
    return _worker;
  }
}
