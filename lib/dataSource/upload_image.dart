import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:trade_diary/model/image_response.dart';

class UploadImage {
  Future<ImageModel> imageUpload(XFile data) async {
    final image = XFile(data.path);

    final parseUrl = Uri.parse(
        'http://0.0.0.0:8000/files/images');
    final request = http.MultipartRequest(
      'POST',
      parseUrl,
    )..files.add(await http.MultipartFile.fromPath("file", image.path));

    final response = await request.send();
    final result = await http.Response.fromStream(response);

    return ImageModel.fromJson(jsonDecode(result.body));
  }
}