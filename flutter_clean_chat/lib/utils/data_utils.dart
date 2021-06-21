abstract class DataUtils {

  static String getUserImage(String username) {
    return _getImageUrl(username);
  }

  static String getChannelImage() => _getImageUrl('');

  static String _getImageUrl(String value) => 'https://ui-avatars.com/api/?name=$value&background=random';

}