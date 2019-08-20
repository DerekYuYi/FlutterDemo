/*
* 如何在每次文本内容改变时调用回调函数？
* - 给 TextField 绑定 onChanged() 回调；
* - 使用 TextEditingController
* - 文本框组件：TextfField 和 TextFormField
**/

import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Retrieve Text Input',
      home: MyCustomForm(),
    );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller. Later, use it to retrieve the current value of the TextField.
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    myController.addListener(_printLastestValue);
  }

  @override
  void dispose() {

    // Clean up the controller when the widget is removed from the widget tree.
    myController.dispose();
    super.dispose();
  }

  _printLastestValue() {
    print("Second text field: ${myController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Retrive Text Input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (text) {
                print('first text field: $text');
              },
            ),
            // bind to TextField
            TextField(
              controller: myController,
            ),
          ],
        ),
      ),
    );
  }
}