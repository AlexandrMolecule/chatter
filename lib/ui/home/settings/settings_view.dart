import 'package:chatter/navigator_utils.dart';
import 'package:chatter/ui/app_theme_cubit.dart';
import 'package:chatter/ui/common/avatar_placeholder_view.dart';
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
    final textColor = Theme.of(context).appBarTheme.color;
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
        backgroundColor: Theme.of(context).canvasColor,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Settings',
            style: TextStyle(fontSize: 24, color: textColor, fontWeight: FontWeight.w800),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                 AvatarPlaceholder(
                      //TODO: implement change avatar
                      child: image != null ? Image.network( image, fit: BoxFit.cover, )
                      : Icon( Icons.person, color: Colors.black)  ,
                      onTap: (){} ,
                    ),
                    Text(
            user.role == 'user'? user.name : 'guest',
            style: TextStyle(fontSize: 24, color: textColor, fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 15,),
                Row(children: [
                  Icon(Icons.nights_stay_outlined),
                  SizedBox(width: 10,),
                  Text('Dark mode', style: TextStyle(color: textColor)),
                  Spacer(),
                  BlocBuilder<SettingsSwitchCubit, bool>(
                    builder: (context, snapshot) {
                  return Switch(
                      value: snapshot,
                      onChanged: (val) {
                        context
                            .read<SettingsSwitchCubit>()
                            .onChangeDarkMode(val);
                        context.read<AppThemeCubit>().updateTheme(val);
                      });
                }),
                ]),
                SizedBox(height: 5,),
                Builder(builder: (context) {
                  return BlocListener<SettingsLogoutCubit, void>(
                    listener: (context, snapshot) {
                      popAllAndPush(context, SignInView());
                    },
                    child: GestureDetector(
                        onTap: () {
                          user?.role == 'user'?
                          context.read<SettingsLogoutCubit>().logOut() :  context.read<SettingsLogoutCubit>().guestlogOut() ;
                        },
                        child: Row(children: [
                  Icon(Icons.login),
                   SizedBox(width: 10,),
                  Text('Logout', style: TextStyle(color: textColor),),
                  Spacer(),
                  Icon(Icons.chevron_right)
                  
                ],),
                  ));
                })
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
