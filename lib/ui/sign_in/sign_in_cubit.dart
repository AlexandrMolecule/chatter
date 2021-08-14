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
    }catch (e) {
       final result = await _loginUseCase.signIn();
        if(result != null){
        emit(SignInState.none);

        }
    }
      }
}
