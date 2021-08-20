import 'dart:ui';

import 'package:chatter/navigator_utils.dart';
import 'package:chatter/ui/common/avatar_placeholder_view.dart';
import 'package:chatter/ui/common/loading_view.dart';
import 'package:chatter/ui/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_varify_cubit.dart';

class ProfileVerifyView extends StatelessWidget {
  const ProfileVerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileVerifyCubit(context.read(), context.read()),
      child: BlocConsumer<ProfileVerifyCubit, ProfileVerifyState>(
          listener: (context, snapshot) {
        if (snapshot.succes == true) {
          pushAndReplaceToPage(context, HomeView());
        }
      }, builder: (context, snapshot) {
        //refresh photo
        return LoadingView(
          isLoading: snapshot.loading,
          child: Scaffold(
            backgroundColor: Theme.of(context).canvasColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Verify your identity",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  
                    AvatarPlaceholder(onTap: context.read<ProfileVerifyCubit>().pickImage,
                    child: snapshot.file != null? Image.file(
                      snapshot.file!,
                      fit: BoxFit.cover
                    ) : Icon(
                      Icons.photo_camera_outlined,
                      color: Colors.black,
                    ),
                    ),
                  Text(
                    'your name',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                    child: TextField(
                      controller:
                          context.read<ProfileVerifyCubit>().nameController,
                    
                      decoration: InputDecoration(
                        
                        filled: true,
                        fillColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                        hintText: 'Or just how people know you',
                        contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none
                      ),
                      // decoration: InputDecoration(
                      //     fillColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
                      //     hintText: 'or just blabla',
                      //     hintStyle: TextStyle(fontSize: 13, color: Colors.grey[400]),
                      //     border: InputBorder.none,
                      //     enabledBorder: InputBorder.none),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Hero(
                    tag: 'home_hero',
                    child: Material(
                        shadowColor: Theme.of(context).accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Theme.of(context).accentColor,
                        child: InkWell(
                            onTap: () {
                              context.read<ProfileVerifyCubit>().startChatting();
                            },
                            child: Container(
                              decoration: BoxDecoration(boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 106, 255, 0.44),
                                    blurRadius: 50)
                              ]),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 80.0, vertical: 18),
                                child: Text(
                                  'Start chatting now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ))),
                  )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
