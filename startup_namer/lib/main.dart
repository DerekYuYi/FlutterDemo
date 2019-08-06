import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final wordPair = WordPair.random();
    return MaterialApp(
      title: 'Startup Name Generator',
      home: RandomWords(),
    );
  }
}


class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final _suggestions = <WordPair>[];
    final _biggerFont = const TextStyle(fontSize: 18.0);

    return Scaffold(
      appBar: AppBar(title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );



//    final wordPair = WordPair.random();
//    return Text(wordPair.asPascalCase);
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) {
          if (i.isOdd) return Divider(); // add one-pixel-high divider widget

          final index = i ~/ 2; // 求除数
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_buildSuggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    return ListTile (
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
    );
  }

}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

