
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/data/auth_repository.dart';
import 'package:flutter_clean_chat/data/image_picker_repository.dart';
import 'package:flutter_clean_chat/data/prod/auth_impl.dart';
import 'package:flutter_clean_chat/data/image_picker_impl.dart';
import 'package:flutter_clean_chat/data/prod/persistent_storage_impl.dart';
import 'package:flutter_clean_chat/data/prod/stream_api_impl.dart';
import 'package:flutter_clean_chat/data/prod/upload_storage_impl.dart';
import 'package:flutter_clean_chat/data/persistent_storage_repository.dart';
import 'package:flutter_clean_chat/data/stream_api_repository.dart';
import 'package:flutter_clean_chat/data/upload_storage_repository.dart';
import 'package:flutter_clean_chat/domain/usecases/create_group_usecase.dart';
import 'package:flutter_clean_chat/domain/usecases/login_usecase.dart';
import 'package:flutter_clean_chat/domain/usecases/logout_usecase.dart';
import 'package:flutter_clean_chat/domain/usecases/profile_usecase.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

List<RepositoryProvider> buildRepositories(StreamChatClient client) {
  return [
    RepositoryProvider<StreamApiRepository>(create: (_) => StreamApiLocalImpl(client),),
    RepositoryProvider<PersistentStorageRepository>(create: (_) => PersistentStorageLocalImpl(),),
    RepositoryProvider<AuthRepository>(create: (_) => AuthLocalImpl(),),
    RepositoryProvider<UploadStorageRepository>(create: (_) => UploadStorageLocalImpl(),),
    RepositoryProvider<ImagePickerRepository>(create: (_) => ImagePickerImpl(),),
    RepositoryProvider<ProfileSignInUseCase>(
      create: (context) => ProfileSignInUseCase(
        context.read(),
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<CreateGroupUseCase>(
      create: (context) => CreateGroupUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LogoutUseCase>(
      create: (context) => LogoutUseCase(
        context.read(),
        context.read(),
      ),
    ),
    RepositoryProvider<LoginUseCase>(
      create: (context) => LoginUseCase(
        context.read(),
        context.read(),
      ),
    ),
  ];
}