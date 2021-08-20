import 'package:chatter/ui/common/avatar_placeholder_view.dart';
import 'package:chatter/ui/common/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import '../../../../navigator_utils.dart';
import '../chat_view.dart';
import 'friends_selection_cubit.dart';
import 'group_selection_cubit.dart';

class GroupSelectionView extends StatelessWidget {
  const GroupSelectionView(this.selectedUsers);

  final List<ChatUserState> selectedUsers;

  @override
  Widget build(BuildContext context) {
    final textColor = Theme.of(context).appBarTheme.color;

    return BlocProvider(
      create: (context) =>
          GroupSelectionCubit(selectedUsers, context.read(), context.read()),
      child: BlocConsumer<GroupSelectionCubit, GroupSelectionState>(
          listener: (context, snapshot) {
        if (snapshot.channel != null) {
          pushAndReplaceToPage(
              context,
              Scaffold(
                  body: StreamChannel(
                      channel: snapshot.channel!, child: ChannelPage())));
        }
      }, builder: (context, snapshot) {
        return LoadingView(
          isLoading: snapshot.isLoading,
          child: Scaffold(
                  backgroundColor: Theme.of(context).canvasColor,
            floatingActionButton: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: Color.fromRGBO(0, 106, 255, 0.44), blurRadius: 50)
              ]),
              child: FloatingActionButton(
                child: Icon(Icons.arrow_forward_outlined),
                onPressed: context.read<GroupSelectionCubit>().createGroup,
              ),
            ),
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Theme.of(context).canvasColor,
              title: Text(
                'New Group',
                style: TextStyle(
                    fontSize: 24, color: textColor, fontWeight: FontWeight.w900),
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  AvatarPlaceholder(
                      onTap: context.read<GroupSelectionCubit>().pickImage,
                      child: snapshot.file != null
                          ? Image.file(snapshot.file!, fit: BoxFit.cover)
                          : Icon(
                              Icons.person_outline,
                              color: Colors.black,
                              size: 60,
                            )),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: TextField(
                      controller:
                          context.read<GroupSelectionCubit>().nameTextController,
                      decoration: InputDecoration(
                          fillColor: Theme.of(context)
                              .bottomNavigationBarTheme
                              .backgroundColor,
                          hintStyle:
                              TextStyle(fontSize: 13, color: Colors.grey[400]),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: 'Name of the group'),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Wrap(
                    children: List.generate(selectedUsers.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  selectedUsers[index].chatUser.image!),
                            ),
                            Text(selectedUsers[index].chatUser.name)
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
