import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../_core/error/failures.dart';
import '../../../../../_core/usecase.dart';
import '../../../../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../../domain/entities/basic_user.dart';
import '../../../domain/usecases/usecases.dart';

part 'verify_email_event.dart';
part 'verify_email_state.dart';

class VerifyEmailBloc extends Bloc<VerifyEmailEvent, VerifyEmailState> {
  final AuthBloc _authBloc;
  final GetBasicUserUseCase _getBasicUserUseCase;
  final VerifyEmailUseCase _verifyEmailUseCase;
  final ResendOTPUseCase _resendOTPUseCase;
  VerifyEmailBloc({
    required AuthBloc authBloc,
    required GetBasicUserUseCase getBasicUserUseCase,
    required VerifyEmailUseCase verifyEmailUseCase,
    required ResendOTPUseCase resendOTPUseCase,
  })  : _authBloc = authBloc,
        _getBasicUserUseCase = getBasicUserUseCase,
        _verifyEmailUseCase = verifyEmailUseCase,
        _resendOTPUseCase = resendOTPUseCase,
        super(VerifyEmailInitial()) {
    on<VerifyEmailRequested>(_verifyRequested);
    on<ResendOTPRequested>(_resendRequested);
  }

  Future<void> _resendRequested(
    ResendOTPRequested event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(ResendOTPLoading());

    try {
      final resendResult = await _resendOTPUseCase(
        ResendOTPParams(event.email),
      );
      emit(await resendResult.fold(
        (error) {
          if (error is ServerFailure) {
            return ResendOTPFailure(error: error.message);
          }
          return const ResendOTPFailure(error: 'Resending OTP Failed');
        },
        (_) => ResendOTPSuccess(),
      ));
    } catch (e) {
      emit(const ResendOTPFailure(error: 'Error Resending OTP'));
    }
  }

  Future<void> _verifyRequested(
    VerifyEmailRequested event,
    Emitter<VerifyEmailState> emit,
  ) async {
    emit(VerifyEmailLoading());

    try {
      final verifyResult = await _verifyEmailUseCase(
        VerifyEmailParams(event.code, event.email),
      );
      emit(
        await verifyResult.fold(
          (error) {
            if (error is ServerFailure) {
              return VerifyEmailFailure(error: error.message);
            }
            return const VerifyEmailFailure(error: 'Verification Failed');
          },
          (_) async {
            await Future<Either<Failure, BasicUser>>(
                () => _getBasicUserUseCase(NoParams())).then((value) {
              return {
                emit(value.fold(
                  (error) => const VerifyEmailFailure(
                    error: 'Error Getting your Data',
                  ),
                  (user) {
                    _authBloc.add(UserLoggedIn(user: user));

                    return VerifyEmailSuccess();
                  },
                ))
              };
            });
            return VerifyEmailSuccess();
          },
        ),
      );
    } catch (e) {
      emit(const VerifyEmailFailure(error: 'Error has Occurred'));
    }
  }
}
