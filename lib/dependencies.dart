import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'data/auth_repository.dart';
import 'data/image_picker_repository.dart';
import 'data/local/auth_local_impl.dart';
import 'data/local/image_picker_local_impl.dart';
import 'data/local/persistent_storage_local_impl.dart';
import 'data/local/stream_api_local_impl.dart';
import 'data/local/upload_storage_local_impl.dart';
import 'data/persistent_storage_repository.dart';
import 'data/stream_api__repository.dart';
import 'data/upload_storage_repository.dart';
import 'domain/usecases/create_group_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/profile_sign_in_usecase.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client){
  return [
    RepositoryProvider<StreamApiRepository>(create: (_)=> StreamApiLocalImpl(client),),
    RepositoryProvider<PersistentStorageRepository>(create: (_)=> PersistentStorageLocalImpl(),),
    RepositoryProvider<AuthRepository>(create: (_)=> AuthLocalImpl(),),
    RepositoryProvider<UploadStorageRepository>(create: (_)=> UploadStorageLocalImpl(),),
    RepositoryProvider<ImagePickerRepository>(create: (_)=> ImagePickerLocalImpl(),),
    RepositoryProvider<ProfileSignInUseCase>(create: (context)=> ProfileSignInUseCase(
      context.read(),
      context.read(),
      context.read(),
    )),
    RepositoryProvider<CreateGroupUseCase>(
      create:(context)=> CreateGroupUseCase(
      context.read(),
      context.read()),
      ),
      RepositoryProvider<LogoutUserCase>(create: (context)=> LogoutUserCase(
      context.read(),
      context.read()),
       ),
      RepositoryProvider<LoginUserCase>(create: (context)=> LoginUserCase(
      context.read(),
      context.read()),
       )
  ];
}