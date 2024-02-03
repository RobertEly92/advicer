import 'package:advicer/application/advicer/advicer_bloc.dart';
import 'package:advicer/presentation/advicer/widgets/advice_field.dart';
import 'package:advicer/presentation/advicer/widgets/custom_button.dart';
import 'package:advicer/presentation/advicer/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Column(children: [
          Expanded(
              child: Center(
            child: BlocBuilder<AdvicerBloc, AdvicerState>(
                bloc: BlocProvider.of<AdvicerBloc>(context)
                  ..add(AdviceRequestedEvent()),
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
                    return const ErrorMessage();
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
