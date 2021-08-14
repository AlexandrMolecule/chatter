import 'dart:io';

import 'package:chatter/data/stream_api__repository.dart';
import 'package:chatter/data/upload_storage_repository.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';


class CreateGroupInput{
  final File imageFile;
   final List<String> members;
   final String name;
    CreateGroupInput({required this.name, required this.members, required this.imageFile});
  }

class CreateGroupUseCase {
  CreateGroupUseCase(
    this._streamApiRepository,
    this._uploadStorageRepository,
  );

  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;

  Future<Channel> createGroup(CreateGroupInput input) async {
    final channelId = Uuid().v4();
    final imageResult =
        await _uploadStorageRepository.uploadPhoto(input.imageFile, 'channels');
    final channel = await _streamApiRepository.createGroupChat(channelId, input.name, input.members, image: imageResult);
    return channel;
  }
}
