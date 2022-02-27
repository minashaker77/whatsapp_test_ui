import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:whatsapp_test_ui/models/news_model.dart';
import 'package:whatsapp_test_ui/sqliteProvider/db_provider.dart';

class NewsProvider extends Provider {
  final String _tableName = 'articles';

  Future<NewsModel> insert(NewsModel newsModel,
      {conflictAlgorithm = ConflictAlgorithm.replace}) async {
    await db.insert(_tableName, newsModel.toMap(),
        conflictAlgorithm: conflictAlgorithm);

    return newsModel;
  }

  Future<bool> insertAll(List<NewsModel> news) async {
    await Future.wait(news.map((e) async {
      await this.insert(e);
    }));
    return true;
  }

  Future<List<NewsModel>> paginate() async {
    List<Map> map = await db.query(
      _tableName,
      columns: [
        'author',
        'title',
        'description',
        'url',
        'urlToImage',
        'publishedAt',
        'content'
      ],
    );
    if (map.length > 0) {
      List<NewsModel> articles = [];
      map.forEach((article) {
        if (article != null) {
          articles.add(NewsModel.fromJson(article));
        }
      });
      return articles;
    }
    return [];
  }
}
