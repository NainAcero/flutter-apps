
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_clean_chat/data/auth_repository.dart';
import 'package:flutter_clean_chat/domain/model/auth_user.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthLocalImpl extends AuthRepository {

  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<AuthUser?> getAuthUser() async{
    final User? user = _auth.currentUser;
    if(user != null) {
      return AuthUser(user.uid);
    }
    return null;
  }

  @override
  Future<AuthUser> signIn() async{
    try{
      UserCredential userCredential;
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      final user = userCredential.user;
      return AuthUser(user.uid);
    }catch(e){
      print(e);
      throw Exception('login error');
    }
  }

  @override
  Future<void> logout() async{
    return _auth.signOut();
  }
}