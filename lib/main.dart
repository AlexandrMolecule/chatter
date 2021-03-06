import 'package:chatter/dependencies.dart';
import 'package:chatter/ui/splash/splash_view.dart';
import 'package:chatter/ui/themes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'ui/app_theme_cubit.dart';

void main() async{
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
statusBarColor: Colors.transparent,));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _streamChatClient = StreamChatClient('hggmdwk78a8j');



  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(_streamChatClient),
      child: BlocProvider(
        create: (context) => AppThemeCubit(context.read())..init(),
        child: BlocBuilder<AppThemeCubit, bool>(builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
              title: 'Chatter', 
              theme: snapshot ? Themes.themeDark : Themes.themeLight,
              builder: (context, child) {
                return StreamChat(
                  streamChatThemeData: StreamChatThemeData.fromTheme(Theme.of(context)).copyWith(
                    ownMessageTheme: MessageTheme(
                      messageBackgroundColor: Theme.of(context).accentColor,
                      messageText: TextStyle(color: Colors.white),
                    )
                     ),
                  client: _streamChatClient, child: child);
              },
              home: SplashView());
        }),
      ),
    );
  }
}



