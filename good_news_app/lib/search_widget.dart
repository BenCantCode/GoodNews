import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  ///Called when the input changes
  Function onChanged;
  SearchBar({Key key, this.onChanged}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
          children: <Widget>[
            Icon(Icons.search),
            Expanded(child: Padding(child:TextField(onChanged: this.widget.onChanged,), padding: EdgeInsets.fromLTRB(16, 0, 16, 0),))
          ],
        ),
        height: 54, decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 6,
                spreadRadius: 2,
                offset: Offset(0, 4),
                color: Color.fromRGBO(10, 15, 50, 0.25))
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(8)),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
    );
  }
}
