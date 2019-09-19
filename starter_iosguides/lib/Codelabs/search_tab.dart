import 'package:flutter/cupertino.dart';


/// 搜索页面。是一个 stateful widget, 因为随着用户输入文本的变化，列表中的内容也会随之变化
class SearchTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SearchTabState();
  }
}

class _SearchTabState extends State<SearchTab> {
  @override
  Widget build(BuildContext context) {

    // 通过嵌套 于CustomScrollView 中的 CupertinoSliverNavigationBar 来实现 iOS11 上的大标题
    return CustomScrollView(
      slivers: const <Widget>[
        CupertinoSliverNavigationBar(
          largeTitle: Text('Search'),
        ),
      ],
    );
  }
}