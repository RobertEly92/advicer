import 'package:advicer/application/theme/theme_service.dart';
import 'package:advicer/domain/failures/failures.dart';
import 'package:advicer/domain/repositories/theme_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'theme_service_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  late MockThemeRepository mockThemeRepository;
  late ThemeService themeService;
  late int listenerCount;


  setUp(() {
    mockThemeRepository = MockThemeRepository();
    themeService = ThemeServiceImpl(themeRepository: mockThemeRepository)..addListener(() {
      listenerCount+= 1;
    });
    listenerCount = 0;
  });

  test('check if default value fpr dark mode is true', () {
    //assert

    expect(themeService.isDarkModeOn, true);
  });

  group('setThemeMode', () {
    const tMode = false;

    test('should set theme to the parameter it gets, store theme informations',
        () {
//arrange
      themeService.isDarkModeOn = true;

      when(mockThemeRepository.setThemeMode(mode: anyNamed('mode')))
          .thenAnswer((_) async => true);

//act
      themeService.setTheme(tMode);

//assert
      expect(themeService.isDarkModeOn, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);

    });
  });

  group('toggleThemeMode', () {
    const tMode = false;

    test('should toggle current thememode, store theme informations',
        () async {
//arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed('mode')))
          .thenAnswer((_) async => true);

//act
      await themeService.toggleTheme();

//assert
      expect(themeService.isDarkModeOn, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);

    });
  });

  group('init', () {
    const tMode = false;

    test('should get a thememode from a localdatasource, use it and notify listeners',
        () async {
//arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.getThemeMode()).thenAnswer((_) async => const Right(tMode));

//act
      await themeService.init();

//assert
      expect(themeService.isDarkModeOn, tMode);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);

    });

    test('should start with dark mode if no theme is returned from local and notify listeners',
        () async {
//arrange
      themeService.isDarkModeOn = true;
      when(mockThemeRepository.getThemeMode()).thenAnswer((_) async => Left(CacheFailure()));

//act
      await themeService.init();

//assert
      expect(themeService.isDarkModeOn, true);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);

    });
  });
}
