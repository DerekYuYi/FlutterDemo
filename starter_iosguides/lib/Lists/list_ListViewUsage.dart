import 'package:flutter/material.dart';

// basic listview

// 短列表，一次性创建所有列表项
class ShortListDemo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final title = "Basic List";

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
            ),
            ListTile(
              leading: Icon(Icons.phone_locked),
              title: Text('phone_locked'),
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('phone'),
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
            ),
          ],
        ),
      ),
    );
  }
}

// 对于具有大量列表项的长列表，需要使用 ListView.builder 构造函数来创建
// 从列表外滑入屏幕时才会创建.
class LongListDemo extends StatelessWidget {
  final List<String> items;
  
  LongListDemo({Key key, @required this.items}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final title = 'Long List';
    
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(title: Text(title)),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${items[index]}'),
            );
          },
        ),
      ),
      
    );
  }
}