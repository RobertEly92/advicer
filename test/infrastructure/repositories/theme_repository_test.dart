import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/theme_repository.dart';
import 'package:advicer/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:advicer/infrastructure/repositories/theme_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_repository_test.mocks.dart';

@GenerateMocks([ThemeLocalDatasource])
void main() {
  late MockThemeLocalDatasource mockThemeLocalDatasource;
  late ThemeRepository themeRepository;

  setUp(() {
    mockThemeLocalDatasource = MockThemeLocalDatasource();
    themeRepository =
        ThemeRepositoryImpl(themeLocalDatasource: mockThemeLocalDatasource);
  });

  group('setThemeMode', () {
    const t_themeMode = true;
    test('should call function to cache thememode in localdatasource', () {
      //arrange
      when(mockThemeLocalDatasource.cacheThemeData(mode: anyNamed('mode')))
          .thenAnswer((_) async => true);
      //act
      themeRepository.setThemeMode(mode: t_themeMode);
      //assert
      verify(mockThemeLocalDatasource.cacheThemeData(mode: t_themeMode));
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });
  });

  group('getThemeMode', () {
    const t_themeMode = true;
    test(
        'should return thememode if cached data is present from localdatasource',
        () async {
      //arrange
      when(mockThemeLocalDatasource.getCachedThemeData())
          .thenAnswer((_) async => t_themeMode);
      //act
      final result = await themeRepository.getThemeMode();
      //assert
      verify(mockThemeLocalDatasource.getCachedThemeData());
      expect(result, const Right(t_themeMode));
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });

     test('should return cachefailue if localdatasource throws CacheException', () async{
      //arrange
      when(mockThemeLocalDatasource.getCachedThemeData()).thenThrow(CacheException());
      //act
    final result = await themeRepository.getThemeMode();
      //assert
      verify(mockThemeLocalDatasource.getCachedThemeData());
      expect(result, Left(CacheFailure()));
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });

       test('should return generalfailue if anything other goes wrong', () async{
      //arrange
      when(mockThemeLocalDatasource.getCachedThemeData()).thenThrow(Exception());
      //act
    final result = await themeRepository.getThemeMode();
      //assert
      verify(mockThemeLocalDatasource.getCachedThemeData());
      expect(result, Left(GeneralFailure()));
      verifyNoMoreInteractions(mockThemeLocalDatasource);
    });

  });

      
}
