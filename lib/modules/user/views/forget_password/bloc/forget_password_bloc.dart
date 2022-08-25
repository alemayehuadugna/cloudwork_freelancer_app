import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  ForgetPasswordBloc() : super(ForgetPasswordInitial()) {
    on<ForgetPasswordEvent>(_forgetUserPassword);
  }

  void _forgetUserPassword(
      ForgetPasswordEvent event, Emitter<ForgetPasswordState> state) async {
    emit(ForgetPasswordSuccess());
  }
}
