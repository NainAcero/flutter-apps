
import 'dart:io';

import 'package:flutter_clean_chat/data/stream_api_repository.dart';
import 'package:flutter_clean_chat/data/upload_storage_repository.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:uuid/uuid.dart';

class CreateGroupInput {
  CreateGroupInput({
    required this.imageFile,
    required this.members,
    required this.name
  });

  final File imageFile; 
  final String name;
  final List<String> members;
}

class CreateGroupUseCase {
  CreateGroupUseCase(
    this._streamApiRepository,
    this._uploadStorageRepository
  );

  final UploadStorageRepository _uploadStorageRepository;
  final StreamApiRepository _streamApiRepository;

  Future<Channel> createGroup(CreateGroupInput input) async {
    var uuid = Uuid();
    final channelId = uuid.v4();
    String imageResult = '';
    if(imageResult != null ) {
      imageResult = await _uploadStorageRepository.uploadPhoto(input.imageFile, 'channels');
    } 
    final channel = await _streamApiRepository.createGroupChat(
      channelId, 
      input.name, 
      input.members,
      image: imageResult,
    );

    return channel;
  }
}