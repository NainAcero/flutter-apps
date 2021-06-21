import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/entities/user_entity.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/usecases/get_create_current_user_usecase.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/usecases/sign_in_with_phone_number_usecase.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/usecases/verify_phone_number_usecase.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/phone_auth/phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final SignInWithPhoneNumberUseCase signInWithPhoneNumberUseCase;
  final VerifyPhoneNumberUseCase verifyPhoneNumberUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;

  PhoneAuthCubit({
    required this.signInWithPhoneNumberUseCase,
    required this.verifyPhoneNumberUseCase,
    required this.getCreateCurrentUserUseCase,
  }) : super(PhoneAuthInitial());

  Future<void> submitVerifyPhoneNumber({required String phoneNumber}) async {
    emit(PhoneAuthLoading());

    try {
      await verifyPhoneNumberUseCase.call(phoneNumber);
      emit(PhoneAuthSmsCodeReceived());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitSmsCode({required String smsCode}) async {
    emit(PhoneAuthLoading());
    try {
      await signInWithPhoneNumberUseCase.call(smsCode);
      emit(PhoneAuthProfileInfo());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }

  Future<void> submitProfileInfo({
    required String name,
    required String profileUrl,
    required String phoneNumber,
  }) async {
    try {
      await getCreateCurrentUserUseCase.call(UserEntity(
        uid: "",
        name: name,
        email: "",
        phoneNumber: phoneNumber,
        isOnline: true,
        profileUrl: profileUrl,
        status: ""
      ));
      emit(PhoneAuthSuccess());
    } on SocketException catch (_) {
      emit(PhoneAuthFailure());
    } catch (_) {
      emit(PhoneAuthFailure());
    }
  }
}