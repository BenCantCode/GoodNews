import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'news.dart';
import 'custom_expansion_tile.dart';

class NewsWidget extends StatefulWidget {
  final News news;

  NewsWidget({Key key, this.news}) : super(key: key);

  @override
  _NewsWidgetState createState() => _NewsWidgetState(news);
}

class _NewsWidgetState extends State<NewsWidget> {
  final News newsStory;
  bool expanded = false;
  StreamController _expandedStreamController = new StreamController();
  _NewsWidgetState(this.newsStory);

  @override
  Widget build(BuildContext context) {
    print(newsStory.uploadDate);
    final theme = Theme.of(context).copyWith(
        dividerColor: Colors
            .transparent); //needed for removing dividers in expansion tile.
    return Theme(
        data: theme,
        child: Container(
          child: CustomExpansionTile(
            expandStream: _expandedStreamController.stream,
            onTap: () async {
              if (await canLaunch(newsStory.url)) {
                launch(newsStory.url);
              }
            },
            title: Row(
              children: <Widget>[
                Padding(
                  child: GestureDetector(
                    child: ConstrainedBox(
                      child: FittedBox(
                          child: ClipRRect(
                            child: Image.network(newsStory.thumbnailURL),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          fit: BoxFit.cover),
                      constraints: BoxConstraints.tight(Size(64, 64)),
                    ),
                    onTap: () {
                      expanded = !expanded;
                      _expandedStreamController.add(expanded);
                    },
                  ),
                  padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                ),
                Expanded(
                    child: Column(
                  children: <Widget>[
                    Column(children: <Widget>[
                      Text(newsStory.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 14)),
                      SingleChildScrollView(child:Row(
                          children: newsStory.tags
                              .map((e) => Container(
                                    child: FittedBox(
                                        child: Chip(
                                          label: Text(e,
                                              style: TextStyle(fontSize: 18)),
                                        ),
                                        fit: BoxFit.scaleDown),
                                    constraints: BoxConstraints(maxHeight: 30),
                                    margin: EdgeInsets.only(left: 2),
                                  ))
                              .toList()), scrollDirection: Axis.horizontal,)
                    ], crossAxisAlignment: CrossAxisAlignment.start),
                    Column(
                      children: <Widget>[
                        Text(
                          newsStory.description,
                          maxLines: 2,
                        ),
                        Text(newsStory.source + " · " + newsStory.uploadDate)
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    )
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ))
              ],
            ),
            children: [
              Container(
                child: ClipRRect(
                  child: Image.network(newsStory.thumbnailURL),
                  borderRadius: BorderRadius.circular(8),
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
                padding: EdgeInsets.all(8),
              ),
            ],
            trailing: Container(
              width: 0,
              height: 0,
            ),
            initiallyExpanded: this.expanded,
          ),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 8,
                    spreadRadius: 1,
                    offset: Offset(0, 4),
                    color: Color.fromRGBO(10, 15, 50, 0.2))
              ],
              color: Color.fromRGBO(255, 255, 255, 0.9),
              borderRadius: BorderRadius.circular(8)),
          margin: EdgeInsets.fromLTRB(8, 0, 8, 8),
        ));
  }
}
