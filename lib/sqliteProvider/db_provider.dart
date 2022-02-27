import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Provider {
  late Database db;
  late String _path;


  Future open({String dbName = 'article.db'}) async {
    var databasesPath = await getDatabasesPath();
     _path = join(databasesPath, dbName);

    db = await openDatabase(_path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
               create table articles ( 
                  author text not null,
                  title text not null,
                  description text not null,
                  url text not null,
                  urlToImage text not null,
                  content text not null,
                  publishedAt text not null)
                ''');
        });
  }
  Future close() async => await db.close();
}
