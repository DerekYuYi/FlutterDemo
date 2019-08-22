import 'package:flutter/material.dart';


/*
* 传递参数给特定路由：通过提供额外的 arguments 给 Navigator.pushNamed(）方法
* 获取参数：使用 ModalRoute.of 方法 或者 MaterialApp 和 CupertinoApp 构造器中的 onGenerateRoute() 来获取参数
* **/


class ScreenArguments {
  final String title;
  final String message;

  ScreenArguments(this.title, this.message);
}


class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 处理命名路由。这个方法会辨别被 push 的命名路由
      onGenerateRoute: (settings) {
        if (settings.name == PassArgumentsScreen.routename) {
          final ScreenArguments args = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        } else {
          return null;
        }
      },
      title: 'Navigation with Arguments',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            // 第一种情况： The named route extracts the arguments by itself.
            RaisedButton(
              child: Text("Navigate to screen that extracts arguments"),
              onPressed: () {

                // navigate to the specific route and provide the arguments as part of the RouteSettings.
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExtractArgumentsScreen(),
                    // Pass the arguments as part of the RouteSettings.
                    // The ExtractArgumentScreen reads the arguments from these settings.
                    settings: RouteSettings(
                      arguments: ScreenArguments(
                        'Extract Arguments Screen',
                        'This message is extracted in the build method.',
                      ),
                    ),
                  ),
                );
              },
            ),

            // 第二种情况：这个路由在 onGenerateRoute 函数中提取参数
            RaisedButton(
              child: Text("Navigate to a named that accepts arguments"),
              onPressed: () {
                Navigator.pushNamed(
                    context,
                    PassArgumentsScreen.routename,
                  arguments: ScreenArguments(
                    'Accept Arguments Screen',
                    'This message is extracted in the onGenerateRoute function.',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// A widget that extracts the necessary arguments from the modalRoute.
class ExtractArgumentsScreen extends StatelessWidget {

  // TODO: - 记录
  static const routeName = '/extractArguments';
  
  @override
  Widget build(BuildContext context) {
    
    // Extract the parameters from the current ModalRoute settings and cast them as ScreenArguments.
    final ScreenArguments args = ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
      ),
      body: Center(
        child: Text(args.message),
      ),
    );
    
  }
  
}

// A Widget that accepts the necessary arguments via the constructor.
class PassArgumentsScreen extends StatelessWidget {
  static const routename = '/passArguments';

  final String title;
  final String message;

  // 从构造参数中获取参数， 而不是从 ModalRoute 中提取参数

  // 从 MaterialApp widget 提供的 onGenerateRoute 函数中获取参数值
  const PassArgumentsScreen({
    Key key,
    @required this.title,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(message),
      ),
    );
  }
}