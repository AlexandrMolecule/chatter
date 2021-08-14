import 'package:chatter/data/prod/stream_api_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'data/auth_repository.dart';
import 'data/image_picker_repository.dart';
import 'data/persistent_storage_repository.dart';
import 'data/prod/auth_impl.dart';
import 'data/prod/imagepicker_impl.dart';
import 'data/prod/persistent_storage_impl.dart';
import 'data/prod/upload_storage_impl.dart';
import 'data/stream_api__repository.dart';
import 'data/upload_storage_repository.dart';
import 'domain/usecases/create_group_usecase.dart';
import 'domain/usecases/login_usecase.dart';
import 'domain/usecases/logout_usecase.dart';
import 'domain/usecases/profile_sign_in_usecase.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client){
  return [
    RepositoryProvider<StreamApiRepository>(create: (_)=> StreamApiImpl(client),),
    RepositoryProvider<PersistentStorageRepository>(create: (_)=> PersistentStorageImpl(),),
    RepositoryProvider<AuthRepository>(create: (_)=> AuthImpl(),),
    RepositoryProvider<UploadStorageRepository>(create: (_)=> UploadStorageImpl(),),
    RepositoryProvider<ImagePickerRepository>(create: (_)=> ImagePickerImpl(),),
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
      RepositoryProvider<LoginUseCase>(create: (context)=> LoginUseCase(
      context.read(),
      context.read()),
       )
  ];
}