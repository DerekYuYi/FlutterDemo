import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'Gesture Demo';

    return MaterialApp(
      title: title,
      home: MyHomePage(title: title),
    );
  }

}

class MyHomePage extends StatelessWidget {
  
  final String title;
  
  MyHomePage({ Key key, this.title }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(child: FlatButton()),
//      body: Center(child: MyButton()),
    );
  }

}

// 自定义 Button
// 使用 InkWell 包裹需要显示涟漪效果的控件，即可显示涟漪效果

class MyButton extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
      // When the child is tapped, show a snackbar.
      onTap: () {
        final snackBar = SnackBar(content: Text('Tap'));
        Scaffold.of(context).showSnackBar(snackBar);
      },
      
      child: Container(
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text('My Button'),
      ),
    );
  }
  
}

class FlatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return InkWell(

      onTap: () {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Tap')));
      },

      child: Container(
        padding: EdgeInsets.all(12.0),
        child: Text('Flat Button'),
      ),
    );

  }
}
