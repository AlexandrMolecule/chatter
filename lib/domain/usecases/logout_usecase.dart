import 'package:chatter/data/auth_repository.dart';
import 'package:chatter/data/stream_api__repository.dart';

class LogoutUserCase {
  LogoutUserCase(
    this.authRepository,
    this.streamApiRepository,
  );

  final StreamApiRepository streamApiRepository;
  final AuthRepository authRepository;

  Future<void> logout() async {
    await streamApiRepository.logout();
    await authRepository.logout();
  }
}
