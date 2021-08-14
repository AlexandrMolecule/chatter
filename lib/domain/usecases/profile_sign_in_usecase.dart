import 'dart:io';

import 'package:chatter/data/auth_repository.dart';
import 'package:chatter/data/stream_api__repository.dart';
import 'package:chatter/data/upload_storage_repository.dart';
import 'package:chatter/domain/models/chat_user.dart';

class ProfileInput {
  final File? imageFile;
  final String name;
  ProfileInput({required this.name, required this.imageFile});
}

class ProfileSignInUseCase {
  ProfileSignInUseCase(
    this._authRepository,
    this._streamApiRepository,
    this._uploadStorageRepository,
  );

  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;
  final AuthRepository _authRepository;

  Future<void> verify(ProfileInput input) async {
    final auth = await _authRepository.getAuthUser();
    final token = await _streamApiRepository.getToken(auth!.id);

    if(input.imageFile != null){
     final image = await _uploadStorageRepository.uploadPhoto( input.imageFile!, 'users/${auth.id}');
     await _streamApiRepository.connectUser(
        ChatUser(name: input.name, id: auth.id, image: image),
        await _streamApiRepository.getToken(input.name));
    }else{
await _streamApiRepository.connectUser(
        ChatUser(name: input.name, id: auth.id),
        await _streamApiRepository.getToken(input.name));
    }
    
  }
}
