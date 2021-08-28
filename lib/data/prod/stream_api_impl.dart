import 'package:chatter/data/stream_api__repository.dart';
import 'package:chatter/domain/models/chat_user.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class StreamApiImpl extends StreamApiRepository {
  StreamApiImpl(this._client);

  final StreamChatClient _client;

  @override
  Future<bool> connectIfExist(String userId) async {
    // await _client.disconnectUser();
    final token = await getToken(userId);
    await _client.connectUser(User(id: userId), token);
    return _client.state.currentUser?.name != null && _client.state.currentUser!.name != userId;
    // return false;
  }

  @override
  Future<ChatUser> connectUser(ChatUser user, String token) async {
    Map<String, dynamic> extraData = {};
    if (user.image != null) {
      extraData['image'] = user.image;
    }
    if (user.name != null) {
      extraData['name'] = user.name;
    }
    // await _client.disconnectUser();
    await _client.connectUser(User(id: user.id!, extraData: extraData), token);
    return user;
  }

  Future<OwnUser?> connectGuestUser(String id) async {
    final user = await _client.connectGuestUser(User(id: id));
    return user;
  }

  @override
  Future<Channel> createGroupChat(
      String channelId, String name, List<String> members,
      {String? image}) async {
    final channel = _client.channel('messaging', id: channelId, extraData: {
      'name': name,
      'members': [_client.state.currentUser!.id, ...members],
      'image': image,
    });
    await channel.watch();
    return channel;
  }

  @override
  Future<Channel> createSimpleChat(String friendId) async {
    final channel = _client.channel('messaging',
        id: '${_client.state.currentUser!.id.hashCode}${friendId.hashCode}',
        extraData: {
          'members': [friendId, _client.state.currentUser!.id],
        });
    await channel.watch();
    return channel;
  }

  @override
  Future<List<ChatUser>> getChatUsers() async {
    final result = await _client.queryUsers(
        filter: Filter.notEqual('id', _client.state.currentUser!.id));

    final chatUsers = result.users
        .map((e) => ChatUser(
            name: e.name,
            id: e.id,
            image: e.extraData['image'] as String? ??
                'https://eu.ui-avatars.com/api/?name=${e.name}'))
        .toList();
    return chatUsers;
  }

  @override
  Future<String> getToken(String userId) async {
    return _client.devToken(userId).rawValue;
  }

  @override
  Future<void> logout() {
    return _client.disconnectUser();
  }
}
