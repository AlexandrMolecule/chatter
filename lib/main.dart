import 'package:chatter/dependencies.dart';
import 'package:chatter/ui/splash/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'ui/app_theme_cubit.dart';

void main() async{
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
              title: 'Flutter Demo',
              theme: snapshot ? ThemeData.dark() : ThemeData.light(),
              builder: (context, child) {
                return StreamChat(client: _streamChatClient, child: child);
              },
              home: SplashView());
        }),
      ),
    );
  }
}
