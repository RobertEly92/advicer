import 'package:flutter/material.dart';
import 'package:advicer/domain/repositories/theme_repository.dart';

abstract class ThemeService extends ChangeNotifier{
  late bool isDarkModeOn;

  Future<void> toggleTheme();

  Future<void> setTheme(@required bool mode);

  Future<void> init();

}

class ThemeServiceImpl extends ChangeNotifier implements ThemeService{

  final ThemeRepository themeRepository;
  ThemeServiceImpl({required this.themeRepository});

  @override
  bool isDarkModeOn = true;

  @override
  Future<void> init() async {
final  modeOrFailure = await themeRepository.getThemeMode();

await modeOrFailure.fold((failure) {
  setTheme(true);
}, (mode) {
  setTheme(mode);
});
  }

  @override
  Future<void> setTheme(bool mode) async{
    isDarkModeOn = mode;
    notifyListeners();
    await themeRepository.setThemeMode(mode: isDarkModeOn);

  }

  @override
  Future<void> toggleTheme() async{
      isDarkModeOn = !isDarkModeOn;
      await setTheme(isDarkModeOn);
  }

}