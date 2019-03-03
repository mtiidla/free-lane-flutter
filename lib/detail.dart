import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class DetailWidget extends StatelessWidget {

  final Set<WordPair> saved;

  DetailWidget({Key key, @required this.saved}) : super(key: key);

  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {

    final Iterable<ListTile> tiles = saved.map(
          (WordPair pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return new Scaffold(
      // Add 6 lines from here...
      appBar: new AppBar(
        title: const Text('Favourite Suggestions'),
      ),
      body: new ListView(children: divided, padding: EdgeInsets.all(16)),
    );
  }
}
