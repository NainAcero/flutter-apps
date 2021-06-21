
import 'package:flutter_clean_chat/data/persistent_storage_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _isDarkMode = '_isDarkMode';

class PersistentStorageLocalImpl extends PersistentStorageRepository {

  @override
  Future<bool> isDarkMode() async{
    final preference = await SharedPreferences.getInstance();
    return preference.getBool(_isDarkMode) ?? false;
  }

  @override
  Future<bool> updateDarkModel(bool isDarkModel) async{
    final preference = await SharedPreferences.getInstance();
    return await preference.setBool(_isDarkMode, isDarkModel);
  }

}