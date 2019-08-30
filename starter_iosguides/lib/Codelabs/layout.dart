import 'package:flutter/material.dart';

/*
*  Row and Column 是布局的 widget. 它们里面的组件被称为 children, Row 和 Column 被成为 parent.
*  Row 是水平布局，Column 是垂直布局。（by the way, 跟 SwiftUI 里面的 HStack 和 VStack 一样）
*
* mainAxisSize
* mainAxisAlignment
* crossAxisAlignment
*
* fit:
* flex:
*
*  Row and Column first lay out  our widgets of a fixed size.
*  Fixed size widgets are inflexible: they can't resize themselves after they've been laid out.
*
*  Flexible Widget:
*  Expanded Widget: 可以包一个组件， 并且约定组件填满控件
*  SizedBox widget: 当包装一个组件，组件的宽高取决于设置的宽高; 当没有包装组件时, 则创建一个空的 space
*  Spacer Widget: 在不同组件之间创建空白。与 SizedBox 的不同：
* */


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Layout demo",
      theme: ThemeData(
          primarySwatch: Colors.orange),
      home: Scaffold(
        appBar: AppBar(title: Text("Layout Demo")),
        body: DemoWidget(),
      ),
    );
  }
}

class DemoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.account_circle, size: 50),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Flutter McFlutter',
                  style: Theme.of(context).textTheme.headline,
                ),
                Text(
                  'Experienced App Developer',
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8), // space
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('123 Main Street'),
            Text('415-555-0198'),
          ],
        ),
        SizedBox(height: 16), // space

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(Icons.accessibility),
            Icon(Icons.timer),
            Icon(Icons.phone_android),
            Icon(Icons.phone_iphone),
          ],
        ),
      ],
    );
  }
}

class MyWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Layout demo")),
      body: Row(
//        crossAxisAlignment: CrossAxisAlignment.baseline,
////        textBaseline: TextBaseline.alphabetic,
//        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Image.network('https://urlzs.com/RsqCz'),
//          Text(
//            'Hey!',
//            style: TextStyle(
//              fontSize: 30,
//              fontFamily: 'Futura',
//              color: Colors.blue,
//            ),
//          ),
//          Text(
//            'Hey!',
//            style: TextStyle(
//              fontSize: 40,
//              fontFamily: 'Futura',
//              color: Colors.green,
//              backgroundColor: Colors.yellow,
//            ),
//          ),
//          Text(
//            'Hey!',
//            style: TextStyle(
//              fontSize: 50,
//              fontFamily: 'Futura',
//              color: Colors.red,
//            ),
//          ),
        ],
      ),
    );
  }

}

class BlueBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(),
      ),
    );
  }
}

class BiggerBlueBox extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(width: 3.0, style: BorderStyle.none),
      ),
    );
  }

}


/*

flex
Compares itself against other flex properties before determining what fraction of the total remaining space each Flexible widget receives.

*/