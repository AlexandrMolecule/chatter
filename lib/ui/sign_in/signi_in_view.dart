import 'package:chatter/ui/home/home_view.dart';
import 'package:chatter/ui/profile_verifay/profile_verify_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigator_utils.dart';
import 'sign_in_cubit.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(context.read(),),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, snapshot) {
          if (snapshot == SignInState.none) {
            pushAndReplaceToPage(context, ProfileVerifyView());
          } else if(snapshot == SignInState.existing_user){
            pushAndReplaceToPage(context, HomeView());
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('welcome'),
                  ElevatedButton(
                      onPressed: () { context.read<SignInCubit>().signIn(); },
                      child: Text('Login with Google'))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
