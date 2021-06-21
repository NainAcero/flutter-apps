
import 'package:flutter_clean_chat/data/persistent_storage_repository.dart';

class PersistentStorageLocalImpl extends PersistentStorageRepository {

  @override
  Future<bool> isDarkMode() async{
    await Future.delayed(const Duration(milliseconds: 50));
    return false;
  }

  @override
  Future<bool> updateDarkModel(bool isDarkModel) async{
    await Future.delayed(const Duration(milliseconds: 50));
    return true;
  }

}