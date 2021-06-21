abstract class DataUtils {

  static String getUserImage(String username) {
    if(username == 'nainacero') {
      return 'https://scontent.ftcq1-1.fna.fbcdn.net/v/t1.6435-9/90674368_2555620797989578_6091243264818544640_n.jpg?_nc_cat=109&ccb=1-3&_nc_sid=174925&_nc_eui2=AeEZD7i6nk0Vk-hWh8huFaw9VHuVm_OhG_5Ue5Wb86Eb_rsEn5Z7eZYClL2PNMQC7i_jd0XbTvk4lGs8SbWBxv3B&_nc_ohc=S3m-08Wk9AkAX_XoW9g&_nc_ht=scontent.ftcq1-1.fna&oh=7dbdd6919acc2bced10e4d27108527f3&oe=60C9FA9D';
    }

    return _getImageUrl(username);
  }

  static String getChannelImage() => _getImageUrl('');

  static String _getImageUrl(String value) => 'https://ui-avatars.com/api/?name=$value&background=random';

}