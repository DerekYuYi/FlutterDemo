import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// 给 iOS 开发者的 Flutter 指南 （https://flutter-io.cn/docs/get-started/flutter-for/ios-devs）
/**
 *  1、 如何更新 widget?
 *  2、 如何对 widget 布局？
 *
 *
 * **/

void main() => runApp(SampleApp());

class SampleApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sample App",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SampleAppPage(),
    );
  }
}


class SampleAppPage extends StatefulWidget {

  SampleAppPage( {Key key}) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}


class _SampleAppPageState extends State<SampleAppPage> {

  String textToShow = "I Like Flutter";

  void _updateText() {
    setState(() {
      // update the text
      textToShow = "Flutter is Awesome!";
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: Center(
        child: CupertinoButton(
          onPressed: () {
            setState(() {
//              _pressedCount += 1;
            });
          },
          color: Colors.orange,
          child: Text('Hello'),
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateText,
        tooltip: 'Update Text',
        child: Icon(Icons.update),
      ),
    );
  }
}