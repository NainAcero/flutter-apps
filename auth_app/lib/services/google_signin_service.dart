
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleSignInService {

  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email'
   ],
  );

  static Future<GoogleSignInAccount> signInWithGoogle() async {

    try {

      final GoogleSignInAccount account = await _googleSignIn.signIn();
      final googleKey = await account.authentication;

      // print(googleKey.idToken);

      final signInWithGoogleEndpoint = Uri(
        scheme: 'https',
        host: 'app-google-2020.herokuapp.com',
        path: '/google'
      );

      final sesion = await http.post(
        signInWithGoogleEndpoint,
        body: {
          'token': googleKey.idToken
        }
      );

      print(sesion.body);

      return account;

    } catch (e) {
      return null;
    }

  }

  static Future signOut() async{

    await _googleSignIn.signOut();

  }

}