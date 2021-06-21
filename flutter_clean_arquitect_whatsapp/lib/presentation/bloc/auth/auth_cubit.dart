
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/usecases/get_current_uid_usecase.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/usecases/is_sign_in_usecase.dart';
import 'package:flutter_clean_arquitect_whatsapp/domain/usecases/sign_out_usecase.dart';
import 'package:flutter_clean_arquitect_whatsapp/presentation/bloc/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  
  final IsSignInUseCase isSignInUseCase;
  final GetCurrentUidUseCase getCurrentUidUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({
    required this.isSignInUseCase,
    required this.signOutUseCase,
    required this.getCurrentUidUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted() async {
    try{
      bool isSignIn = await isSignInUseCase.call();

      if(isSignIn) {
        final uid = await getCurrentUidUseCase.call();
        emit(Authenticated(uid: uid));
      }else {
        emit(UnAuthenticated());
      }

    }catch(_){
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try{
      final uid = await getCurrentUidUseCase.call();
      emit(Authenticated(uid: uid));
    }catch(_){

    }
  }

  Future<void> loggedOut() async {
    try{
      await signOutUseCase.call();
      emit(UnAuthenticated());
    }catch(_){
      
    }
  }
}