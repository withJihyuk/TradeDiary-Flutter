import 'package:image_picker/image_picker.dart';
import 'package:trade_diary/dataSource/upload_image.dart';
import 'package:trade_diary/model/image_response.dart';

class ImageRepo {
  final datasource = UploadImage();

  Future<ImageModel> imageUpload(XFile data) async {
    return await datasource.imageUpload(data);
  }
}
