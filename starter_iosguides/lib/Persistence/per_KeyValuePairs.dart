import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
* Abstract: 存储键值对数据
* 通常你需要在两个平台用原生的方式存储数据。
* 幸运的是 shared_preferences 插件可以把 key-value 保存到磁盘中。
* 它通过封装 iOS 上的 NSUserDefaults 和 Android 上的 SharedPreferences 为简单数据提供持久化存储。
*
* Setter 方法做两件事：首先，同步更新 key-value 到内存中，然后保存到磁盘中
* setter 对应一个 getter 方法
* 使用 remove() 方法删除数据
* 虽然使用 key-value 存储非常简单方便，但是它也有以下局限性：
    - 只能用于基本数据类型： int、double、bool、string 和 stringList。
    - 不适用于大量数据的存储。
* */

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preferences demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Shared preferences demo'),
    );
  }

}

class MyHomePage extends StatefulWidget {

  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter = (prefs.getInt('counter') ?? 0);
      prefs.setInt('counter', _counter);
    });
  }

  _incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      int tempCount = (prefs.getInt('counter') ?? 0);
      _counter = tempCount + 1;
      prefs.setInt('counter', _counter);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(''),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
