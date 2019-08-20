import 'package:flutter/material.dart';

/*
*  1. create a scafford
*  2. display a snackbar
*  3. provide an optional action
*
* **/

class SnackBarDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SnackBar Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Snackbar demo'),
        ),
        body: SnackBarPage(),
      ),
    );
  }

}


class SnackBarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text('Yay! A SnackBar!'),
            action: SnackBarAction(
                label: 'Undo',
                onPressed: () {}),
          );

          // Find the Scafford in the widget tree and use
          // it to show a SnackBar.
          Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text('Show SnackBar'),
      ),
    );
  }

}
