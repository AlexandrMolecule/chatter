import 'package:chatter/navigator_utils.dart';
import 'package:chatter/ui/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat/chat_view.dart';
import 'chat/selection/friends_selection_view.dart';
import 'settings/settings_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Column(
        children: [
          Expanded(
              child: BlocBuilder<HomeCubit, int>(builder: (context, snapshot) {
            return IndexedStack(
              index: snapshot,
              children: [ChatView(), SettingsView()],
            );
          })),
          HomeNavigationBar(),
        ],
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                context.read<HomeCubit>().changeIndex(0);
              },
              child: Text('Chats')),
          FloatingActionButton(
              onPressed: () {
                pushToPage(context, FriendsSelectionView());
              },
              child: Icon(Icons.add)),
          ElevatedButton(onPressed: () {
                context.read<HomeCubit>().changeIndex(1);

          }, child: Text('Settings')),
        ],
      ),
    );
  }
}
