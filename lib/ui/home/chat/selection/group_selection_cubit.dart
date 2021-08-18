import 'dart:io';
import 'package:chatter/data/image_picker_repository.dart';
import 'package:chatter/domain/usecases/create_group_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'friends_selection_cubit.dart';

class GroupSelectionState {
  const GroupSelectionState({this.file, this.channel});
  final File? file;
  final Channel? channel;
}

class GroupSelectionCubit extends Cubit<GroupSelectionState> {
  GroupSelectionCubit(
    this.members,
     this._createGroupUseCase,
      this._imagePickerRepository) : super(GroupSelectionState());

    final CreateGroupUseCase _createGroupUseCase;
  final nameTextController = TextEditingController();
  final List<ChatUserState> members;
  final ImagePickerRepository _imagePickerRepository;  

  void createGroup() async {
    final channel = await _createGroupUseCase.createGroup(CreateGroupInput(
      imageFile: state.file,
      members: members.map((e) => e.chatUser.id!).toList(),
      name: nameTextController.text
      ));
    emit(GroupSelectionState(file: state.file, channel: channel));
  }

  void pickImage() async {
    final image = await _imagePickerRepository.pickImage();
    emit(GroupSelectionState(file: image));
  }
}
