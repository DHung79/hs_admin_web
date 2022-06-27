import '../../models/rest_api_response.dart';

class MediaUploader {
  MediaUploader._();

  static void upload<T extends BaseModel>({
    String? path,
    dynamic file,
    Function(int)? onProgress,
    Function(T)? onCompleted,
    Function(String)? onFailed,
    String? token,
    String? name,
  }) async {}

  static abortUpload() {}
}
