import 'package:flutter/material.dart';
import 'package:good_news_app/news_request.dart';
import 'package:good_news_app/news_widget.dart';
import 'package:good_news_app/news.dart';
import 'package:good_news_app/search_widget.dart';

void main() => runApp(App());

class App extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Good News Everyone',
      theme: ThemeData(
// This is the theme of your application.
//
// Try running your application with "flutter run". You'll see the
// application has a blue toolbar. Then, without quitting the app, try
// changing the primarySwatch below to Colors.green and then invoke
// "hot reload" (press "r" in the console where you ran "flutter run",
// or simply save your changes to "hot reload" in a Flutter IDE).
// Notice that the counter didn't reset back to zero; the application
// is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: NewsList(title: 'Home'),
    );
  }
}

class NewsList extends StatefulWidget {
  final String title;
  NewsList({Key key, this.title}) : super(key: key);

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  List<News> newsList = [];
  List<News> searchList;

  onSearchChanged(String search) {
    setState(() {
      print(search);
      if (search != "") {
        this.searchList = this
            .newsList
            .where((e) => e.title.toLowerCase().contains(search.toLowerCase()))
            .toList();
      }else{
        this.searchList = this.newsList;
      }

      print(searchList.length);
    });
  }

  @override
  void initState() {
    NewsRequest.getNews((List news) => setState(() {
          this.newsList = news;
          this.searchList = news;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      child: Stack(children: [
        ShaderMask(
            child: ListView.builder(
              itemBuilder: (_, i) => NewsWidget(key: Key(searchList[i].url), news: searchList[i]),
              itemCount: searchList.length,
              padding: EdgeInsets.fromLTRB(0, 70, 0, 0),
              //https://stackoverflow.com/a/53029458
            ),
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment(0, -1),
                end: Alignment(0, -0.75),
                colors: <Color>[Colors.transparent, Colors.white],
              ).createShader(
                  (Rect.fromLTRB(0, 0, bounds.width, bounds.height)));
            },
            blendMode: BlendMode.dstIn),
        SearchBar(
          onChanged: this.onSearchChanged,
        )
      ]),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(235, 252, 255, 1),
                Color.fromRGBO(0, 188, 243, 1)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0, 1])),
    )));
  }
}
