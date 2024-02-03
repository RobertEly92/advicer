import 'package:advicer/presentation/advicer/widgets/advice_field.dart';
import 'package:advicer/presentation/advicer/widgets/custom_button.dart';
import 'package:flutter/material.dart';

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
            child: Text(
              'Your Advice is waiting for u!',
              style: themeData.textTheme.displayLarge,
            ),
          )),
          SizedBox(
            height: 200,
            child: Center(child: CustomButton(
              onPressed: () {
                print('gedrückt');
              },
            )),
          )
        ]),
      )),
    );
  }
}
