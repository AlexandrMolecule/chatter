import 'package:chatter/domain/exceptions/auth_exception.dart';
import 'package:chatter/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SignInState {
  none,
  existing_user,
}

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._loginUseCase) : super(SignInState.none);
  final LoginUseCase _loginUseCase;

  void signIn() async {
    try {
      final result = await _loginUseCase.validateLogin();
      if (result) {
        emit(SignInState.existing_user);
      }
    } catch (e) {
      final result = await _loginUseCase.signIn();
      if (result != null) {
        emit(SignInState.none);
      }
    }

    //    on AuthException catch (e) {
    //    if (e.error == AuthErrorCode.not_auth){
    //     final result = await _loginUseCase.signIn();
    //     final user = await _loginUseCase.validateLogin();
    //     if(user){
    //       emit(SignInState.existing_user);
    //     }
    //     else if (user == false || result != null){
    //       emit(SignInState.none);
    //     }
    //    }

    //     if (e.error == AuthErrorCode.not_chat_user) {

    //         emit(SignInState.none);

    //     }

    //   }
    // }
  }
}
