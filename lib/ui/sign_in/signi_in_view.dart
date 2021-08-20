import 'package:chatter/ui/home/home_view.dart';
import 'package:chatter/ui/profile_verifay/profile_verify_view.dart';
import 'package:chatter/ui/splash/initial_background_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../navigator_utils.dart';
import '../themes.dart';
import 'sign_in_cubit.dart';

class SignInView extends StatelessWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInCubit(
        context.read(),
      ),
      child: BlocConsumer<SignInCubit, SignInState>(
        listener: (context, snapshot) {
          if (snapshot == SignInState.none) {
            pushAndReplaceToPage(context, ProfileVerifyView());
          } else if (snapshot == SignInState.existing_user) {
            pushAndReplaceToPage(context, HomeView());
          }
        },
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Theme.of(context).canvasColor,
            body: Stack(
              children: [
                InitialBackgroundView(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 170,
                      ),
                      Hero(
                        tag: 'logo_hero',
                        child: Image.asset('assets/logo.png'),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Welcome to\nChatter',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w900),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 40),
                        child: Text(
                          'blablablablabla blabla',
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Material(
                        elevation: 2,
                        shadowColor: Colors.black45,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .backgroundColor,
                        child: InkWell(
                          onTap: () {
                            context.read<SignInCubit>().signIn();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/google-logo.png',
                                  height: 30,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text('Login with Google', style: TextStyle(
                                color: Colors.black,
                                 fontWeight: FontWeight.w500),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Align(
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            'bla blal llaslldasl blablabla',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w400),
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
