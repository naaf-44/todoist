import 'package:get_it/get_it.dart';
import 'package:todoist/repos/api_service.dart';
import 'package:todoist/repos/api_service_impl.dart';
import 'package:todoist/utils/dio_service.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt(){

  // register dio service
  getIt.registerLazySingleton<DioService>(() => DioService()..setupDio());

  //register api service impl
  getIt.registerLazySingleton<ApiServices>(() => ApiServiceImpl(getIt<DioService>()));
}