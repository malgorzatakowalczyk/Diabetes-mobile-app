import 'dart:async';
import 'package:flutter/material.dart';
import 'record.dart';
import 'database_helper.dart';
import 'addSugarLevel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class ListOfSugarLevels extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ListOfSugarLevelsState();
  }
}

class ListOfSugarLevelsState extends State<ListOfSugarLevels> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Record> todoList;
  int numberOfRecords = 0;
  DateFormat dateFormat = DateFormat("dd.MM.yyyy");
  DateTime _dateTime = null;
  Color darkPink = Colors.pink[800];
  Color pink = Colors.pink[600];

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Record>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Poziom cukru'),
        centerTitle: true,
        backgroundColor: darkPink,
      ),
      body: getTodoListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: pink,
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Record('', '', '', 0, ''), 'Add Todo');
        },
        tooltip: 'Dodaj poziom cukru',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: numberOfRecords,
      itemBuilder: (BuildContext context, int position) {
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (position == 0) ...[
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  tooltip: 'Kliknij aby wybrać datę',
                  onPressed: () {
                    showDatePicker(
                            context: context,
                            initialDate:
                                _dateTime == null ? DateTime.now() : _dateTime,
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2050))
                        .then((date) {
                      setState(() {
                        updateListView();
                        _dateTime = date;
                        print(_dateTime);
                      });
                    });
                  },
                ),
                if (dateFormat
                        .format(DateTime.now())
                        .compareTo(this.todoList[position].date) !=
                    0) ...[
                  Text(
                    this.todoList[position].date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ] else ...[
                  Text(
                    "DZISIAJ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ]
              ] else ...[
                if (this
                        .todoList[position]
                        .date
                        .compareTo(this.todoList[position - 1].date) !=
                    0) ...[
                  Text(
                    this.todoList[position].date,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ]
              ],
              Text(
                this.todoList[position].hour,
              ),
              Card(
                color: Colors.white,
                elevation: 2.0,
                child: ListTile(
                  title: Text(this.todoList[position].title,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(
                      this.todoList[position].levelOfSugar.toString() +
                          " mg/dL"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.delete, color: Colors.pink[600]),
                        onTap: () {
                          _delete(context, todoList[position]);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    navigateToDetail(this.todoList[position], 'Edytowano');
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  getFirstLetter(String title) {
    return title.substring(0, 2);
  }

  void _delete(BuildContext context, Record todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Rekord usunięty');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Record todo, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddSugarLevel(todo, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Record>> todoListFuture;
      if (_dateTime == null) {
        todoListFuture = databaseHelper.getTodoList();
      } else {
        String mess = dateFormat.format(_dateTime);
        todoListFuture = databaseHelper.getTodoListDate(mess);
      }
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.numberOfRecords = todoList.length;
        });
      });
    });
  }
}
