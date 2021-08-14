import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'friends_selection_cubit.dart';

class GroupSelectionState {
  const GroupSelectionState(this.file, {this.channel});
  final File? file;
  final Channel? channel;
}

class GroupSelectionCubit extends Cubit<GroupSelectionState> {
  GroupSelectionCubit(this.members) : super(null as GroupSelectionState);

  final nameTextController = TextEditingController();
  final List<ChatUserState> members;

  void createGroup() async {
    // create channel
    emit(GroupSelectionState(state.file, channel: null));
  }

  void pickImage() async {
    //pickImage
    emit(GroupSelectionState(null));
  }
}
