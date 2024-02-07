import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/theme_repository.dart';
import 'package:advicer/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:dartz/dartz.dart';

class ThemeRepositoryImpl implements ThemeRepository {
  final ThemeLocalDatasource themeLocalDatasource;
  ThemeRepositoryImpl({required this.themeLocalDatasource});

  @override
  Future<Either<Failure, bool>> getThemeMode() async {
    try {
      final localThemeMode = await themeLocalDatasource.getCachedThemeData();
      return Right(localThemeMode);
    } catch (e) {
      if (e is CacheException) {
        return Left(CacheFailure());
      } else {
        return Left(GeneralFailure());
      }
    }
  }

  @override
  Future<void> setThemeMode({required bool mode}) {
    return themeLocalDatasource.cacheThemeData(mode: mode);
  }
}
