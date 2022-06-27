import 'dart:typed_data';
import 'package:universal_html/html.dart' as html;
import '../logger/logger.dart';
import 'upload_image.dart';

class MediaPicker {
  MediaPicker._();

  static pickMedia({
    Function(List<UploadImage>)? onCompleted,
    bool isMultiple = false,
  }) {
    html.InputElement uploadInput =
        html.FileUploadInputElement() as html.InputElement;
    uploadInput.accept = 'image/*';
    uploadInput.multiple = isMultiple;
    uploadInput.click();

    uploadInput.onChange.listen((e) async {
      final _images = <UploadImage>[];
      for (var image in uploadInput.files!) {
        final _now = DateTime.now().millisecondsSinceEpoch;
        final _key = '$_now-${_formatName(image.name)}';
        final reader = html.FileReader();
        reader.readAsArrayBuffer(image);
        await reader.onLoad.first;

        final imageData = reader.result as Uint8List;

        if (image.type.toString().startsWith('image')) {
          final _uploadFile = UploadImage(
            key: _key,
            name: image.name,
            image: image,
            imageData: imageData,
          );
          _images.add(_uploadFile);
        } else {
          logDebug('upload không đúng định dạng ảnh');
        }
      }
      if (onCompleted != null) onCompleted(_images);
    });
  }

  static _formatName(String name) {
    var array = name.split('.');
    if (array.isNotEmpty) {
      final _ex = array.removeLast();
      var onlyName = array.join('');
      return onlyName
              .replaceAll(RegExp(r'(.\\/:*\?"<>\||[^\w\s])+'), '_')
              .replaceAll(' ', '_') +
          '.$_ex';
    }
    return name;
  }
}
