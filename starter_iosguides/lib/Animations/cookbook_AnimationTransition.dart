import 'package:flutter/material.dart';

class Page1 extends StatelessWidget {

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RaisedButton(
          child: Text('Go!'),
          onPressed: () {
            // push operator
            Navigator.of(context).push(_createRoute());
          },
        ),
      ),
    );

  }

}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => Page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {

      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;

      // use a CurveTween
      var curve = Curves.ease;
      var curveTween = CurveTween(curve: curve);

      // Combine the two Tweens
      var tween = Tween(begin: begin, end: end).chain(curveTween);
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
          position: offsetAnimation,
          child: child,
      );
    },

    // another way to create an Animation<Offset> with an easing curve is to use a CurvedAnimation:
    /*
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end);
      var curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: curve,
      );

      return SlideTransition(
        position: tween.animate(curvedAnimation),
        child: child,
      );
    },
    */

  );
}

class Page2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          'Page 2',
          style: TextStyle(
            fontFamily: 'Raleway',
            package: 'fonts',
          ),
        ),
      ),
    );
  }
}