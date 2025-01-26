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
  });
}
