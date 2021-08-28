import 'package:chatter/domain/usecases/login_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SignInState {
  none,
  existing_user,
}

class SignInCubit extends Cubit<SignInState> {
  SignInCubit(this._loginUseCase) : super(SignInState.none);
  final LoginUseCase _loginUseCase;
  final nameController = TextEditingController();

  void anonSign() async {
    final result = await _loginUseCase.signInGuest(nameController.text);
    if (result != null) {
      emit(SignInState.existing_user);
    }
  }

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
    //     if(user){x
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
