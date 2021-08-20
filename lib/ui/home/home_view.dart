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
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      body: BlocProvider(
        create: (_) => HomeCubit(),
        child: Column(
          children: [
            Expanded(child:
                BlocBuilder<HomeCubit, int>(builder: (context, snapshot) {
              return IndexedStack(
                index: snapshot,
                children: [ChatView(), SettingsView()],
              );
            })),
            HomeNavigationBar(),
          ],
        ),
      ),
    );
  }
}

class HomeNavigationBar extends StatelessWidget {
  const HomeNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<HomeCubit>(context, listen: true);
    final navigationBarSize = 80.0;
    final buttonSize = 56.0;
    final buttonMargin = 4.0;
    final topMargin = buttonSize / 2 + buttonMargin / 2;
    final canvasColor = Theme.of(context).canvasColor;
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Material(
        child: Container(
          color: canvasColor,
          width: MediaQuery.of(context).size.width * 0.7,
          height: navigationBarSize + topMargin,
          child: Stack(children: [
            
            Positioned.fill(
              top: topMargin,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow:  [BoxShadow(
                    blurRadius: 25,
                    color: Color.fromRGBO(144,151,160,0.1)
                  )],
                  borderRadius: BorderRadius.circular(25),
                 color:Theme.of(context).bottomNavigationBarTheme.backgroundColor

                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _HomeNavItem(
                      text: 'Chats',
                      iconData: Icons.chat_bubble,
                      onTap: () => cubit.changeIndex(0),
                      selected: cubit.state == 0,
                    ),
                    _HomeNavItem(
                      text: 'Settings',
                      iconData: Icons.settings,
                      onTap: () => cubit.changeIndex(1),
                      selected: cubit.state == 1,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                decoration: BoxDecoration(
                    color: canvasColor, shape: BoxShape.circle),
                padding: EdgeInsets.all(buttonMargin / 2),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(0, 106, 255, 0.44),
                                  blurRadius: 50)
                            ]
                  ),
                  child: FloatingActionButton(
                      onPressed: () {
                        pushToPage(context, FriendsSelectionView());
                      },
                      child: Icon(Icons.add)),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _HomeNavItem extends StatelessWidget {
  const _HomeNavItem(
      {Key? key,
      required this.iconData,
      required this.text,
      required this.onTap,
      this.selected = false})
      : super(key: key);

  final IconData iconData;
  final String text;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final selectedColor =
        Theme.of(context).bottomNavigationBarTheme.selectedItemColor;
    final unselectedColor =
        Theme.of(context).bottomNavigationBarTheme.unselectedItemColor;
    final color = selected ? selectedColor : unselectedColor;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: color,
          ),
          Text(
            text,
            style: TextStyle(color: color),
          ),
        ],
      ),
    );
  }
}
