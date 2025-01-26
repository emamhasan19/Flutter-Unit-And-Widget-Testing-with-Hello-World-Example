import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Hello World App')),
        body: Center(
          child: HelloWorldWidget(),
        ),
      ),
    );
  }
}

class HelloWorldWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      getHelloWorldText(),
      key: Key('helloText'), // A unique key is assigned to identify this widget in widget tests using test key.
    );
  }

  // Logic moved to a method for unit testing
  String getHelloWorldText() {
    return 'Hello, World!';
  }
}
