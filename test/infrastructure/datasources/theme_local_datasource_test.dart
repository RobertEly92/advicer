import 'package:advicer/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advicer/infrastructure/exceptions/exceptions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_local_datasource_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main(){
  late MockSharedPreferences mockSharedPreferences;
  late ThemeLocalDatasource themeLocalDatasource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    themeLocalDatasource = ThemeLocalDatasourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('getCachedThemeDate', () { 
    test('should return a bool (themedata) if there is one in sharedpreferences', () async {
      //arrange
      const t_themeData = true;

      when(mockSharedPreferences.getBool(any)).thenReturn(t_themeData);
      //act
      final result = await themeLocalDatasource.getCachedThemeData();
      //assert
      verify(mockSharedPreferences.getBool(CACHED_THEME_MODE_KEY));
      expect(result, t_themeData);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
    test('should return a cache exception if there is no themedata in sharedpreferences', () async {
      //arrange
      const t_themeData = true;

      when(mockSharedPreferences.getBool(any)).thenReturn(null);
      //act
      final resultCall = themeLocalDatasource.getCachedThemeData;
      //assert
      expect(()=> resultCall(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheThemeData', () {
         const t_themeData = true;
    test('should call sharedpreferences to cache thememode', () {
      //arrange
      when(mockSharedPreferences.setBool(any, any)).thenAnswer((_) async=> true);
      //act
      themeLocalDatasource.cacheThemeData(mode: t_themeData);
      //assert
      verify(mockSharedPreferences.setBool(CACHED_THEME_MODE_KEY, t_themeData));
    });

   });
}