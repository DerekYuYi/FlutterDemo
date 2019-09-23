import 'package:flutter/material.dart';

import 'package:starter_iosguides/colors.dart';

// 封装新的 Widget: 改变 Widget 的 Accent 颜色值为自定义颜色
class AccentColorOverride extends StatelessWidget {
  const AccentColorOverride({Key key, this.color, this.child}) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: child,
      data: Theme.of(context).copyWith(accentColor: color),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MDC',
      theme: ThemeData(
          primarySwatch: Colors.orange),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          children: <Widget>[
            SizedBox(height: 80.0),
            Column(
              children: <Widget>[
                Image.asset(
                  'assets/diamond.png',
                  color: kShrineBackgroundWhite,
                ),
                SizedBox(height: 16.0),
                Text('SHRINE'),
              ],
            ),
            SizedBox(height: 120.0),
            AccentColorOverride(
              color: kShrineAltYellow,
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            SizedBox(height: 12.0),
            AccentColorOverride(
              color: kShrineAltYellow,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                // 是否打开密码模式
                obscureText: true,
              ),
            ),
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text('CANCEL'),
                  // 传递 null 表示该按钮会被禁用，传递空的代码块，按钮不会被禁用
                  onPressed: () {
                    // clear the text fields
                    _usernameController.clear();
                    _passwordController.clear();
                  },
                ),
                RaisedButton(
                  child: Text('NEXT'),
                  elevation: 8.0,
                  onPressed: () {
                    // show the next page
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

