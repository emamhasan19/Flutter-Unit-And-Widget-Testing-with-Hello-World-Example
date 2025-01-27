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

    testWidgets('App bar has correct title', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final titleFinder = find.text('Hello World App');
      expect(titleFinder, findsOneWidget);

      final appBarFinder = find.byType(AppBar);
      expect(appBarFinder, findsOneWidget);

      final AppBar appBar = tester.widget(appBarFinder);
      expect(appBar.title, isA<Text>());
    });

    testWidgets('MaterialApp uses default theme', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final MaterialApp app = tester.widget(find.byType(MaterialApp));
      expect(app.theme, isNull);
      expect(app.darkTheme, isNull);
    });

    testWidgets('Scaffold has correct structure', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      final scaffoldFinder = find.byType(Scaffold);
      expect(scaffoldFinder, findsOneWidget);

      final Scaffold scaffold = tester.widget(scaffoldFinder);
      expect(scaffold.appBar, isNotNull);
      expect(scaffold.body, isA<Center>());
    });

    testWidgets('Text widget has default text style', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HelloWorldWidget()));

      final Text textWidget = tester.widget(find.text('Hello, World!'));
      expect(textWidget.style, isNull);
      expect(textWidget.textAlign, isNull);
    });

    testWidgets('App renders without overflow', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());

      expect(tester.takeException(), isNull);
    });

    testWidgets('App handles different screen sizes', (WidgetTester tester) async {
      final TestWidgetsFlutterBinding binding = TestWidgetsFlutterBinding.ensureInitialized();

      // Test small screen
      await binding.setSurfaceSize(const Size(320, 480));
      await tester.pumpWidget(MyApp());
      expect(find.text('Hello, World!'), findsOneWidget);

      // Test large screen
      await binding.setSurfaceSize(const Size(1024, 768));
      await tester.pumpWidget(MyApp());
      expect(find.text('Hello, World!'), findsOneWidget);
    });

    testWidgets('Text remains visible after frame', (WidgetTester tester) async {
      await tester.pumpWidget(MyApp());
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Hello, World!'), findsOneWidget);
    });

  });
}
