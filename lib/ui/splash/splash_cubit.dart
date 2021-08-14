import 'package:chatter/domain/exceptions/auth_exception.dart';
import 'package:chatter/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashState {
  none,
  existing_user,
  new_user,
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit(this._loginUserCase) : super(SplashState.none);

  final LoginUserCase _loginUserCase;

  void init() async {
    try {
      final result = await _loginUserCase.validateLogin();
      if (result) {
        emit(SplashState.existing_user);
      }
    } on AuthException catch (e) {
      if (e.error == AuthErrorCode.not_auth) {
        emit(SplashState.none);
      } else {
        emit(SplashState.new_user);
      }
    }
  }
}
