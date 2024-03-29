import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/application/theme/theme_service.dart';
import 'package:advicer/presentation/advicer/widgets/advice_field.dart';
import 'package:advicer/presentation/advicer/widgets/custom_button.dart';
import 'package:advicer/presentation/advicer/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Advicer',
          style: themeData.textTheme.displayLarge,
        ),
        centerTitle: true,
        actions: [Switch(value: Provider.of<ThemeService>(context).isDarkModeOn, onChanged: (_){
            Provider.of<ThemeService>(context, listen: false).toggleTheme();
        })],
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(children: [
          Expanded(
              child: Center(
            child: BlocBuilder<AdvicerBloc, AdvicerState>(
                builder: (context, state) {
                  print(state);
                  if (state is AdvicerInitial) {
                    return Text(
                      'Ur advice is waiting for u',
                      style: themeData.textTheme.displayLarge,
                    );
                  } else if (state is AdvicerStateLoading) {
                    return CircularProgressIndicator(
                      color: themeData.colorScheme.secondary,
                    );
                  } else if (state is AdvicerStateLoaded) {
                    return AdviceField(advice: state.advice);
                  } else if (state is AdvicerStateError) {
                    return ErrorMessage(errorMessage: state.message);
                  }
                  return const Placeholder();
                }),
          )),
          const SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(),
              )),
        ]),
      )),
    );
  }
}
