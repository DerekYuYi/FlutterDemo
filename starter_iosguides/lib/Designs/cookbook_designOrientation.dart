

/*
*  1. 使用 GridView
*  2. 使用 OrientationBuilder 更改列数
*  3。如果只是想知道屏幕的方向，直接使用 `mediaQuery.of(context).orientation`
* **/

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Orientation Demo';

    return MaterialApp(
      title: appTitle,
      home: OrientationList(title: appTitle),
    );
  }

}

class OrientationList extends StatelessWidget {
  final String title;

  OrientationList({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: OrientationBuilder(
          builder: (context, orientation) {
            return GridView.count(
              // Create a grid with 2 columns in portrait mode, or 3 columns in landscape mode.
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,

              // Generate 100 widgets that display their index in the List.
              children: List.generate(100, (index) {
                return Center(
                  child: Text(
                    'Item $index',
                    style: Theme.of(context).textTheme.headline,
                  ),
                );
              }),
            );
          },
      ),
    );
  }
}