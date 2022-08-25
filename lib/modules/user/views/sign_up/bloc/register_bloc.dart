import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../domain/usecases/register.dart';
import '../../sign_in/bloc/login_bloc.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final LoginBloc _loginBloc;
  final RegisterUseCase _registerUseCase;
  RegisterBloc({
    required LoginBloc loginBloc,
    required RegisterUseCase registerUseCase,
  })  : _registerUseCase = registerUseCase,
        _loginBloc = loginBloc,
        super(RegisterInitial()) {
    on<RegistrationRequested>(_registerRequested);
  }

  void _registerRequested(
    RegistrationRequested event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());

    try {
      final register = await _registerUseCase(
        RegisterParams(
            firstName: event.firstName,
            lastName: event.lastName,
            phone: event.phone,
            email: event.email,
            password: event.password,
            hasAgreed: event.hasAgreed),
      );
      emit(
        await register.fold(
          (error) {
            if (error is ServerFailure) {
              return RegisterFailure(error: error.message);
            }
            return const RegisterFailure(error: 'An unknown error occurred');
          },
          (uid) async {
            _loginBloc.add( LoginInSubmitted(
              email: event.email,
              password: event.password,
            ));
            return RegisterSuccess();
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
