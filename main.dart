import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   // final wordPair = WordPair.random();// <3
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'hi redna',
        theme: ThemeData(
        primaryColor: Colors.red[200],),
     home:RandomWords(),


     /* title: 'hello redna',
      home: Scaffold(
        appBar: AppBar(
          title: Text('hello redna'),
        ),
        body: Center(
          /*child: Text(wordPair.asPascalCase,
          style: new TextStyle(
            fontSize: 36.0
          ))*///<3
          child: RandomWords(),
        ),
      ),*/
       // title: 'Startup Name Generator',
         //                home: RandomWords(),
    );
  }
}






class RandomWordsState extends State<RandomWords> {
  final wordPair = WordPair.random();
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 28.0);
  final _saved = Set<WordPair>();

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved
            ? Icons.sentiment_very_satisfied
            : Icons.sentiment_very_dissatisfied,
        color: alreadySaved
            ? Colors.yellow
            : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        }); //setState
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Redna_First_App'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.list,
            ),
            onPressed: _favorites,
          )
        ],
      ),
      body: _buildSuggestions(),
    );
    return Text(wordPair.asPascalCase);



  }

  void _favorites() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      final tiles = _saved.map((suggestion) {

        return ListTile(
          title: Text(
            suggestion.asPascalCase,
            style: _biggerFont,
          ),
        );
      });

      final divided =
      ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: Text('hlooo Rdoon'),
        ),
        body: ListView(
          children: divided,
        ),
      );
    }));
  }
}







class RandomWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}
