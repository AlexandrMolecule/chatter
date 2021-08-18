import 'package:chatter/data/auth_repository.dart';
import 'package:chatter/data/stream_api__repository.dart';
import 'package:chatter/domain/exceptions/auth_exception.dart';
import 'package:chatter/domain/models/auth_user.dart';

class LoginUseCase {
  LoginUseCase(
    this.authRepository,
    this.streamApiRepository,
  );

  final StreamApiRepository streamApiRepository;
  final AuthRepository authRepository;
  Future<bool> validateLogin() async {
    final user = await authRepository.getAuthUser();
    if (user != null) {
      final result = await streamApiRepository.connectIfExist(user.id);
      if (result) {
        return true;
      } else {
        throw AuthException(AuthErrorCode.not_chat_user);
      }
    }
    throw AuthException(AuthErrorCode.not_auth);
  }
Future<AuthUser?> signIn() async{
 return await authRepository.signIn();
}




}
