
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/data/persistent_storage_repository.dart';

class AppThemeCubit extends Cubit<bool> {
  AppThemeCubit(this._persistentStorageRepository) : super(false);
  final PersistentStorageRepository _persistentStorageRepository;

  bool _isDark = false;

  bool get isDark => _isDark;

  Future<void> init() async {
    _isDark = await _persistentStorageRepository.isDarkMode();
    emit(_isDark);
  }

  Future<void> updateTheme(bool isDarkMode) async {
    _isDark = isDarkMode;
    await _persistentStorageRepository.updateDarkModel(isDarkMode);
    emit(_isDark);
  }
}