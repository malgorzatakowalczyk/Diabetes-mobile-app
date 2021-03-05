import 'dart:async';
import 'package:flutter/material.dart';
import 'todo.dart';
import 'database_helper.dart';
import 'todo_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

class TodoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodoListState();
  }
}

class TodoListState extends State<TodoList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Todo> todoList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    if (todoList == null) {
      todoList = List<Todo>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Poziom cukru'),
        centerTitle: true,
        backgroundColor: Colors.pink[800],
      ),
      body:
      getTodoListView(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pink[600],
        onPressed: () {
          debugPrint('FAB clicked');
          navigateToDetail(Todo('', '','', 0, ''), 'Add Todo');
        },
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }

  ListView getTodoListView() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Container(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              if(position==0) ...[
                IconButton(
                  icon: Icon(Icons.calendar_today),
                  tooltip: 'Tap to open date picker',
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2015, 8),
                      lastDate: DateTime(2101),
                    );
                  },
                ),
                Text(
                  this.todoList[position].date,
                  style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                ),
              ] else ...[
                if(this.todoList[position].date.compareTo(this.todoList[position-1].date)!=0) ...[
                    Text(
                      this.todoList[position].date,
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
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
                  subtitle: Text(this.todoList[position].description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.delete,color: Colors.pink[600]),
                        onTap: () {
                         //changeToData(this.todoList[position].date);
                          _delete(context, todoList[position]);
                        },
                      ),
                    ],
                  ),
                  onTap: () {
                    debugPrint("ListTile Tapped");
                    navigateToDetail(this.todoList[position], 'Edit Todo');
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

  void changeToData(String mess)
  {
    DateTime tempDate = new DateFormat("MMM d, yyyy").parse(mess);
    /*if(temp)
    Text(
      this.todoList[position].date,
      style: TextStyle(fontWeight: FontWeight.bold),
    );*/
    print(tempDate);
  }
  void _delete(BuildContext context, Todo todo) async {
    int result = await databaseHelper.deleteTodo(todo.id);
    if (result != 0) {
      _showSnackBar(context, 'Todo Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Todo todo, String title) async {
    bool result =
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TodoDetail(todo, title);
    }));

    if (result == true) {
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Todo>> todoListFuture = databaseHelper.getTodoList();
      todoListFuture.then((todoList) {
        setState(() {
          this.todoList = todoList;
          this.count = todoList.length;
        });
      });
    });
  }


}