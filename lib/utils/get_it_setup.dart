import 'package:get_it/get_it.dart';
import 'package:todoist/utils/dio_service.dart';

final GetIt getIt = GetIt.instance;

void setupGetIt(){

  // register dio service
  getIt.registerLazySingleton<DioService>(() => DioService()..setupDio());
}