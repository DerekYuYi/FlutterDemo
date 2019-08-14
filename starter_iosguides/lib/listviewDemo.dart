import 'package:flutter/material.dart';

class SampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sample App",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {

  SampleAppPage ( {Key key}) : super(key: key);

  /*
  @override
  State<StatefulWidget> createState() {
    return _SampleAppPageState();
  }
  */

  @override
  _SampleAppPageState createState() => _SampleAppPageState();

}

class _SampleAppPageState extends State<SampleAppPage> {

  List widgets = [];

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 100; i++) {
      widgets.add(getRow(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),

      // 使用 ListView.Builder 来构建列表，适合数据量大和动态更新 ListView.
      body: ListView.builder(
        itemCount: widgets.length,
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          }),
    );
  }

  Widget getRow(int i) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Text('Row $i'),
      ),
      onTap: () {
        widgets.add(getRow(widgets.length + 1));
        print('row $i');

        /// 使用 setState() 来更新列表。创建一个新的 List, 然后拷贝旧列表中的所有数据到新列表。 这样虽然简单. 但是数据量大的时候，不推荐， 建议使用 ListView.builder()
        /*
        setState(() {
          widgets = List.from(widgets); // 创建一个新表
          widgets.add(getRow(widgets.length + 1));
        });
        */
      },
    );
  }

  _getListData() {

    List<Widget> widgets = [];

    for (int i = 0; i < 100; i++) {
      widgets.add(GestureDetector(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Row $i'),
        ),
        onTap: () {
          print('row tapped');
        },
      ));
    }
    return widgets;
  }
}

