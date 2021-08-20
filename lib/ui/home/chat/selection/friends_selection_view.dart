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
    final textColor = Theme.of(context).appBarTheme.color;
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
            backgroundColor: Theme.of(context).canvasColor,
            floatingActionButton: isGroup && selectedUsers.isNotEmpty
                ? Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 106, 255, 0.44),
                                  blurRadius: 50)
                            ]
                  ),
                  child: FloatingActionButton(
                    
                    child: Icon(Icons.arrow_forward_outlined),
                    onPressed: () {
                      pushAndReplaceToPage(
                          context, GroupSelectionView(selectedUsers));
                    }),
                )
                : null,
                appBar: AppBar(
                  leading: isGroup? GestureDetector( onTap: (){context.read<FriendsGroupCubit>().changeToGroup();} , child: Icon(Icons.arrow_back_outlined)) : null,
                  elevation: 0,
                  backgroundColor: Theme.of(context).canvasColor,
                  title:  Text(isGroup? 'New group' : 'People', style: TextStyle(
                    fontSize: 24,
                    color: textColor,
                    fontWeight: FontWeight.w900
                  ),),
                ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  if (!isGroup)
                    
                         ListTile(
                          onTap: () {
                          context.read<FriendsGroupCubit>().changeToGroup();
                        },
                          leading: CircleAvatar(backgroundColor: Theme.of(context).accentColor,child: Icon(Icons.people_alt_rounded, color: Colors.white,),),
                          title: Text('Create group', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                          subtitle: Text('Talk with 2 or more contacts', style: TextStyle(fontSize: 13 ,color: Colors.grey, fontWeight: FontWeight.w300)),
                          
                        )
                  else if (isGroup && selectedUsers.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [CircleAvatar(radius:30, backgroundColor: Colors.grey ,), SizedBox(height: 5,), Text('add a friend', style: TextStyle(fontSize: 12 ,color: Colors.grey, fontWeight: FontWeight.w300),)],
                          ),
                        ],
                      ),
                    )
                  else
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedUsers.length,
                          itemBuilder: (context, index) {
                            final chatUserState = selectedUsers[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Stack(
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CircleAvatar(
                                        radius: 35,
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
                                  Positioned(
                                    right: 0,
                                    bottom: 20,
                                    child: IconButton(
                                        onPressed: () {
                                          context .read<FriendsSelectionCubit>().selectUser(chatUserState);
                                        },
                                        icon: CircleAvatar(radius: 10 ,child: Icon(Icons.close_rounded, size: 20,),) ),
                                  )
                                ],
                              ),
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
                                    activeColor: Colors.blue,
                                    checkColor: Colors.blue,
                                    shape: CircleBorder(),
                                      value: chatUserState.selected,
                                      onChanged: (val) {
                                        context
                                            .read<FriendsSelectionCubit>()
                                            .selectUser(chatUserState);
                                      })
                                  : null,
                              onTap: () {
                                isGroup? context.read<FriendsSelectionCubit>().selectUser(chatUserState) :
                                _createFrienChannel(context, chatUserState);
                              },
                            );
                          }))
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}
