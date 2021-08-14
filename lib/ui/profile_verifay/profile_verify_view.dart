import 'package:chatter/navigator_utils.dart';
import 'package:chatter/ui/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_varify_cubit.dart';

class ProfileVerifyView extends StatelessWidget {
  const ProfileVerifyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileVerifyCubit(context.read(),context.read()),
      child: BlocConsumer<ProfileVerifyCubit, ProfileVerifyState>(
          listener: (context, snapshot) {
        if (snapshot.succes == true) {
          pushAndReplaceToPage(context, HomeView());
        }
      }, builder: (context, snapshot) {
        //refresh photo
        return Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Verify your identity"),
                if(snapshot.file != null)
                Image.file(snapshot.file!, width: 100, height: 150,) else
                Placeholder(
                  fallbackHeight: 100,
                  fallbackWidth: 100,
                ),
                IconButton(
                    onPressed: () =>
                        context.read<ProfileVerifyCubit>().pickImage(),
                    icon: Icon(Icons.photo)),
                Text('your name'),
                TextField(
                  controller: context.read<ProfileVerifyCubit>().nameController,
                  decoration: InputDecoration(hintText: 'or just blabla'),
                ),
                ElevatedButton(
                    onPressed: () {
                      context.read<ProfileVerifyCubit>().startChatting(); 
                    },
                    child: Text('Start chatting now'))
              ],
            ),
          ),
        );
      }),
    );
  }
}
