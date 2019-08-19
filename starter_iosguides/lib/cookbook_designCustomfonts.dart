import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom fonts',
      theme: ThemeData(fontFamily: 'Raleway'),
      home: MyHomePage(),
    );
  }

}

class MyHomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Custom Fonts')),
      body: Center(
        child: Text('Roboto Mono sample'),
      ),
    );
  }
}
