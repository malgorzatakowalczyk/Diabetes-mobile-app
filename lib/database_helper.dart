import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'record.dart';
import 'package:intl/intl.dart';


class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String todoTable = 'todo_table3';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colHour='hour';
  String colLevelOfSugar='levelOfSugar';

  int avgToday=0;
  int maxToday=0;
  int minToday=0;
  int avgWeek=0;
  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
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
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'todos3.db';

    // Open/create the database at a given path
    var todosDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return todosDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $todoTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colDate TEXT, $colHour TEXT, $colLevelOfSugar INTEGER)');
  }

  // Fetch Operation: Get all todo objects from database
  Future<List<Map<String, dynamic>>> getTodoMapList() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $todoTable order by $colTitle ASC');
    var result = await db.query(todoTable, orderBy: '$colId DESC');
    return result;
  }

  // Insert Operation: Insert a todo object to database
  Future<int> insertTodo(Record todo) async {
    Database db = await this.database;
    var result = await db.insert(todoTable, todo.toMap());
    return result;
  }

  // Update Operation: Update a todo object and save it to database
  Future<int> updateTodo(Record todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
    return result;
  }

  Future<int> updateTodoCompleted(Record todo) async {
    var db = await this.database;
    var result = await db.update(todoTable, todo.toMap(), where: '$colId = ?', whereArgs: [todo.id]);
    return result;
  }

  // Delete Operation: Delete a todo object from database
  Future<int> deleteTodo(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $todoTable WHERE $colId = $id');
    return result;
  }

  // Get number of todo objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $todoTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }


  // Get the 'Map List' [ List<Map> ] and convert it to 'todo List' [ List<Todo> ]
  Future<List<Record>> getTodoList() async {

    var todoMapList = await getTodoMapList(); // Get 'Map List' from database
    int count = todoMapList.length;         // Count the number of map entries in db table

    List<Record> todoList = List<Record>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(Record.fromMapObject(todoMapList[i]));
    }

    return todoList;
  }


///Get list depends date
  ///
  ///
  ///
  ///
  Future<List<Map<String, dynamic>>> getTodoMapListDate(String mess) async {
    Database db = await this.database;
    var result = await db.rawQuery('SELECT * FROM $todoTable where $colDate like \'$mess\' order by $colTitle ASC');
    return result;
  }

  Future<List<Record>> getTodoListDate(String mess) async {

    var todoMapList = await getTodoMapListDate(mess); // Get 'Map List' from database
    int count = todoMapList.length;         // Count the number of map entries in db table

    List<Record> todoList = List<Record>();
    // For loop to create a 'todo List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      todoList.add(Record.fromMapObject(todoMapList[i]));
    }

    return todoList;
  }

  //lista z 1 dnia
  Future<List<Map<String, dynamic>>> getTodoMapListFromToday(DateTime day) async {
    Database db = await this.database;
    DateFormat dateFormat = DateFormat("dd.MM.yyyy");
   // DateTime now=DateTime.now();
    String mess=dateFormat.format(day);
    var result = await db.rawQuery('SELECT * FROM $todoTable where $colDate like \'$mess\'');
    return result;
  }
  Future<List<Record>> getTodoListFromToday(DateTime day) async {

    double avgTodaySum=0;
    maxToday=0;
    minToday=0;
    var todoMapList = await getTodoMapListFromToday(day); // Get 'Map List' from database
    int count = todoMapList.length;         // Count the number of map entries in db table
    List<Record> todoList = List<Record>();
    if(count!=0) {
      maxToday = Record.fromMapObject(todoMapList[0]).levelOfSugar;
      minToday= Record.fromMapObject(todoMapList[0]).levelOfSugar;
    }
    for (int i = 0; i < count; i++) {
      if(Record.fromMapObject(todoMapList[i]).levelOfSugar>maxToday)
        maxToday=Record.fromMapObject(todoMapList[i]).levelOfSugar;
      if(Record.fromMapObject(todoMapList[i]).levelOfSugar<minToday)
        minToday=Record.fromMapObject(todoMapList[i]).levelOfSugar;
      todoList.add(Record.fromMapObject(todoMapList[i]));
      avgTodaySum+=Record.fromMapObject(todoMapList[i]).levelOfSugar;
    }
    if(avgTodaySum!=0) avgTodaySum=avgTodaySum/count;
    avgToday=avgTodaySum.toInt();
    return todoList;
  }


  Future<List<Record>> getTodoListFromWeek(DateTime day) async {

    double avgTodaySum=0;
    maxToday=0;
    minToday=0;
    var todoMapList = await getTodoMapListFromToday(day); // Get 'Map List' from database
    int count = todoMapList.length;         // Count the number of map entries in db table
    List<Record> todoList = List<Record>();
    if(count!=0) {
      maxToday = Record.fromMapObject(todoMapList[0]).levelOfSugar;
      minToday= Record.fromMapObject(todoMapList[0]).levelOfSugar;
    }
    for (int i = 0; i < count; i++) {
      if(Record.fromMapObject(todoMapList[i]).levelOfSugar>maxToday)
        maxToday=Record.fromMapObject(todoMapList[i]).levelOfSugar;
      if(Record.fromMapObject(todoMapList[i]).levelOfSugar<minToday)
        minToday=Record.fromMapObject(todoMapList[i]).levelOfSugar;
      todoList.add(Record.fromMapObject(todoMapList[i]));
      avgTodaySum+=Record.fromMapObject(todoMapList[i]).levelOfSugar;
    }
    if(avgTodaySum!=0) avgTodaySum=avgTodaySum/count;
    avgWeek=avgTodaySum.toInt();
    return todoList;
  }
  int getAverageWeek()
  {
    return avgWeek;
  }
  int getAverageToday()
  {
    return avgToday;
  }
  int getMaxValue()
  {
    return maxToday;
  }
  int getMinValue()
  {
    return minToday;
  }
}





