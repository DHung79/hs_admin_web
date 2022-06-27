import 'package:image_picker/image_picker.dart';
import 'upload_image.dart';

class MediaPicker {
  MediaPicker._();

  static pickMedia({
    Function(List<UploadImage>)? onCompleted,
    bool isMultiple = false,
  }) async {
    List<XFile?>? images = [];
    final ImagePicker _picker = ImagePicker();
    if (isMultiple) {
      images = [await _picker.pickImage(source: ImageSource.gallery)];
    } else {
      images = await _picker.pickMultiImage();
    }
    if (images != null) {
      final _images = images
          .map(
            (image) => UploadImage(
              key: '${DateTime.now().millisecondsSinceEpoch}-${image!.name}',
              name: image.name,
              path: image.path,
            ),
          )
          .toList();
      if (onCompleted != null) onCompleted(_images);
    }
  }
}
