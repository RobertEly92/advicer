import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  static const messageKey = Key('TextWidget');
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String message = 'message';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'simple Text',
        home: Scaffold(
            appBar: AppBar(
              title: Text('wurst'),
            ),
            body: Column(
              children: [
                Text(key: MyWidget.messageKey, message),
                TextButton(
                    onPressed: () {
                      setState(() {
                        message = 'changed';
                      });
                    },
                    child: const Text('drücken'))
              ],
            )));
  }
}
