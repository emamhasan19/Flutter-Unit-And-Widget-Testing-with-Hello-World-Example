# Unit and Widget Testing with Hello World

This project demonstrates a simple Flutter application displaying the text Hello, World!. It includes examples of unit and widget tests to ensure functionality and UI integrity.

## Steps to Write Effective Tests

### 1. Identify Test Cases

- Understand the behavior and functionality to test.
- For unit tests: Focus on individual methods.
- For widget tests: Focus on UI elements and interactions.

### 2. Set Up Test Environment

- Create test files with _test.dart suffix
- Place in the test/ directory
- Import the necessary packages: import 'package:flutter_test/flutter_test.dart';
- Mock any dependencies if required.

### 3. Write the Test

- Arrange: Set up test data and conditions
- Act: Perform the action being tested
- Assert: Verify the results
- Use group to organize tests logically.
- Write descriptive test names.
- Use matchers like expect to validate outcomes.

### 4. Run the Test

- Use the flutter test command to ensure the tests pass.

### 5. Debug Failing Tests

- Check the failure message.
- Compare expected and actual outcomes.
- Fix issues in the code or the test case as needed.


## Project Directory Structure

```
lib/main.dart          # Main application code

test/
  unit_test.dart     # Unit tests for HelloWorldWidget
  widget_test.dart   # Widget tests for the app
```


## Sample Unit Test

```
void main() {
  //group is used for showing multiple test cases together
  
  group('Unit Test', () {
    final widget = HelloWorldWidget();
    
    //successful test case
    test('getHelloWorldText returns "Hello, World!" - Success', () {
      final text = widget.getHelloWorldText();
      expect(text, 'Hello, World!');
    });
    
    //failed test case
    test('getHelloWorldText returns "Hello, Flutter!" - Failure', () {
      final text = widget.getHelloWorldText();
      expect(text, 'Hello, Flutter!'); // this will fail
    });
    
    test('getHelloWorldText returns non-empty string', () {
      final text = widget.getHelloWorldText();
      expect(text.isNotEmpty, true);
    });

    test('getHelloWorldText is not nullable', () {
      final text = widget.getHelloWorldText();
      expect(text, isNotNull);
    });

    test('getHelloWorldText contains "Hello"', () {
      final text = widget.getHelloWorldText();
      expect(text.contains('Hello'), true);
    });

    test('getHelloWorldText contains "World"', () {
      final text = widget.getHelloWorldText();
      expect(text.contains('World'), true);
    });

    test('getHelloWorldText does not contain numbers', () {
      final text = widget.getHelloWorldText();
      expect(text.contains(RegExp(r'[0-9]')), false);
    });

    test('getHelloWorldText does not contain special characters except comma and exclamation', () {
      final text = widget.getHelloWorldText();
      expect(text.contains(RegExp(r'[^a-zA-Z,\s!]')), false);
    });
    
    test('getHelloWorldText returns string with correct length', () {
      final text = widget.getHelloWorldText();
      expect(text.length, 13); // "Hello, World!" is 13 characters
    });

    test('getHelloWorldText has correct word count', () {
      final text = widget.getHelloWorldText();
      expect(text.split(' ').length, 2);
    });

    test('getHelloWorldText has no leading whitespace', () {
      final text = widget.getHelloWorldText();
      expect(text.startsWith(' '), false);
    });

    test('getHelloWorldText has no trailing whitespace', () {
      final text = widget.getHelloWorldText();
      expect(text.endsWith(' '), false);
    });
    
    test('getHelloWorldText contains no double spaces', () {
      final text = widget.getHelloWorldText();
      expect(text.contains('  '), false);
    });

    test('getHelloWorldText contains only ASCII characters', () {
      final text = widget.getHelloWorldText();
      expect(text.codeUnits.every((char) => char < 128), true);
    });

    test('getHelloWorldText words start with capital letters', () {
      final text = widget.getHelloWorldText();
      final words = text.replaceAll('!', '').split(', ');
      for (var word in words) {
        expect(word[0], matches(RegExp(r'[A-Z]')));
      }
    });

    test('getHelloWorldText remaining letters are lowercase', () {
      final text = widget.getHelloWorldText();
      final words = text.replaceAll('!', '').split(', ');
      for (var word in words) {
        expect(word.substring(1), matches(RegExp(r'^[a-z]+$')));
      }
    });
  });
}

```

## Sample Widget Test

```
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

```

### [Click Here to Read Full Article](https://medium.com/@eemamhhasan/a-beginners-guide-to-unit-and-widget-testing-in-flutter-with-hello-world-example-e47862dedd95)


For help getting started with Flutter Testing, you can also go through the
[online documentation](https://docs.flutter.dev/testing/overview), which provides tutorials,
samples, guidance on unit and widget testing in flutter.
