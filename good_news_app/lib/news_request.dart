import 'dart:convert';

import 'package:good_news_app/news.dart';
import 'package:http/http.dart' as http;

class NewsRequest {
  static var url = "https://goodnewsbucket.s3.us-east-2.amazonaws.com/data/articles.json";
  static requestNews(Function onSuccess, Function onError) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      onSuccess(response.body);
    } else {
      onError(response.statusCode);
    }
  }

  static getNews(Function callback) async {
    requestNews((String json) {
      print(json);
      List decoded = jsonDecode(json);
      callback(decoded.map((e) {
        return new News(e["title"], e["description"], e["publisher"], e["thumbnail"],
            e["publish_date"], e["tags"], e["url"]);
      }).toList());
    }, () => callback([]));
  }
}
