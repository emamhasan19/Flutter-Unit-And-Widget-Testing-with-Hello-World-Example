import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:unit_and_widget_testing_flutter/main.dart';

void main() {
  group('Widget Test', (){
    testWidgets('HelloWorldWidget displays "Hello, World!"', (WidgetTester tester) async {
      // Build the HelloWorldWidget inside a MaterialApp (find.text)
      await tester.pumpWidget(MaterialApp(home: HelloWorldWidget()));
      expect(find.text('Hello, World!'), findsOneWidget);
    });

    testWidgets('The app displays "Hello, World!" on the main screen', (WidgetTester tester) async {
      // Build the main app (find.byKey)
      await tester.pumpWidget(MyApp());
      expect(find.byKey(Key('helloText')), findsOneWidget);
    });

    testWidgets('The app displays "Hello, World!" in a text widget', (WidgetTester tester) async {
      // Build the HelloWorldWidget inside a MaterialApp (find.byWidget)
      await tester.pumpWidget(MaterialApp(home: HelloWorldWidget()));
      
      // Locate the HelloWorldWidget by using the widget itself
      final helloWorldWidget = find.byWidgetPredicate(
            (widget) => widget is Text && widget.data == 'Hello, World!',
        description: 'Hello World Text Widget',
      );

      expect(helloWorldWidget, findsOneWidget);
    });

  });
}
