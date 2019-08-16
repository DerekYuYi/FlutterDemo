import 'package:flutter/material.dart';
import 'dart:math';

// 要更新按钮，有状态的维护，首先需要创建 StatefulWidget 类 和 State 类. 定义在 State 类中
// 的属性才会有状态的更新.
// 属于 State 类的属性才会有状态更新

class AnimatedContainerApp extends StatefulWidget {
  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<AnimatedContainerApp> {
  // Define the various properties with default values, Update these properties
  // when the user taps a FloatingActionButton.
  double _width = 50;
  double _height = 50;

  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedContainer Demo'),
        ),
        body: Center(
          child: AnimatedContainer(
            // Define how long the animation should take.
            duration: Duration(seconds: 1),
            width: _width,
            height: _height,

            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            // Provide an optional curve to make the animation feel smoother.
            curve: Curves.fastOutSlowIn,
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {

            // Use setState to rebuild the widget with new values.
            setState(() {
              // Create a random number generator.
              final random = Random();

              // Generate a random width and height.
              _width = random.nextInt(300).toDouble();
              _height = random.nextInt(300).toDouble();

              // Generate a random color.
              _color = Color.fromRGBO(
                  random.nextInt(256),
                  random.nextInt(256),
                  random.nextInt(256),
                  1);

              // Generate a random border radius.
              _borderRadius = BorderRadius.circular(random.nextInt(100).toDouble());

            });
          },
        ),
      ),
    );
  }
}