import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {

  MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final title = 'Floating App Bar';

    return MaterialApp(
      title: title,
      home: Scaffold(
        // No appBar property provided, only the body.
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: Text('Floating app bar'),
              // Allows the user to reveal the app bar if they begin scrolling back up the list of items.
              floating: true,

              // Display a placeholder widget to visualize the sharinking size.
              flexibleSpace: Placeholder(),

              expandedHeight: 200,
            ),

            // Create a SliverList
            SliverList(
              // Use a delegate ti build items as they're scrolled on screen.
                delegate: SliverChildBuilderDelegate(
                    (context, index) => ListTile(title: Text('Item #$index')),
                  childCount: 1000,
                ),
            ),
          ],
        ),
      ),
    );

  }

}