import 'dart:io';
import 'package:chatter/data/image_picker_repository.dart';
import 'package:chatter/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileVerifyState {
  const ProfileVerifyState(this.file,
      {this.succes = false, this.loading = false});
  final File? file;
  final bool succes;
  final bool loading;
}

class ProfileVerifyCubit extends Cubit<ProfileVerifyState> {
  ProfileVerifyCubit(this._imagePickerRepository, this._profileSignInUseCase)
      : super(ProfileVerifyState(null));

  final nameController = TextEditingController();

  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  void startChatting() async {
    emit(ProfileVerifyState(null, loading: true));
    final file = state.file;
    final name = nameController.text;
    _profileSignInUseCase.verify(ProfileInput(name: name, imageFile: file!));
    emit(ProfileVerifyState(file, succes: true, loading: false));
  }

  void pickImage() async {
    final file = await _imagePickerRepository.pickImage();
    emit(ProfileVerifyState(file));
  }
}
