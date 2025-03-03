import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// 定义一个局部 Theme: 如果只想对局部进行样式修改，可以创建一个  Theme Widget.
// 有两种方式： 1. 定义一个独立的ThemeData;
//            2. 从父级 Theme 扩展

/*
Theme(
    data: ThemeData(
      accentColor: Colors.yellow,
),
    child: FloatingActionButton(
      onPressed: () {},
    child: Icon(Icons.add),
    ),
);
 */

/*
Theme(
    data: Theme.of(context).copyWith(accessColor: Colors.yellow),
    child: FloatingActionButton(
      onPressed: null,
      child: Icon(Icons.add),
    ),

    );
*/
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final appName = 'Custom Themes';

    return MaterialApp(
      title: appName,
      // 定义的全局的 Theme
      theme: ThemeData(
        // define the default brightness and colors.
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],

        // define the default font family/
        fontFamily: 'Montserrat',

        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: MyHomePage(title: appName),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final String title;

  MyHomePage({Key key, @required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Container(

          color: Theme.of(context).accentColor,
          child: Text(
            'Text with a background color',
            style: Theme.of(context).textTheme.title,
          ),
        ),
      ),
      floatingActionButton: Theme(
        // 从父级 Theme 扩展
        // Find and extend the parent theme using "copyWith".
        data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(secondary: Colors.yellow)),
        child: FloatingActionButton(
          onPressed: null,
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}