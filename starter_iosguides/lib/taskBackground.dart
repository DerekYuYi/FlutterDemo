import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:isolate';

// Isolate 是相互隔离的执行线程，并不和主线程共享内存，这意味着你不能够访问主线程的变量， 也不能使用 setState() 来更新 UI
// 在 Isolate 中， 你可以处理 CPU 密集型任务（如解析一个庞大的 JSON 文件）, 或者处理复杂的数学运算，比如加密操作或者信号处理等

class SmapleApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Sample App",
      theme: ThemeData(
        primarySwatch: Colors.orange[200],
      ),
      home: SampleAppPage(),
    );
  }
}

class SampleAppPage extends StatefulWidget {
  SampleAppPage( { Key key }) : super(key: key);

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

  showLoadingDialog() {
    if (widgets.length == 0) {
      return true;
    } else {
      return false;
    }
  }

  getBody() {
       if (showLoadingDialog()) {
         return getProgressDialog();
       } else {
         return getListView();
    }
  }

  getProgressDialog() {
    return Center(child: CircularProgressIndicator());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample App"),
      ),
      body: getBody()
    );
  }

  ListView getListView() => ListView.builder(
    itemCount: widgets.length,
    itemBuilder: (BuildContext context, int position) {
      return getRow(position);
    }
  );

  Widget getRow(int i) {
    return Padding(padding: EdgeInsets.all(10.0), child: Text("Row ${widgets[i]["title"]}"))
  }

  /// load the request data.
  loadData() async {
    ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(receivePort, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;

    List msg = await sendReceive(sendPort, "https://jsonplaceholder.typicode.com/posts");

    setState(() {
      widgets = msg;
    });

  }

}


