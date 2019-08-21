import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// 在列表中创建不同列表项单元
// 第一步，创建一个拥有不同单元类型的数据源；
// 第二步，把数据源转换成不同 Widgets 的 List.

class MyApp extends StatelessWidget {

  // 提供数据源参数作为初始化。声明的时候赋予新的值
  final List<ListItem> items;

  MyApp({Key key, @required this.items}) : super(key: key);

  List<ListItem> itemList() {
    return List<ListItem>.generate(1000, (i) => i % 6 == 0 ? HeadingItem("Heading $i") : MessageItem('Sender $i', 'Message body $i'));
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Mixed List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(

          // Let the listView know how many items it needs to build.
          itemCount: items.length,

          // Provide  a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type if item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            if (item is HeadingItem) {
              return ListTile(
                title: Text(
                  item.heading,
                  style: Theme.of(context).textTheme.headline,
                ),
              );
            } else if (item is MessageItem) {
              return ListTile(
                title: Text(item.sender),
                subtitle: Text(item.body),
              );
            }
          },
        ),
      ),
    );
  }
}



// The base class of the different types of items the list can contain.
abstract class ListItem {}

// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}