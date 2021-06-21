
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_chat/domain/usecases/logout_usecase.dart';

class SettingSwitchCubit extends Cubit<bool> {
  SettingSwitchCubit(bool state) : super(state);

  void onChangeDarkMode(bool isDark) => emit(isDark);
}

class SettingsLogoutCubit extends Cubit<void> {
  SettingsLogoutCubit(this._logoutUseCase) :super(null);

  final LogoutUseCase _logoutUseCase;

  void logOut() async{
    await _logoutUseCase.logout();
    emit(null);
  }
}