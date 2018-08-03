import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:gankio/widget/home.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Home(),
      theme: new ThemeData(
        primaryColor: Colors.blue,
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomWordsState();
  }
}

class RandomWordsState extends State<StatefulWidget> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        drawer: new Drawer(
          child: new ListView(
              children: <Widget>[
                new UserAccountsDrawerHeader(accountName: null, accountEmail: null),
                new ClipRect(
                  child: new ListTile(
                    title: new Text("IOS"),
                    leading: new Icon(Icons.home),
                    onTap: () {
                      _pushSaved();
                    },
                  ),
                )
              ],
          ),
        ),
        appBar: new AppBar(
          title: new Text("Startup Name Generator"),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
          ],
          bottom: new TabBar(
            isScrollable: true,
            tabs: <Widget>[
              new Tab(
                text: "首页",
                icon: new Icon(Icons.home),
              ),
              new Tab(
                text: "收藏",
                icon: new Icon(Icons.star),
              ),
            ],
          ),
        ),
        body: new TabBarView(
            children: <Widget>[_buildSuggestions(), _buildSaved()]),
      ),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((pair) {
        return new Text(
          pair.asPascalCase,
          style: _biggerFont,
        );
      });
      final divided = ListTile
          .divideTiles(
            tiles: tiles,
            context: context,
          )
          .toList();

      return new Scaffold(
        appBar: new AppBar(
          title: new Text(""),
        ),
        body: new ListView(
          children: divided,
        ),
      );
    }));
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd)
          return new Divider(
            height: 2.0,
            color: Colors.amber,
          );

        final index = i ~/ 2;

        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildSaved() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd)
          return new Divider(
            height: 2.0,
            color: Colors.amber,
          );

        final index = i ~/ 2;

        if (index >= _saved.length) {
          return null;
//            _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_saved[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new IconButton(
        icon: new Icon(
          alreadySaved ? Icons.favorite : Icons.favorite_border,
          color: alreadySaved ? Colors.red : null,
        ),
        onPressed: () {
          setState(() {
            if (alreadySaved) {
              _saved.remove(pair);
            } else {
              _saved.add(pair);
            }
          });
        },
      ),
    );
  }
}
