import 'package:flutter/material.dart';

/// Abstract: 本篇练习常用布局 widget, 对应官网是： https://flutter.cn/docs/development/ui/layout#common-layout-widgets
// 为了最大限度的减少高度嵌套的布局代码，可以在变量和函数中实现 UI 的各个部分

var stars = Row(
  mainAxisSize: MainAxisSize.min,
  children: <Widget>[
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.green[500]),
    Icon(Icons.star, color: Colors.black),
    Icon(Icons.star, color: Colors.black),
  ],
);

final ratings = Container(
  padding: EdgeInsets.all(20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      stars,
      Text(
        '170 Reviews',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w800,
          fontFamily: 'Roboto',
          letterSpacing: 0.5,
          fontSize: 20,
        ),
      ),
    ],
  ),
);

final descTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w800,
  fontFamily: 'Roboto',
  letterSpacing: 0.5,
  fontSize: 18,
  height: 2,
);

final iconList = DefaultTextStyle.merge(
  style: descTextStyle,
  child: Container(
    padding: EdgeInsets.all(20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          children: <Widget>[
            Icon(Icons.kitchen, color: Colors.green[500]),
            Text('PERP.'),
            Text('25 min'),
          ],
        ),
        Column(
          children: <Widget>[
            Icon(Icons.timer, color: Colors.green[500]),
            Text('COOK.'),
            Text('1 hr'),
          ],
        ),
        Column(
          children: [
            Icon(Icons.restaurant, color: Colors.green[500]),
            Text('FEEDS:'),
            Text('4-6'),
          ],
        ),
      ],
    ),
  ),
);

final leftColumn = Container(
  padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
  child: Column(
    children: <Widget>[
      // titleText,
      // subTitle,
      ratings,
      iconList,
    ],
  ),

);

// Stack 示例
Widget _buildStack() => Stack(
  alignment: const Alignment(0.6, 0.6),
  children: <Widget>[
    CircleAvatar(
      backgroundImage: AssetImage('images/pic.jpg'),
      radius: 100,
    ),
    Container(
      decoration: BoxDecoration(
        color: Colors.black45,
      ),
      child: Text(
        'Mia B',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  ],
);

// Card 示例
// 使用 SizeBox 来调整大小。
Widget _buildCard() => SizedBox(
  height: 210,
  child: Card(
    child: Column(
      children: <Widget>[
        ListTile(
          title: Text(
            '1625 Main Street',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          subtitle: Text('My City, CA 99984'),
          leading: Icon(
            Icons.restaurant_menu,
            color: Colors.blue[500],
          ),
        ),
        Divider(),
        ListTile(
          title: Text(
            '(408) 555-1212',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          leading: Icon(
            Icons.contact_phone,
            color: Colors.blue[500],
          ),
        ),
        ListTile(
          title: Text('costa@example.com'),
          leading: Icon(
            Icons.contact_mail,
            color: Colors.blue[500],
          ),
        ),
      ],
    ),
  ),
);
