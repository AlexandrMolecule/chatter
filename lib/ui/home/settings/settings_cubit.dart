import 'package:chatter/domain/usecases/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsSwitchCubit extends Cubit<bool> {
  SettingsSwitchCubit(bool state) : super(state);

  void onChangeDarkMode(bool isDark) => emit(isDark);
}

class SettingsLogoutCubit extends Cubit<void> {
  SettingsLogoutCubit(this._logoutUserCase) : super(null);
  final LogoutUserCase _logoutUserCase;

  void logOut() async {
    await _logoutUserCase.logout();
    emit(null);
  }
}
