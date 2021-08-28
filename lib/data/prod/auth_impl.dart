import 'package:chatter/data/auth_repository.dart';
import 'package:chatter/domain/models/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class AuthImpl extends AuthRepository {
  FirebaseAuth _auth = FirebaseAuth.instance;
  late StreamChatClient _client;
  @override
  Future<AuthUser?> getAuthUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      return AuthUser(user.uid);
    }
    return null;
  }

  @override
  Future<void> logout() async {
    await _auth.signOut();
    await GoogleSignIn().disconnect();
    await GoogleSignIn().signOut();
  }
 

  @override
  Future<AuthUser?> signIn() async {
    try {
      UserCredential userCredential;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final OAuthCredential googleAuthCredential =
          GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      userCredential = await _auth.signInWithCredential(googleAuthCredential);
      final user = userCredential.user;
      if (user != null) {
        return AuthUser(user.uid);
      } else
        null;
    } catch (e) {
      print(e);
      throw Exception('login error');
    }
  }
  // Future<AuthUser?> signInViaGuest() async{
  //   try {
  //     UserCredential userCredential;
  //     final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //     final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  //     final OAuthCredential googleAuthCredential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,);
  //     userCredential = await _auth.signInWithCredential(googleAuthCredential);
  //     final user = userCredential.user;
  //     if(user != null){
  //      return AuthUser(user.uid);
  //     }
  //     else null;

  //   } catch (e) {
  //     print(e);
  //     throw Exception('login error');
  //   }
  // }
}
