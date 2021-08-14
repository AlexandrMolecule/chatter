import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../../navigator_utils.dart';
import '../chat_view.dart';
import 'friends_selection_cubit.dart';
import 'group_selection_cubit.dart';

class GroupSelectionView extends StatelessWidget {
  const GroupSelectionView(this.selecterdUsers);

  final List<ChatUserState> selecterdUsers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> GroupSelectionCubit(selecterdUsers, context.read(), context.read()),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
        listener: (context, snapshot){
          if( snapshot.channel != null){
            pushAndReplaceToPage(context,
     Scaffold(
       body: StreamChannel(
          channel: snapshot.channel!,
           child: ChannelPage())
           )
           );
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Verify your identity"),
                  if(snapshot.file != null)
                  Image.file(snapshot.file!, height: 150, )
                  else Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100
                  ),
                  
                  IconButton(
                    onPressed: context.read<GroupSelectionCubit>().pickImage
                  , icon: Icon(Icons.photo)),
                  TextField(
                    controller: context.read<GroupSelectionCubit>().nameTextController,
                    decoration: InputDecoration(hintText: 'Name of the group'),
                  ),
                  Wrap(
                    children: List.generate(
                      selecterdUsers.length,
                      (index) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [CircleAvatar(), Text(selecterdUsers[index].chatUser.name)],
                      ),
                    ),
                  ),
                  ElevatedButton(onPressed: context.read<GroupSelectionCubit>().createGroup
                  , child: Text("Next"))
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
