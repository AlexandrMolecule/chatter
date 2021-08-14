import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class ChatView extends StatelessWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final filter =
    //     Filter.in_('members', [StreamChat.of(context).currentUser?.id]);
    return Scaffold(
      body: ChannelsBloc(
        child: ChannelListView(
          // filter: filter,
          // {
          //   'members': {
          //     '\$in': [StreamChat.of(context).currentUser?.id],
          //   }
          // } as Filter,
          sort: [SortOption('last_message_at')],
          channelWidget: ChannelPage(),
        ),
      ),
    );
  }
}
class ChannelPage extends StatelessWidget {
  const ChannelPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChannelHeader(),
      body: Column(
        children: [
          Expanded(child: MessageListView()),
          MessageInput(),
        ],)
    );
  }
}
