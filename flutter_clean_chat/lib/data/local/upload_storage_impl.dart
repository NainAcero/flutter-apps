
import 'dart:io';

import 'package:flutter_clean_chat/data/upload_storage_repository.dart';

class UploadStorageLocalImpl extends UploadStorageRepository {

  @override
  Future<String> uploadPhoto(File file, String path) async{
    return 'https://ecartac.com/tienda/1611281955-rest-la-huambrilla-tacna.jpg';
  }

}