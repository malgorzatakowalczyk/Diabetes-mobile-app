import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String tableInDatabase = 'informationAboutSugarLevel';
final String columnId = 'id';
final String columnMeal = 'typeOfMeal';
final String columnSugarLevel = 'sugarLevel';
final String columnDate = 'date';

class LineInDatabase {
  int id;
  String typeOfMeal;
  int sugarLevel;
  String date;

  LineInDatabase();

  LineInDatabase.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    typeOfMeal = map[columnMeal];
    sugarLevel = map[columnSugarLevel];
    date = map[columnDate];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnMeal: typeOfMeal,
      columnSugarLevel: sugarLevel,
      columnDate: date
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}

class DatabaseHelper {
  static final _databaseName = "DatabaseDiabetesApp.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
              CREATE TABLE $tableInDatabase (
                $columnId INTEGER PRIMARY KEY,
                $columnMeal TEXT NOT NULL,
                $columnSugarLevel INTEGER NOT NULL,
                $columnDate TEXT NOT NULL
              )
              ''');
  }

  Future<int> insert(LineInDatabase word) async {
    Database db = await database;
    int id = await db.insert(tableInDatabase, word.toMap());
    return id;
  }

  Future<LineInDatabase> queryWord(int id) async {
    Database db = await database;
    List<Map> maps = await db.query(tableInDatabase,
        columns: [columnId, columnMeal, columnSugarLevel, columnDate],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) return LineInDatabase.fromMap(maps.first);
    return null;
  }
}
