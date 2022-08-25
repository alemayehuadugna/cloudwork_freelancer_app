import 'package:get_it/get_it.dart';

import '../../_shared/interface/bloc/auth/auth_bloc.dart';
import '../../_shared/interface/bloc/setting/desktop_nav_cubit.dart';
import '../../_shared/interface/bloc/setting/theme_mode_cubit.dart';
import '../chat/domain/usecases/stop_socket_service.dart';
import 'data/data_sources/local_data_source.dart';
import 'data/data_sources/remote_data_source.dart';
import 'data/repositories/user_repository_impl.dart';
import 'domain/repo/user_repository.dart';
import 'domain/usecases/change_availability.dart';
import 'domain/usecases/change_password.dart';
import 'domain/usecases/delete_account.dart';
import 'domain/usecases/education/remove_education.dart';
import 'domain/usecases/education/save_education.dart';
import 'domain/usecases/employment/remove_employment.dart';
import 'domain/usecases/employment/save_employment.dart';
import 'domain/usecases/other_experience/remove_other_experience.dart';
import 'domain/usecases/other_experience/save_other_experience.dart';
import 'domain/usecases/register.dart';
import 'domain/usecases/save_basic_info.dart';
import 'domain/usecases/save_languages.dart';
import 'domain/usecases/save_main_service.dart';
import 'domain/usecases/save_overview.dart';
import 'domain/usecases/save_skills.dart';
import 'domain/usecases/upload_profile_picture.dart';
import 'domain/usecases/usecases.dart';
import 'views/create_profile/bloc/update_profile_bloc.dart';
import 'views/sign_in/bloc/login_bloc.dart';
import 'views/sign_up/bloc/register_bloc.dart';
import 'views/verify_email/bloc/verify_email_bloc.dart';
import 'views/view_profile/bloc/detail_user_bloc.dart';

void injectUsers(GetIt container) {
  //! Data Source Injection
  container.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(dio: container()),
  );
  container.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(hive: container()),
  );
  container.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: container(),
      localDataSource: container(),
    ),
  );

  //! Use Case Injection
  container.registerLazySingleton(() => GetAuthStatusUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => GetBasicUserUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SignInUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SignOutUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => RegisterUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => VerifyEmailUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => ResendOTPUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => GetDetailUserUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => AddExpertiseUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SaveEmploymentUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => RemoveEmploymentUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SaveEducationUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => RemoveEducationUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SaveLanguagesUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SaveSkillsUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SaveOverviewUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SaveMainServiceUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => UploadProfilePictureUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SaveBasicInfoUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => ChangeAvailabilityUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SaveOtherExperienceUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => RemoveOtherExperienceUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => ChangePasswordUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => DeleteAccountUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => StopSocketService(
        repository: container(),
      ));

  //! Bloc Injection
  container.registerLazySingleton(() => AuthBloc(
        authStatus: container(),
        getUser: container(),
        signOut: container(),
        startChatUseCase: container(),
        stopSocketService: container(),
        startAlertService: container(),
      )..add(AppLoaded()));
  container.registerLazySingleton(() => DesktopSideNavCubit());
  container.registerLazySingleton(() => ThemeModeCubit());
  container.registerFactory(() => LoginBloc(
        authBloc: container(),
        signIn: container(),
        getUser: container(),
      ));
  container.registerFactory(() => RegisterBloc(
        loginBloc: container(),
        registerUseCase: container(),
      ));
  container.registerFactory(() => DetailUserBloc(
        getDetailUser: container(),
      ));
  container.registerFactory(() => VerifyEmailBloc(
        authBloc: container(),
        getBasicUserUseCase: container(),
        verifyEmailUseCase: container(),
        resendOTPUseCase: container(),
      ));
  container.registerFactory(() => UpdateProfileBloc(
        addExpertiseUseCase: container(),
        addEmploymentUseCase: container(),
        removeEmploymentUseCase: container(),
        saveEducationUseCase: container(),
        removeEducationUseCase: container(),
        saveLanguagesUseCase: container(),
        saveSkillsUseCase: container(),
        saveOverviewUseCase: container(),
        saveMainServiceUseCase: container(),
        uploadProfilePictureUseCase: container(),
        saveBasicInfoUseCase: container(),
        changeAvailabilityUseCase: container(),
        removeOtherExperienceUseCase: container(),
        saveOtherExperienceUseCase: container(),
        changePasswordUseCase: container(),
        deleteAccountUseCase: container(),
      ));
}
