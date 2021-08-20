import 'package:chatter/ui/home/home_view.dart';
import 'package:chatter/ui/profile_verifay/profile_verify_view.dart';
import 'package:chatter/ui/sign_in/signi_in_view.dart';
import 'package:chatter/ui/splash/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigator_utils.dart';
import 'initial_background_view.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(context.read())..init(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, snapshot) {
          if (snapshot == SplashState.none) {
            pushAndReplaceToPage(context, SignInView());
          } else if (snapshot == SplashState.existing_user) {
            pushAndReplaceToPage(context, HomeView());
          } else{
            pushAndReplaceToPage(context, ProfileVerifyView());
          }
        },
        child: Scaffold(
          body: Stack(children : [
             InitialBackgroundView(),
             Hero(
               tag: 'logo_hero',
               child: Center(
                 child: Image.asset('assets/logo.png'),
               ),
             )
          ]),
        ),
      ),
    );
  }
}
