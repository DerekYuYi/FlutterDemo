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

// Define a corresponding State less.
// This class holds the data related to the form.
class _MyCustomFormState extends State<MyCustomForm> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('retrieve Text input'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller:  myController,
        ),
      ),
      // When the user presses the button, show an alert dialog containing the
      // text that the user entered into the text field.
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(myController.text),
              );
            },
          );
        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}