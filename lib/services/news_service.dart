import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:whatsapp_test_ui/models/news_model.dart';
import 'package:whatsapp_test_ui/helper.dart';
import 'package:whatsapp_test_ui/sqliteProvider/news_provider.dart';
import 'package:path/path.dart';

class NewsService {
  static Future<Map> getNews() async {
    // await _getAllNewsFromInternet();

    if (await checkConnectionInternet()) {
     await _getAllNewsFromInternet();
    } else {
      await _getAllNewsFromSqlite();
    }
    return {};
  }

  static Future<Map> _getAllNewsFromInternet() async {
    final response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/everything?q=tesla&from=2021-10-24&sortBy=publishedAt&apiKey=12a208babe3344c1b39de7e9bf4a8d89"),
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      print(responseBody);
      List<NewsModel> articles = [];
      responseBody["articles"].forEach((item) {
        articles.add(NewsModel.fromJson(item));
      });
      await _saveAllNewsInSqlite(articles);

      return {"articles": articles};
    }
    return {};
  }

  static Future<Map> _getAllNewsFromSqlite() async {
    var db = NewsProvider();
    await db.open();
    Future<List<NewsModel>> articles = db.paginate();
    await db.close();
    return {"articles": articles};
  }

  static Future<bool> _saveAllNewsInSqlite(List<NewsModel> news) async {

    var db = NewsProvider();
    await db.open();
    await db.insertAll(news);
    await db.close();
    return true;
  }
}
