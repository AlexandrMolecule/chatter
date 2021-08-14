import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'friends_selection_cubit.dart';
import 'group_selection_cubit.dart';

class GroupSelectionView extends StatelessWidget {
  const GroupSelectionView(this.selecterdUsers);

  final List<ChatUserState> selecterdUsers;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_)=> GroupSelectionCubit(selecterdUsers),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
        listener: (context, snapshot){
          //call chat view
        },
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Verify your identity"),
                  Placeholder(
                    fallbackHeight: 100,
                    fallbackWidth: 100,
                  ),
                  IconButton(onPressed: () {}, icon: Icon(Icons.photo)),
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
                  ElevatedButton(onPressed: () {}, child: Text("Newxt"))
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}
