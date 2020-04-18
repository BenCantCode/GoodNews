import 'dart:convert';

import 'package:good_news_app/news.dart';
import 'package:http/http.dart' as http;

class NewsRequest {
  static var url = "https://goodnewsbucket.s3.us-east-2.amazonaws.com/data/";
  static requestNews(Function onSuccess, Function onError) async {
    var date = new DateTime.now().toUtc();
    print(url + _generateDateString(date) + ".json");
    var response = await http.get(url + _generateDateString(date) + ".json");
    try {
      if (response.statusCode == 200) {
        onSuccess(response.body);
      } else {
        date = date.subtract(new Duration(days: 1));
        var response2 =
            await http.get(url + _generateDateString(date) + ".json");
        if (response2.statusCode == 200) {
          onSuccess(response2.body);
        } else {
          onError(response2.statusCode);
        }
      }
    } catch (e) {
      onError();
    }
  }

  static String _generateDateString(DateTime date) {
    return date.year.toString() +
        '-' +
        date.month.toString().padLeft(2, '0') +
        '-' +
        date.day.toString().padLeft(2, '0');
  }

  static getNews(Function callback) async {
    requestNews((String json) {
      print(json);
      List decoded = jsonDecode(json);
      callback(decoded.map((e) {
        return new News(e["title"], e["description"], e["publisher"],
            e["thumbnail"], e["publish_date"], e["tags"], e["url"]);
      }).toList());
    },
        () => callback([
              News(
                  "Error",
                  "There may be an issue in your internet connection.",
                  "",
                  "",
                  "",
                  [],
                  "")
            ]));
  }
}
