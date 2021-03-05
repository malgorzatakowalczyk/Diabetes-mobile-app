import 'dart:async';
import 'package:flutter/material.dart';
import 'todo.dart';
import 'database_helper.dart';
import 'package:intl/intl.dart';

class TodoDetail extends StatefulWidget {

  final String appBarTitle;
  final Todo todo;

  TodoDetail(this.todo, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {

    return TodoDetailState(this.todo, this.appBarTitle);
  }
}

class TodoDetailState extends State<TodoDetail> {


  DatabaseHelper helper = DatabaseHelper();

  String appBarTitle;
  Todo todo;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController levelOfSugarController = TextEditingController();

  TodoDetailState(this.todo, this.appBarTitle);

  @override
  Widget build(BuildContext context) {

    titleController.text = todo.title;
    descriptionController.text = todo.description;
    levelOfSugarController.text=todo.levelOfSugar.toString();

        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.pink[800],
            title: Text("Dodaj poziom cukru"),
            leading: IconButton(icon: Icon(
                Icons.arrow_back),
                onPressed: () {
                  moveToLastScreen();
                }
            ),
          ),

          body:
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: titleController,
                  onChanged: (value) {
                    debugPrint('Something changed in Title Text Field');
                    updateTitle();
                  },
                  decoration: InputDecoration(
                    hintText: "Podaj rodzaj posiłku",
                    icon: Icon(Icons.trending_up),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: levelOfSugarController,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    debugPrint('Something changed in Description Text Field');
                    updateLevelOfSugar();
                  },
                  decoration: InputDecoration(
                    hintText: "Podaj poziom cukru [mg/dL]",
                    labelText: 'Podaj poziom cukru [mg/dL]',
                    icon: Icon(Icons.line_weight),
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: descriptionController,
                  onChanged: (value) {
                    debugPrint('Something changed in Description Text Field');
                    updateDescription();
                  },
                  decoration: InputDecoration(
                    hintText: "Dodatkowe informacje",
                    icon: Icon(Icons.face),
                  ),
                ),
                SizedBox(height: 15),
                RaisedButton(
                  color: Colors.pink[600],
                  //color: Colors.pinkAccent,
                  child: Text(
                    "Dodaj",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed:  _save,
                  //onPressed: calculateBMI,
                ),
              ],
            ),
          ),

        );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  // Update the title of todo object
  void updateTitle(){
    todo.title = titleController.text;
  }

  // Update the description of todo object
  void updateDescription() {
    todo.description = descriptionController.text;
  }
  void updateLevelOfSugar()
  {
    todo.levelOfSugar=int.parse(levelOfSugarController.text);
  }
  // Save data to database
  void _save() async {

    moveToLastScreen();
    DateTime now = new DateTime.now();
    DateTime nowHours = new DateTime(now.hour,now.minute);

    todo.date = DateFormat.yMMMd().format(now);
    todo.hour= DateFormat.jm().format(now);

    int result;
    if (todo.id != null) {  // Case 1: Update operation
      result = await helper.updateTodo(todo);
    } else { // Case 2: Insert Operation
      result = await helper.insertTodo(todo);
    }

    if (result != 0) {  // Success
      _showAlertDialog('Status', 'Poziom cukru zapisany');
    } else {  // Failure
      _showAlertDialog('Status', 'Problem z zapisem. Spróbuj dodać wynik jeszcze raz');
    }

  }


  void _delete() async {

    moveToLastScreen();
    if (todo.id == null) {
      _showAlertDialog('Status', 'Żadny wynik nie został usunięty');
      return;
    }

    int result = await helper.deleteTodo(todo.id);
    if (result != 0) {
      _showAlertDialog('Status', 'Wynik został usunięty');
    } else {
      _showAlertDialog('Status', 'Pojawił się błąd podczas usuwania rekordu');
    }
  }

  void _showAlertDialog(String title, String message) {

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }

}



