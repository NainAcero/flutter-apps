import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/data/image_picker_repository.dart';
import 'package:flutter_clean_chat/domain/usecases/profile_usecase.dart';

class ProfileState {
  const ProfileState(
    this.file, {this.success = false}
  );

  final File? file;
  final bool success;
}

class ProfileVeriFyCubit extends Cubit<ProfileState> {
  ProfileVeriFyCubit(this._imagePickerRepository, this._profileSignInUseCase) : super(ProfileState(null));

  final nameController = TextEditingController();
  final ImagePickerRepository _imagePickerRepository;
  final ProfileSignInUseCase _profileSignInUseCase;

  void startChatting() async {

    final file = state.file;
    final name = nameController.text;
    await _profileSignInUseCase.verify(ProfileInput(
      imageFile: file,
      name: name
    ));
    emit(ProfileState(file, success: true));
  }

  void pickImage() async{

    final file = await _imagePickerRepository.pickImage();
    emit(ProfileState(file));
  }
}