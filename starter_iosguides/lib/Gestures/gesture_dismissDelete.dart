import 'package:flutter/material.dart';

/*
 * 使用 Dismissible 来实现滑动删除功能。
 * 用法： 把列表中的每个单项使用 Dismissible 打包。
 * 
 * */


// MyApp is a StatefulWidget. This allows updating the
// state of the widget when an item is removed.
class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
  
}

class MyAppState extends State<MyApp> {
  final items = List<String>.generate(10, (i) => "Item ${i + 1}");

  @override
  Widget build(BuildContext context) {
    final title = 'Dismissing Items';

    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return Dismissible(

              // Each Dismissible must contain a Key. Keys allow Flutter to uniquely identify widgets.
              key: Key(item),

              // 移除后的操作所做的操作
              onDismissed: (direction) {
                setState(() {
                  // 从数据源删除数据
                  items.removeAt(index);
                });

                // 显示 snackbar
                Scaffold.of(context).showSnackBar(SnackBar(content: Text("$item dismissed")));
              },
              child: ListTile(title: Text('$item')),
              // item 被滑出时，显示为红色背景
              background: Container(color: Colors.red),
            );
          },
        ),
      ),
    );
  }
}

