import 'package:chatter/navigator_utils.dart';
import 'package:chatter/ui/app_theme_cubit.dart';
import 'package:chatter/ui/home/settings/settings_cubit.dart';
import 'package:chatter/ui/sign_in/signi_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OwnUser? user;
    String? image;
    user = StreamChat.of(context).client.state.currentUser;
    image = user!.extraData['image'] as String?;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              SettingsSwitchCubit(context.read<AppThemeCubit>().isDark),
        ),
        BlocProvider(
          create: (context) => SettingsLogoutCubit(context.read()),
        )
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              image != null
                  ? Image.network(
                      image,
                      width: double.infinity,
                      height: 300,
                    )
                  : Placeholder(),
              BlocBuilder<SettingsSwitchCubit, bool>(
                  builder: (context, snapshot) {
                return Switch(
                    value: snapshot,
                    onChanged: (val) {
                      context.read<SettingsSwitchCubit>().onChangeDarkMode(val);
                      context.read<AppThemeCubit>().updateTheme(val);
                    });
              }),
              Builder(builder: (context) {
                return BlocListener<SettingsLogoutCubit, void>(
                  listener: (context, snapshot) {
                    popAllAndPush(context, SignInView());
                  },
                  child: ElevatedButton(
                      onPressed: () {
                        context.read<SettingsLogoutCubit>().logOut();
                      },
                      child: Text('Logout')),
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
