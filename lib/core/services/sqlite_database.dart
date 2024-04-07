import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqliteService {
  final String dbName = 'autoberes.db';
  final String table = 'list.db';
  final int dbVersion = 1;

  Future<Database> initDb() async {
    final String databasePath = await getDatabasesPath();
    final String path = join(
      databasePath,
      dbName,
    );

    final Future<Database> database = openDatabase(
      path,
      version: dbVersion,
      onCreate: (Database db, int version) async {
        await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        brand TEXT NOT NULL,
        brand_image TEXT NOT NULL
        is_selected BOOLEAN NOT NULL DEFAULT 0
      )
      ''');
      },
    );
    return database;
  }
}
