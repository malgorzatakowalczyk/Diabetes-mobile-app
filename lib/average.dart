import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'record.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class Demo6 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemoState();
  }
}

class _DemoState extends State<Demo6>{
  Color color = Colors.white;
  double _value = 0.0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Record> todoList;
  int count = 0;
  DateFormat dateFormat = DateFormat("dd.MM.yyyy");
  DateTime _dateTime=null;


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.pink[800],
          title: Text('Statystyki'),
          bottom: TabBar(
            indicatorColor: Colors.lightBlueAccent,
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.collections_bookmark_sharp),
              ),
              Tab(
                icon: Icon(Icons.bar_chart),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
        Column(
        //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 15),
            Text('Ostatni dzień'),
            DataTable(
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Minimum',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Maksimum',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Srednia',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),

              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('124')),
                    DataCell(Text('13')),
                    DataCell(Text('12')),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Text('Ostatnie 7 dni'),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Minimum',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Maksimum',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Srednia',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),

              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Ravi')),
                    DataCell(Text('19')),
                    DataCell(Text('12')),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Text('Ostatni miesiąc'),
            DataTable(
              columns: const <DataColumn>[
                DataColumn(
                  label: Text(
                    'Minimum',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Maksimum',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Srednia',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),

              ],
              rows: <DataRow>[
                DataRow(
                  cells: <DataCell>[
                    DataCell(Text('Ravi')),
                    DataCell(Text('23')),
                    DataCell(Text('12')),
                  ],
                ),
              ],
            ),
            ]
        ),

            Center(
              child: Text('Wykresy'),
            ),
          ],
        ),
      ),
    );
  }
  /*int countAvg(DateTime day)
  {
    int avg=0;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Todo>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromToday(day);
    });
    avg = databaseHelper.getAverageToday();
    return avg;
  }
  int findMax(DateTime day)
  {
    int max=0;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Todo>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromToday(day);
    });
    max = databaseHelper.getMaxValue();
    return max;
  }
  int findMin(DateTime day)
  {
    int min=0;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Todo>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromToday(day);
    });
    min = databaseHelper.getMinValue();
    return min;
  }

  int countAvgLastWeek()
  {
    int average=0;
    DateTime nowTime=DateTime.now();
    DateFormat dateFormat2=DateFormat("D");
    String dayInYear=dateFormat2.format(nowTime);
    int day=int.parse(dayInYear);
    DateTime now=DateTime.now();
    for(int i=0;i<1;i++)
    {
      int avg=0;
      final Future<Database> dbToday = databaseHelper.initializeDatabase();
      dbToday.then((database) {
        print("i");
        print(i);
        Future<List<Todo>> todoListFuture;
        print("Czas");
        print(now);
        todoListFuture = databaseHelper.getTodoListFromWeek(now);
        avg = databaseHelper.getAverageWeek();
        print('average');
        average+=avg;
        print(average);
        day--;
        dayInYear=day.toString();
        now=DateFormat('D').parse(dayInYear);
      });
    }
    return average;
  }
*/
}

