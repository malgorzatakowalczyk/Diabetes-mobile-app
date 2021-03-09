import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../database/record.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

class Demo6 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _DemoState();
  }
}

class _DemoState extends State<Demo6> {
  Color color = Colors.white;
  double _value = 0.0;
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Record> todoList;
  int count = 0;
  DateFormat dateFormat = DateFormat("dd.MM.yyyy");
  DateTime _dateTime = null;
  DateTime now=DateTime.now();

  var cutOffYValue = 0.0;
  var axisStyle =
      TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold);
  int numberOfRecords = 0;

  final List<FlSpot> dummyData1 = List.generate(1, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Record>();
      updateListView();
    }
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                          DataCell(Text(findMin(now).toString())),
                          DataCell(Text(findMax(now).toString())),
                          DataCell(Text(countAvg(now).toString())),
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
                          //DataCell(Text(findMinWeek(now).toString())),
                          DataCell(Text(findMinWeek(now).toString())),
                          DataCell(Text(findMaxWeek(now).toString())),
                          DataCell(Text(countAvgWeek(now).toString())),
                        //  DataCell(Text(countAvgLastWeek().toString())),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Text('Ostatnie 2 tygodnie'),
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
                          DataCell(Text(findMinFortnight(now).toString())),
                          DataCell(Text(findMaxFortnight(now).toString())),
                          DataCell(Text(countAvgFortnight(now).toString())),
                        ],
                      ),
                    ],
                  ),
                ]),
            Column(mainAxisAlignment: MainAxisAlignment.center, children: <
                Widget>[
              // SizedBox(height: 15),
              Text('Wahania poziomu cukru w ciagu dnia'),
              SizedBox(height: 15),
              if (numberOfRecords < 2) ...[
                Text("Za mało danych"),
              ] else if (numberOfRecords >= 2) ...[
                LineChart(
                  LineChartData(
                    borderData: FlBorderData(show: false),
                    lineBarsData: [
                      LineChartBarData(
                        spots: List.generate(numberOfRecords, (index) {
                         // print(this.todoList[index].levelOfSugar.toDouble());
                          return FlSpot(index.toDouble(),
                              this.todoList[index].levelOfSugar.toDouble());
                        }),
                        isCurved: true,
                        barWidth: 3,
                        colors: [
                          Colors.pink[600],
                        ],
                      ),
                    ],
                    minY: 0,
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 6,
                          getTitles: (value) {
                            return this.todoList[value.toInt()].hour.toString();
                          }),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTitles: (value) {
                          if (value == 50 ||
                              value == 100 ||
                              value == 150 ||
                              value == 200) return value.toString();
                        },
                      ),
                    ),
                    axisTitleData: FlAxisTitleData(
                        leftTitle: AxisTitle(
                            showTitle: true,
                            titleText: 'Poziom cukru mg/dL',
                            margin: 10,
                            textStyle: axisStyle),
                        bottomTitle: AxisTitle(
                          showTitle: true,
                          margin: 10,
                          titleText: 'Godzina',
                          textStyle: axisStyle,
                        )),
                  ),
                ),
              ]
            ]),

            //Text("Ala ma kota"),
          ],
        ),
      ),
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Record>> todoListFuture;
      _dateTime = DateTime.now();
      String mess = dateFormat.format(_dateTime);
      todoListFuture = databaseHelper.getTodoListDate(mess);

      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.numberOfRecords = todoList.length;
        });
      });
    });
  }

