
abstract class PersistentStorageRepository {
  Future<bool> isDarkMode();
  Future<bool> updateDarkModel(bool isDarkModel);
}