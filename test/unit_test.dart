import 'package:flutter_test/flutter_test.dart';
import 'package:unit_and_widget_testing_flutter/main.dart';

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
