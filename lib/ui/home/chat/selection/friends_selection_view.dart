import 'package:chatter/navigator_utils.dart';
import 'package:chatter/ui/home/chat/chat_view.dart';
import 'package:chatter/ui/home/chat/selection/friends_selection_cubit.dart';
import 'package:chatter/ui/home/chat/selection/group_selection_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class FriendsSelectionView extends StatelessWidget {
  void _createFrienChannel(BuildContext context, ChatUserState chatUserState) async{
    final channel = await context.read<FriendsSelectionCubit>().createFriendChanell(chatUserState);
    pushAndReplaceToPage(context,
     Scaffold(
       body: StreamChannel(
          channel: channel,
           child: ChannelPage())
           )
           );
  }

  const FriendsSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider( create: (context) => FriendsSelectionCubit(context.read())..init()),
        BlocProvider(create: (_) => FriendsGroupCubit()),
      ],
      child: BlocBuilder<FriendsGroupCubit, bool>(builder: (context, isGroup) {
        return BlocBuilder<FriendsSelectionCubit, List<ChatUserState>>(
            builder: (context, snapshot) {
          final selectedUsers =
              context.read<FriendsSelectionCubit>().selectedUsers;
          return Scaffold(
            floatingActionButton: isGroup && selectedUsers.isNotEmpty
                ? FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    pushAndReplaceToPage(
                        context, GroupSelectionView(selectedUsers));
                  })
                : null,
            body: Column(
              children: [
                if (isGroup)
                  Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          context.read<FriendsGroupCubit>().changeToGroup();
                        },
                      ),
                      Text('New group'),
                    ],
                  )
                else
                  Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      Text('People')
                    ],
                  ),
                if (!isGroup)
                  ElevatedButton(
                      onPressed: () {
                        context.read<FriendsGroupCubit>().changeToGroup();
                      },
                      child: Text('Create group'))
                else if (isGroup && selectedUsers.isEmpty)
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [CircleAvatar(), Text('add a friend')],
                  )
                else
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: selectedUsers.length,
                        itemBuilder: (context, index) {
                          final chatUserState = selectedUsers[index];
                          return Stack(
                            children: [
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CircleAvatar(
                                    backgroundImage: chatUserState
                                                .chatUser.image !=
                                            null
                                        ? NetworkImage(
                                            chatUserState.chatUser.image!)
                                        : NetworkImage(
                                            'https://eu.ui-avatars.com/api/?name=${chatUserState.chatUser.name}'),
                                  ),
                                  Text(chatUserState.chatUser.name)
                                ],
                              ),
                              IconButton(
                                  onPressed: () {
                                    context
                                        .read<FriendsSelectionCubit>()
                                        .selectUser(chatUserState);
                                    print('select user');
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          );
                        }),
                  ),
                Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.length,
                        itemBuilder: (context, index) {
                          final chatUserState = snapshot[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: chatUserState.chatUser.image !=null?  NetworkImage(chatUserState.chatUser.image!) : null ,
                            ),
                            title: Text(chatUserState.chatUser.name),
                            trailing: isGroup
                                ? Checkbox(
                                    value: chatUserState.selected,
                                    onChanged: (val) {
                                      context
                                          .read<FriendsSelectionCubit>()
                                          .selectUser(chatUserState);
                                      print('select user for group');
                                    })
                                : null,
                            onTap: () {
                              _createFrienChannel(context, chatUserState);
                            },
                          );
                        }))
              ],
            ),
          );
        });
      }),
    );
  }
}
