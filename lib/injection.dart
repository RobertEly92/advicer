
import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/domain/repositories/advicer_repository.dart';
import 'package:advicer/domain/repositories/theme_repository.dart';
import 'package:advicer/domain/usecases/advicer_usecases.dart';
import 'package:advicer/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:advicer/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advicer/infrastructure/repositories/advicer_repository_impl.dart';
import 'package:advicer/infrastructure/repositories/theme_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.I; //sl = servicelocator

Future<void> init()async{
  //! Blocs
  sl.registerFactory(() => AdvicerBloc(usecases: sl()));

  //! Usecases
  sl.registerLazySingleton(() => AdvicerUsecases(advicerRepository: sl()));

  //! Repositories
  sl.registerLazySingleton<AdvicerRepository>(() => AdvicerRepositoryImpl(advicerRemoteDatasource: sl()));
  sl.registerLazySingleton<ThemeRepository>(()=> ThemeRepositoryImpl(themeLocalDatasource: sl()));

  //! Remotedatasource
  sl.registerLazySingleton<AdvicerRemoteDatasource>(() => AdvicerRemoteDatasourceImpl(client: sl()));
  sl.registerLazySingleton<ThemeLocalDatasource>(() => ThemeLocalDatasourceImpl(sharedPreferences: sl()),);

  //! extern
  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

}