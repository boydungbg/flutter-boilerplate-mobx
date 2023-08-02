import 'package:mix_tube_application/configs/res_client.dart';
import 'package:mix_tube_application/repository/remote_repository/login_repository.dart';
import 'package:mix_tube_application/repository/remote_repository/task_repository.dart';
import 'package:mix_tube_application/stores/counter_store/counter_store.dart';
import 'package:mix_tube_application/stores/login_store/login_store.dart';
import 'package:mix_tube_application/stores/task_store/task_store.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setUpDependencyInjection() {
  getIt.registerSingleton<Dio>(registerResClient());

  getIt.registerFactory<TaskRepository>(() => TaskRepository(getIt.get<Dio>()));

  getIt.registerFactory<LoginRepository>(
      () => LoginRepository(getIt.get<Dio>()));

  //Khi goi getIt.get<T> no se khoi tao 1 instance moi
  // getIt.registerFactory(() => CounterStore());
  //No se khoi tao khi no duoc goi va chi khoi tao 1 lan duy nhat
  // getIt.registerLazySingleton(() => CounterStore());
  //No se khoi tao khi goi ham setUpDependencyInjection
  //va chi khoi tao 1 lan duy nhat
  getIt.registerSingleton(CounterStore());
  getIt.registerSingleton(TaskStore(getIt.get<TaskRepository>()));
  getIt.registerSingleton(LoginStore(getIt.get<LoginRepository>()));
}
