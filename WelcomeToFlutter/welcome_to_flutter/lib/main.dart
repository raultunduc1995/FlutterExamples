import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup new generator',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordsState createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();

  final _bigFontTextStyle = const TextStyle(fontSize: 18);

  Widget _buildAppBar() {
    return AppBar(
      title: const Text('Startup new generator'),
      actions: [
        IconButton(
          icon: const Icon(Icons.list),
          onPressed: _showFavouritesList,
        ),
      ],
    );
  }

  void _showFavouritesList() {
    final favouritesPage = _getFavouritesPage();

    Navigator.of(context).push(favouritesPage);
  }

  MaterialPageRoute<void> _getFavouritesPage() {
    return MaterialPageRoute<void>(
      builder: (BuildContext context) {
        final tiles = _saved.map((wordPair) {
          return ListTile(
            title: Text(
              wordPair.asPascalCase,
              style: _bigFontTextStyle,
            ),
          );
        });
        final divided = ListTile.divideTiles(
          context: context,
          tiles: tiles,
        ).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Favourites'),
          ),
          body: ListView(children: divided),
        );
      },
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(10),
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) return const Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length)
          _suggestions.addAll(generateWordPairs().take(10));

        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySaved = _saved.contains(wordPair);

    return ListTile(
      title: Text(
        wordPair.asPascalCase,
        style: _bigFontTextStyle,
      ),
      subtitle: const Text(
        'Click on the favourite icon',
        style: const TextStyle(
          fontSize: 12,
          color: Colors.grey,
        ),
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        _onItemClicked(wordPair);
      },
    );
  }

  void _onItemClicked(WordPair item) {
    final alreadySaved = _saved.contains(item);

    setState(() {
      if (alreadySaved)
        _saved.remove(item);
      else
        _saved.add(item);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildList(),
    );
  }
}
