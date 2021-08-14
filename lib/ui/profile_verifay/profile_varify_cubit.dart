import 'dart:io';
import 'package:chatter/data/image_picker_repository.dart';
import 'package:chatter/data/stream_api__repository.dart';
import 'package:chatter/domain/models/chat_user.dart';
import 'package:chatter/domain/usecases/profile_sign_in_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileVerifyState {
  const ProfileVerifyState(this.file, {this.succes = false});
  final File? file;
  final bool succes;
}

class ProfileVerifyCubit extends Cubit<ProfileVerifyState> {
  ProfileVerifyCubit(this._imagePickerRepository, this._profileSignInUseCase)
      : super(ProfileVerifyState(null));

  final nameController = TextEditingController();

  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  void startChatting() async {
    final file = state.file;
    final name = nameController.text;
    _profileSignInUseCase.verify(ProfileInput(name: name, imageFile: file!));
    emit(ProfileVerifyState(file, succes: true));
  }

  void pickImage() async {
    final file = await _imagePickerRepository.pickImage();
    emit(ProfileVerifyState(file));
  }
}
