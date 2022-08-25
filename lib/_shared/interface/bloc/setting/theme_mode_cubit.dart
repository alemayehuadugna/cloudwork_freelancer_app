import 'package:bloc/bloc.dart';

enum ThemeModeState { light, dark, system }

class ThemeModeCubit extends Cubit<ThemeModeState> {
  ThemeModeCubit() : super(ThemeModeState.light);



  darkMode() {
    emit(ThemeModeState.dark);
  }

  lightMode() {
    emit(ThemeModeState.light);
  }

  systemMode() {
    emit(ThemeModeState.system);
  }
}