int countAvg(DateTime day)
  {
    int avg=0;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Record>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromToday(day);
    });
    avg = databaseHelper.getAverageToday();
    setState(() {
    });
    return avg;
  }
  int findMax(DateTime day)
  {
    int max;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Record>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromToday(day);
    });
    max = databaseHelper.getMaxValue();
    setState(() {
    });
    return max;
  }
  int findMin(DateTime day)
  {
    int min;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Record>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromToday(day);
    });
    min = databaseHelper.getMinValue();
    setState(() {
    });
    return min;
  }
  //Dla tygodnia
  int countAvgWeek(DateTime day)
  {
    int avg=0;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Record>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromWeek(day);
    });
    avg = databaseHelper.getAverageWeek();
    setState(() {
    });
    return avg;
  }
  int findMaxWeek(DateTime day)
  {
    int max;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Record>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromWeek(day);
    });
    max = databaseHelper.getMaxWeek();
    setState(() {
    });
    return max;
  }
  int findMinWeek(DateTime day)
  {
    int min;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Record>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromWeek(day);
    });
    min = databaseHelper.getMinWeek();
    setState(() {
    });
    return min;
  }



//Dla 2 tygodni

  int countAvgFortnight(DateTime day)
  {
    int avg=0;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Record>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromFortnight(day);
    });
    avg = databaseHelper.getAverageWeek();
    setState(() {
    });
    return avg;
  }
  int findMaxFortnight(DateTime day)
  {
    int max;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Record>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromFortnight(day);
    });
    max = databaseHelper.getMaxWeek();
    setState(() {
    });
    return max;
  }
  int findMinFortnight(DateTime day)
  {
    int min;
    final Future<Database> dbToday = databaseHelper.initializeDatabase();
    dbToday.then((database) {
      Future<List<Record>> todoListFuture;
      todoListFuture = databaseHelper.getTodoListFromFortnight(day);
    });
    min = databaseHelper.getMinWeek();
    setState(() {
    });
    return min;
  }











  //WEEK
 /* int findMinWeek(DateTime day)
  {
    int min=0;
    int minimum;
    DateTime nowTime=DateTime.now();

    DateFormat dateFormat2=DateFormat("dd");
    DateFormat dateFormat3=DateFormat("MM");
    DateFormat dateFormat4=DateFormat("yyyy");
    String dayInYear=dateFormat2.format(nowTime);
    int day=int.parse(dayInYear);
    String monthInYear=dateFormat3.format(nowTime);
    String year=dateFormat4.format(nowTime);

    for(int i=0;i<7;i++)
    {
      final Future<Database> dbWeek = databaseHelper.initializeDatabase();
      dbWeek.then((database) {
        Future<List<Record>> todoListFuture;
        todoListFuture = databaseHelper.getTodoListFromWeek(now);
        min= databaseHelper.getMinWeek();
        print('min');
        print(min);
        if(i==0)
          {
            //print('Pierwszy element');
            minimum=min;
          }
        else
          {
            if(min<minimum) minimum=min;
          }
        day--;
        dayInYear=day.toString();
        String allDate=dayInYear+'.'+monthInYear+'.'+year;
        /*print("minimum");
        print(minimum);*/
        now=DateFormat("dd.MM.yyyy").parse(allDate);
        //print(now);
      });
    }
    setState(() {

    });
    return minimum;

  }
*/


  /*int countAvgLastWeek()
  {
    int average=0;
    DateTime nowTime=DateTime.now();

    DateFormat dateFormat2=DateFormat("dd");
    DateFormat dateFormat3=DateFormat("MM");
    DateFormat dateFormat4=DateFormat("yyyy");
    String dayInYear=dateFormat2.format(nowTime);
    int day=int.parse(dayInYear);
    String monthInYear=dateFormat3.format(nowTime);
    String year=dateFormat4.format(nowTime);

    for(int i=0;i<7;i++)
    {
      int avg=0;
      final Future<Database> dbWeek = databaseHelper.initializeDatabase();
      dbWeek.then((database) {
        print("i");
        print(i);
        Future<List<Record>> todoListFuture;
        print("Czas");
        print(now);
        todoListFuture = databaseHelper.getTodoListFromWeek(now);
        avg = databaseHelper.getAverageWeek();
        print('average');
        average+=avg;
        print(average);
        day--;
        dayInYear=day.toString();
        String allDate=dayInYear+'.'+monthInYear+'.'+year;

        now=DateFormat("dd.MM.yyyy").parse(allDate);
        print(now);
      });
    }
    setState(() {
    });
    print("return");
    return average;
  }
*/
}
