
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final appTitle = 'Form Validation Demo';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }

}

// Define a custom form widget.

class MyCustomForm extends StatefulWidget {

  @override
  MyCustomFormState createState() => MyCustomFormState();
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {

  // Create a global key that uniquely identifies the form widget and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
//  final
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState.validate()) {
                  // if the form is valid, display a Snackbar.
                  Scaffold.of(context).showSnackBar(SnackBar(content: Text('Processing Data')));
                }
                },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}