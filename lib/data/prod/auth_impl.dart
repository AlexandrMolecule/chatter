import 'package:chatter/data/auth_repository.dart';
import 'package:chatter/domain/models/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthImpl extends AuthRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Future<AuthUser?> getAuthUser() async {
    final user = _auth.currentUser;
    if(user != null){
      return AuthUser(user.uid);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    _auth.signOut();
  }

  @override
  Future<AuthUser> signIn() async{
    try {
      UserCredential userCredential;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
      final OAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,);
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      final user = userCredential.user;
      return AuthUser(user!.uid);

    } catch (e) {
      print(e);
      throw Exception('login error');
    }
  }
}
