import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new Scaffold(
//        appBar: new AppBar(
//          title: new Text('Welcome to Flutter-appbar'),
//        ),
        body: new Center(
//          child: new Text('Hello World'),
//          child: new Text(wordPari.asPascalCase),
            child: new RandomWords(),
        ),
      ),
    );

  }
}

class RandomWords extends StatefulWidget{
  @override
  createState()=>new RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFront = const TextStyle(fontSize: 18.0);

  Widget _buildSuggestions(){
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context,i){
            if(i.isOdd) return new Divider();
            final index = i ~/2;
            if(index >= _suggestions.length){
              _suggestions.addAll(generateWordPairs().take(10));
            }
            return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair){
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFront,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: (){
        setState(
            (){
              if(alreadySaved){
                _saved.remove(pair);
              }else{
                _saved.add(pair);
              }
            }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
//    final wordPair = new WordPair.random();
//    return new Text(wordPair.asPascalCase);
    return new Scaffold(
      appBar: new AppBar(
          title: new Text('Start up Generator'),
          actions: <Widget>[
            new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
          ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved(){
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context){
            final tiles = _saved.map(
                (pair){
                  return new ListTile(
                    title: new Text(
                      pair.asPascalCase,
                      style: _biggerFront,
                    ),
                  );
                }
            );
            final divied = ListTile.divideTiles(
                context: context,
                tiles:tiles,
            ).toList();

            return new Scaffold(
              appBar: new AppBar(
                title: new Text('Saved Suggestion'),
              ),
              body: new ListView(children: divied,),
            );
          }
      )
    );
  }
}