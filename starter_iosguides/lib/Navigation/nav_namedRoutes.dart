

/*
* 1、如果我们需要在应用的很多地方导航到同一个界面，这样做就会导致代码重复。可以定义 命名路由 来进行导航。
* 2、使用 Navigator.pushNamed() 跳转， Navigator.pop(）返回；
* 3、在 MeterialApp 的构造函数中添加额外的属性： initialRoute 和 routes 自身。
*     3.1、initialRoute: 定义了应用应该从哪个路由启动
*     3.2、routes: 定义了所有可用的命名路由，以及跳转到这些路由时应该构建的 Widgets.
* 4、确保没有定义 home 属性.
* */

import 'package:flutter/material.dart';

/*
void main() {
  runApp(MaterialApp(
    title: 'Named Routes Demo',

    initialRoute: '/',

    routes: {
      '/': (context) => FirstScreen(),
      '/second': (context) => SecondScreen(),
    },
  ));
}
*/

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Named Routes Demo',
      // Start the app with the '/' named route.
      initialRoute: '/',
      routes: {
        '/': (context) => FirstScreen(),
        '/second': (context) => SecondScreen(),
      },
    );

  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('First Screen')),
      body: Center(
        child: RaisedButton(
          child: Text('Launch Screen'),
          onPressed: () {
            // Navigate to the second screen using a named route.
            Navigator.pushNamed(context, '/second');
          },
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('second Screen'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text("Go back!"),
          onPressed: () {
            // Navigate back to the first screen by popping the current route off the stack.
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}

