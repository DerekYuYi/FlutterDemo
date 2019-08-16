import 'package:flutter/material.dart';


class SampleApp extends StatefulWidget {
  SampleApp( { Key key } ) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SampleAppPage();
  }
}

class SampleAppPage extends State<SampleApp> with TickerProviderStateMixin {

  AnimationController controller;
  CurvedAnimation curve;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 2000), vsync: this);
    curve = CurvedAnimation(parent: controller, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          child: RotationTransition(
              turns: curve,
            child: FlutterLogo(
              size: 200,
            ),
          ),
          onDoubleTap: () {
            if (controller.isCompleted) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
        ),
      ),
    );
  }
}