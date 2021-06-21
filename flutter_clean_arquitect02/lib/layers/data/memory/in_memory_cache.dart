
class InMemoryCache<T> {
  
  late DateTime lastUpdatedAt;
  Duration expiresAfter = Duration(minutes: 5);
  T? _cacheValue;

  bool get isEmpty {
    if(getCachedValue() == null)
      return true;
    else if (T is List)
      return (getCachedValue() as List).isEmpty;
    else
      return false;
  }

  bool get isNotEmpty => !isEmpty;

  bool get hasExpired => lastUpdatedAt.add(expiresAfter).isBefore(DateTime.now());

  bool get hasNotExpired => !hasExpired;

  T? getCachedValue() => _cacheValue;

  void save(T? data) {
    _cacheValue = data;
    lastUpdatedAt = DateTime.now();
  }

  void clean() {
    _cacheValue = null;   
  }

  void expireAfter(Duration dateTime) {
    expiresAfter = dateTime;   
  }
}