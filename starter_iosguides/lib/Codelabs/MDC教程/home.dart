import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            semanticLabel: 'Menu',
          ),
          onPressed: () {
            debugPrint('Menu button');
          },
        ),
        // 标题尾部添加按钮。在 Flutter 中它们被称为 'actions'.
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              semanticLabel: 'search',
            ),
            onPressed: () {
              debugPrint('Search button');
            },
          ),
          IconButton(
            icon: Icon(
              Icons.tune,
              semanticLabel: 'filter',
            ),
            onPressed: () {
              debugPrint('Tune button');
            },
          ),
        ],
        title: Text('SHRINE'),
      ),
      
      body: GridView.count(
        crossAxisCount: 2, // 指不可滚动轴展示的数量，这里是水平方向
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 18.0 / 11.0,
                  child: Image.asset('assets/diamond.png'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Title'),
                      SizedBox(height: 8.0),
                      Text('Secondary Text'),
                    ],
                  ),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}

