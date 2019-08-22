import 'package:flutter/material.dart';

/*
*  在 Flutter 中， screen 和 page 都叫做 route. Android开发中，Activity 相当于 路由， iOS中，ViewController 相当于路由， flutter 中，
*  路由 也是一个 Widget.
*  Navigator.push(): 添加一个 Route 对象到 Navigator 管理的路由栈上， 这个路由对象来自 MaterialPageRoute. 也可以自定 Route 对象.
*  Navigator.pop(): 会从 Navigator 管理的路由栈上移除当前 Route 对象。
*
* */

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Returning Data',
      home: Scaffold(
        appBar: AppBar(title: Text('Returning Data Demo')),
        body: Center(child: SelectionButton()),
      ),
    );
  }

}

// 点击跳转到选择页面
// 等待选择界面给它返回结果
class SelectionButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
          _navigateAndDisplaySelection(context);
          },
      child: Text('Pick an option, any option!'),
    );
  }

  // A method that launches the SelectionScreen page and await the result from Navigator pop.
  _navigateAndDisplaySelection(BuildContext context) async {

    final result = await Navigator.push(
      context,

      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars and show the new result.
    Scaffold.of(context)..removeCurrentSnackBar()..showSnackBar(SnackBar(content: Text('$result')));
  }
}

class SelectionScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pick an option')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Pop here with 'Yep'
                  Navigator.pop(context, 'Yep!');
                },
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Pop here with 'Nope'
                  Navigator.pop(context, 'Nope!');
                },
                child: Text('Nope.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

