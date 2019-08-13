import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// 使用 async + await 来执行异步请求


class SampleApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample title',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SampleAppPage(),
    );
  }

}

class SampleAppPage extends StatefulWidget {
  SampleAppPage( {Key key} ) : super(key: key);

  @override
  _SampleAppPageState createState() => _SampleAppPageState();
}

class _SampleAppPageState extends State<SampleAppPage> {
  List widgets = [];

  @override
  void initState() {
    super.initState();

    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: ListView.builder(
          itemCount: widgets.length,
          itemBuilder: (BuildContext context, int position) {
            return getRow(position);
          }));
  }

  Widget getRow(int i) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Text("Row ${widgets[i]["title"]}")
    );
  }

  // 使用 async 来异步请求网络，在异步请求网络中使用 await 来同步等待异步结果，这就是处理网络或数据请求等 I/O 操作的经典做法。
  loadData() async {
    String dataURL = "https://jsonplaceholder.typicode.com/posts";
    // 一旦 await 等待网络操作结束，就调用 setState() 来更新 UI，这会触发 widget 子树的重新构建并更新数据.
    http.Response response = await http.get(dataURL);
    setState(() {
      widgets = json.decode(response.body);
    });
  }


}



