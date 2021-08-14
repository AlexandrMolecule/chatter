import 'package:chatter/data/stream_api__repository.dart';
import 'package:chatter/domain/models/chat_user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatUserState {
  const ChatUserState(this.chatUser, {this.selected = false});
  final ChatUser chatUser;
  final bool selected;
}

class FriendsSelectionCubit extends Cubit<List<ChatUserState>> {
  FriendsSelectionCubit(this._streamApiRepository) : super([]);
  final StreamApiRepository _streamApiRepository;

  // final StreamApiRepository streamApiRepository;

  List<ChatUserState> get selectedUsers =>
      state.where((element) => element.selected).toList();

  Future<void> init() async {
    final users = (await _streamApiRepository.getChatUsers())
        .map((e) => ChatUserState(e))
        .toList();
    emit(users);
  }

  void selectUser(ChatUserState chatUser) {
    final index =
        state.indexWhere((el) => el.chatUser.id == chatUser.chatUser.id);
    state[index] =
        ChatUserState(state[index].chatUser, selected: !chatUser.selected);
    emit(List<ChatUserState>.from(state));
  }

  Future<Channel> createFriendChanell(ChatUserState chatUserState) async {
    return
        await _streamApiRepository.createSimpleChat(chatUserState.chatUser.id!);
    
  }
}

class FriendsGroupCubit extends Cubit<bool> {
  FriendsGroupCubit() : super(false);
  void changeToGroup() => emit(!state);
}
