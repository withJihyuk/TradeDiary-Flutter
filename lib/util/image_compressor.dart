import 'dart:typed_data';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ImageCompressor {
  static Future<Uint8List?> compressToWebP(String filePath, {int quality = 80}) async {
    try {
      return await FlutterImageCompress.compressWithFile(
        filePath,
        quality: quality,
        format: CompressFormat.webp,
      );
    } on UnsupportedError {
      return await FlutterImageCompress.compressWithFile(
        filePath,
        quality: quality,
        format: CompressFormat.jpeg,
      );
    }
  }
}
