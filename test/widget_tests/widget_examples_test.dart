import 'package:advicer/widget_test_examples/simple_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('check if message on btn tap', (WidgetTester tester) async {
    const widgetKey = Key('myWidget');

    await tester.pumpWidget(const MyWidget(
      key: widgetKey,
    ));

    //all our finders
    final appBarTitleFinder = find.text('wurst');
    final messageWidgetFinder = find.byKey(MyWidget.messageKey);
    final findMessageInitialText = find.text('message');
    final findMyWidget = find.byKey(widgetKey);
    final findButton = find.byType(TextButton);
    final findChangedMessageText = find.text('changed');

    //check if initial state is correct
    expect(appBarTitleFinder, findsOneWidget);
    expect(messageWidgetFinder, findsOneWidget);
    expect(findMyWidget, findsOneWidget);
    expect(findButton, findsOneWidget);
    expect(findMessageInitialText, findsOneWidget);

    //tap btn
    await tester.tap(findButton);
    await tester.pump();

    //check if message changed correctly
    expect(appBarTitleFinder, findsOneWidget);
    expect(messageWidgetFinder, findsOneWidget);
    expect(findMyWidget, findsOneWidget);
    expect(findButton, findsOneWidget);
    expect(findMessageInitialText, findsNothing);
    expect(findChangedMessageText, findsOneWidget);
  });
}
