import 'package:get_it/get_it.dart';

import 'data/repositories/alert_repository_impl.dart';
import 'domain/repo/alert_repository.dart';
import 'domain/usecases/list_alert.dart';
import 'domain/usecases/notify_new_alert.dart';
import 'domain/usecases/send_alert.dart';
import 'domain/usecases/start_service.dart';
import 'views/bloc/list_alert_bloc/alert_bloc.dart';
import 'views/bloc/new_alert_bloc/new_alert_bloc.dart';

void injectAlert(GetIt container) {
  //! Data Source Injection
  container.registerLazySingleton<AlertRepository>(() => AlertRepositoryImpl(
        socket: container(),
        dio: container(),
      ));

  //! Usecase Injection
  container.registerLazySingleton(() => ListAlertUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => SendAlertUseCase(
        repository: container(),
      ));
  container.registerLazySingleton(() => StartAlertService(
        repository: container(),
      ));
  container.registerLazySingleton(() => NotifyNewAlertUseCase(
        repository: container(),
      ));

  //! Bloc Injection
  container.registerFactory(() => AlertBloc(
        listAlert: container(),
        sendAlert: container(),
      ));
  container.registerFactory(() => NewAlertBloc(
        notifyNewAlert: container(),
      ));
}
