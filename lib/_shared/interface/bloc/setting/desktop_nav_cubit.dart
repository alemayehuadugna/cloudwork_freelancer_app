import 'package:bloc/bloc.dart';

class DesktopSideNavCubit extends Cubit<bool> {
  DesktopSideNavCubit() : super(false);

  changeSideNavState() {
    // print(state);
    emit(!state);
  }
}
