import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'record.dart';
import 'package:intl/intl.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String todoTable = 'informationAboutSugarLevel';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colHour = 'hour';
  String colLevelOfSugar = 'levelOfSugar';

  int avgToday = 0;
  int maxToday = 0;
  int minToday = 0;
  int avgWeek = 0;
  int minWeek = 0;
  int maxWeek = 0;
  int minFortnight = 0;
  int maxFortnight = 0;
  int avgFortnight = 0;

  DatabaseHelper._createInstance();
  DateFormat dateFormat = DateFormat("dd.MM.yyyy");

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todos3.db';
    var todosDatabase =
        await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colDate TEXT, $colHour TEXT, $colLevelOfSugar INTEGER)');
  }

  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;
    var result = await db.query(todoTable, orderBy: '$colId DESC');
    return result;
  }

  Future<int> insertTodo(Record todo) async {
    Database db = await this.database;
    var result = await db.insert(todoTable, todo.toMap());
    return result;
  }

  Future<int> updateTodo(Record todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(),
        where: '$colId = ?', whereArgs: [todo.id]);
    return result;
  }

  Future<int> updateTodoCompleted(Record todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(),
        where: '$colId = ?', whereArgs: [todo.id]);
    return result;
  }

  Future<int> deleteTodo(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Record>> getTodoList() async {
    var todoMapList = await getTodoMapList();
    int count = todoMapList.length;

    List<Record> todoList = List<Record>();
    for (int i = 0; i < count; i++) {
      todoList.add(Record.fromMapObject(todoMapList[i]));
    }

    return todoList;
  }

  Future<List<Map<String, dynamic>>> getTodoMapListDate(String mess) async {
    Database db = await this.database;
    var result = await db.rawQuery(
        'SELECT * FROM $todoTable where $colDate like \'$mess\' order by $colHour');
    return result;
  }

  Future<List<Record>> getTodoListDate(String mess) async {
    var todoMapList = await getTodoMapListDate(mess);
    int count = todoMapList.length;

    List<Record> todoList = List<Record>();
    for (int i = 0; i < count; i++) {
      todoList.add(Record.fromMapObject(todoMapList[i]));
    }

    return todoList;
  }

  Future<List<Map<String, dynamic>>> getTodoMapListFromToday(
      DateTime day) async {
    Database db = await this.database;
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    String mess = dateFormat.format(day);
    var result = await db.rawQuery(
        'SELECT * FROM $todoTable where $colDate like \'$mess\' order by $colHour DESC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getTodoMapListFromWeek(
      DateTime now) async {
    Database db = await this.database;

    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    DateFormat dateFormat2 = DateFormat("dd");
    DateFormat dateFormat3 = DateFormat("MM");
    DateFormat dateFormat4 = DateFormat("yyyy");
    String dayInYear = dateFormat2.format(now);
    int day = int.parse(dayInYear);
    String monthInYear = dateFormat3.format(now);
    String year = dateFormat4.format(now);
    String ms, ms2, ms3, ms4, ms5, ms6, ms7;
    for (int i = 0; i < 7; i++) {
      String mess = dateFormat.format(now);
      if(i==0) ms = mess;
      else if(i==1) ms2 = mess;
      else if(i==2) ms3 = mess;
      else if(i==3) ms4 = mess;
      else if(i==4) ms5 = mess;
      else if(i==5) ms6 = mess;
      else if(i==6) ms7 = mess;
      day--;
      dayInYear = day.toString();
      String wholeDate = dayInYear + '.' + monthInYear + '.' + year;
      now = DateFormat("dd.MM.yyyy").parse(wholeDate);
    }

    var result = await db.rawQuery('SELECT * FROM $todoTable where $colDate in (\'$ms\', \'$ms2\', \'$ms3\', \'$ms4\', \'$ms5\', \'$ms6\', \'$ms7\')');
    return result;
  }

  Future<List<Map<String, dynamic>>> getTodoMapListFromFortnight(
      DateTime now) async {
    Database db = await this.database;

    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
    DateFormat dateFormat2 = DateFormat("dd");
    DateFormat dateFormat3 = DateFormat("MM");
    DateFormat dateFormat4 = DateFormat("yyyy");
    String dayInYear = dateFormat2.format(now);
    int day = int.parse(dayInYear);
    String monthInYear = dateFormat3.format(now);
    String year = dateFormat4.format(now);
    String ms, ms2, ms3, ms4, ms5, ms6, ms7, ms8, ms9, ms10, ms11, ms12, ms13, ms14;

    for (int i = 0; i < 14; i++) {
      String mess = dateFormat.format(now);
      if(i==0) ms = mess;
      else if(i==1) ms2 = mess;
      else if(i==2) ms3 = mess;
      else if(i==3) ms4 = mess;
      else if(i==4) ms5 = mess;
      else if(i==5) ms6 = mess;
      else if(i==6) ms7 = mess;
      else if(i==7) ms8=mess;
      else if(i==8) ms9 = mess;
      else if(i==9) ms10 = mess;
      else if(i==10) ms11 = mess;
      else if(i==11) ms12 = mess;
      else if(i==12) ms13 = mess;
      else if(i==13) ms14 = mess;
      day--;
      dayInYear = day.toString();
      String wholeDate = dayInYear + '.' + monthInYear + '.' + year;
      now = DateFormat("dd.MM.yyyy").parse(wholeDate);
    }
    var result = await db.rawQuery('SELECT * FROM $todoTable where $colDate in (\'$ms\', \'$ms2\', \'$ms3\', \'$ms4\', \'$ms5\', \'$ms6\', \'$ms7\', \'$ms8\', \'$ms9\', \'$ms10\', \'$ms11\', \'$ms12\', \'$ms13\', \'$ms14\')');

    return result;
  }

  Future<List<Record>> getTodoListFromToday(DateTime day) async {
    double avgTodaySum = 0;
    var todoMapList = await getTodoMapListFromToday(day);
    int count = todoMapList.length;

    List<Record> todoList = List<Record>();
    if (count != 0) {
      maxToday = Record.fromMapObject(todoMapList[0]).levelOfSugar;
      minToday = Record.fromMapObject(todoMapList[0]).levelOfSugar;
    }
    for (int i = 0; i < count; i++) {
      if (Record.fromMapObject(todoMapList[i]).levelOfSugar > maxToday)
        maxToday = Record.fromMapObject(todoMapList[i]).levelOfSugar;
      if (Record.fromMapObject(todoMapList[i]).levelOfSugar < minToday)
        minToday = Record.fromMapObject(todoMapList[i]).levelOfSugar;
      todoList.add(Record.fromMapObject(todoMapList[i]));
      avgTodaySum += Record.fromMapObject(todoMapList[i]).levelOfSugar;
    }
    if (avgTodaySum != 0) avgTodaySum = avgTodaySum / count;
    avgToday = avgTodaySum.toInt();
    return todoList;
  }

  Future<List<Record>> getTodoListFromWeek(DateTime day) async {
    double avgTodaySum = 0;
    var todoMapList = await getTodoMapListFromWeek(day);
    int count = todoMapList.length;

    List<Record> listWeek = List<Record>();
    if (count != 0) {
      maxWeek = Record.fromMapObject(todoMapList[0]).levelOfSugar;
      minWeek = Record.fromMapObject(todoMapList[0]).levelOfSugar;
    }
    for (int i = 0; i < count; i++) {
      if (Record.fromMapObject(todoMapList[i]).levelOfSugar > maxWeek)
        maxWeek = Record.fromMapObject(todoMapList[i]).levelOfSugar;
      if (Record.fromMapObject(todoMapList[i]).levelOfSugar < minWeek)
        minWeek = Record.fromMapObject(todoMapList[i]).levelOfSugar;
      listWeek.add(Record.fromMapObject(todoMapList[i]));
      avgTodaySum += Record.fromMapObject(todoMapList[i]).levelOfSugar;
    }
    if (avgTodaySum != 0) avgTodaySum = avgTodaySum / count;
    avgWeek = avgTodaySum.toInt();
    return listWeek;
  }

  Future<List<Record>> getTodoListFromFortnight(DateTime day) async {
    double avgFortnightSum = 0;
    var todoMapList = await getTodoMapListFromWeek(day);
    int count = todoMapList.length;

    List<Record> listFortnight = List<Record>();
    if (count != 0) {
      maxFortnight = Record.fromMapObject(todoMapList[0]).levelOfSugar;
      minFortnight = Record.fromMapObject(todoMapList[0]).levelOfSugar;
    }
    for (int i = 0; i < count; i++) {
      if (Record.fromMapObject(todoMapList[i]).levelOfSugar > maxFortnight)
        maxFortnight = Record.fromMapObject(todoMapList[i]).levelOfSugar;
      if (Record.fromMapObject(todoMapList[i]).levelOfSugar < minFortnight)
        minFortnight = Record.fromMapObject(todoMapList[i]).levelOfSugar;
      listFortnight.add(Record.fromMapObject(todoMapList[i]));
      avgFortnightSum += Record.fromMapObject(todoMapList[i]).levelOfSugar;
    }
    if (avgFortnightSum != 0) avgFortnightSum = avgFortnightSum / count;
    avgFortnight = avgFortnightSum.toInt();
    return listFortnight;
  }

  int getMinFortnight() {
    return minFortnight;
  }

  int getMaxFortnight() {
    return maxFortnight;
  }

  int getAvgFortnight() {
    return avgFortnight;
  }

  int getMinWeek() {
    return minWeek;
  }

  int getMaxWeek() {
    return maxWeek;
  }

  int getAverageWeek() {
    return avgWeek;
  }

  int getAverageToday() {
    return avgToday;
  }

  int getMaxValue() {
    return maxToday;
  }

  int getMinValue() {
    return minToday;
  }
}
