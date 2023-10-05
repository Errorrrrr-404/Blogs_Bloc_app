import 'package:blog_explorer/models/article_model.dart';
import 'package:sqflite/sqflite.dart';

class Blogsdb {
  static final instance = Blogsdb._();
  final _databaseName = "Blogs.db";
  late String table = "Blogs";
  static Database? _db;
  late bool isTableCreated = false;

  Blogsdb._();

  Future<void> initialize() async {
    _db = await openDatabase(_databaseName, version: 1,
        onCreate: (db, version) async {
      await db.execute(
          'CREATE TABLE $table (id TEXT PRIMARY KEY, title TEXT, url TEXT, isFavorite INTEGER)');
    }, onOpen: (db) {
      isTableCreated = true;
    });
  }

  Future<void> storeBlogs(List<ArticleModel> models) async {
    if (isTableCreated) {
      models.forEach((model) async {
        await _db?.rawInsert(
            'INSERT INTO $table(id, title, url ,isFavorite) VALUES(?,?,?,?)', [
          model.id,
          model.title,
          model.imageUrl,
          0
        ]);
      });
    }
  }

  Future<List<ArticleModel>> retrieveBlogs() async {
    if (isTableCreated) {
      List<Map<String, Object?>>? result = await _db?.query(table);
      if (result != null) {
        return result.map((e) {
          return ArticleModel.fromJson(e);
        }).toList();
      }
      return [];
    }
    return [];
  }

  Future<void> deleteBlogs(int id) async {
    if (isTableCreated) {
      await _db?.rawDelete('DELETE FROM $table WHERE id = ?', [id]);
    }
  }

  Future<void> deleteBlogstablecontent() async {
    if (isTableCreated) {
      await _db?.rawDelete('DELETE FROM $table');
    }
  }

  Future<void> close() async {
    await _db?.close();
  }
}
