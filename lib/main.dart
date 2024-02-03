import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/presentation/advicer/widgets/advicer_page.dart';
import 'package:advicer/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Advicer',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        home: BlocProvider(
          create: (context) => AdvicerBloc(),
          child: const AdvicerPage(),
        ));
  }
}
