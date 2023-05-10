import 'package:film_update_mobile_apps/models/favorite_movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static final LocalDatabaseService instance = LocalDatabaseService._internal();
  LocalDatabaseService._internal();
  factory LocalDatabaseService() => instance;

  static Database? _database;
  final String _tableName = "favorite";

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDB('movie.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE $_tableName (
          id INTEGER PRIMARY KEY,
          id_movie INTEGER,
          title_movie TEXT,
          poster_path_movie TEXT,
          date_movie TEXT
        )''');
  }

  Future<void> insertFavorite(FavoriteMovieModel favModel) async {
    final db = await instance.database;
    await db.insert(_tableName, favModel.toMap());
  }

  Future<List<FavoriteMovieModel>> getFavorite() async {
    final db = await instance.database;
    final result = await db.query(_tableName);
    return result.map((map) => FavoriteMovieModel.fromMap(map)).toList();
  }

  Future<void> deleteFavorite(int idMovie) async {
    final db = await instance.database;
    await db.delete(
      _tableName,
      where: 'id_movie = ?',
      whereArgs: [idMovie],
    );
  }
}
