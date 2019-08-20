import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Opacity Demo';
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

// The StatefulWidget's job is to take data and create a State class.
// In this case, the widget takes a title, and creates a _MyHomePageState.
class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// The State class is responsible for two things: holding some data you can update
// and building the UI using the that data.
class _MyHomePageState extends State<MyHomePage> {
  // Whether the green box should be visible
  bool _visible = true;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),

            // The widget to animate.
            // The green box must be a child of the animatedOpacity widget.
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.green,
            )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            setState(() {  _visible = !_visible; });
            },
        tooltip: 'Toggle Opacity',
        child: Icon(Icons.flip),
      ),
    );
  }
}