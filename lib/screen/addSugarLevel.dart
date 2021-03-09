import 'dart:async';
import 'package:flutter/material.dart';
import '../database/record.dart';
import '../database/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:numberpicker/numberpicker.dart';

class AddSugarLevel extends StatefulWidget {
  final String appBarTitle;
  final Record record;


  AddSugarLevel(this.record, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return AddSugarLevelState(this.record, this.appBarTitle);
  }
}

class AddSugarLevelState extends State<AddSugarLevel> {
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Record todo;
  Color darkPink=Colors.pink[800];
  Color pink=Colors.pink[600];

  TextEditingController descriptionController = TextEditingController();

  AddSugarLevelState(this.todo, this.appBarTitle);

  String _dropDownValue;

  int _currentIntValue = 0, _currentIntValue2 = 0, _currentIntValue3 = 0;
  NumberPicker integerNumberPicker;

  _handleValueChanged(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
        updateLevelOfSugar(
            _currentIntValue, _currentIntValue2, _currentIntValue3);
      }
    }
  }

  _handleValueChanged2(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue2 = value);
        updateLevelOfSugar(
            _currentIntValue, _currentIntValue2, _currentIntValue3);
      }
    }
  }

  _handleValueChanged3(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue3 = value);
        updateLevelOfSugar(
            _currentIntValue, _currentIntValue2, _currentIntValue3);
      }
    }
  }

  _handleValueChangedExternally(num value) {
    if (value != null) {
      if (value is int) {
        setState(() => _currentIntValue = value);
        integerNumberPicker.animateInt(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    descriptionController.text = todo.description;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkPink,
        title: Text("Dodaj poziom cukru"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              moveToLastScreen();
            }),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              NumberPicker.integer(
                initialValue: _currentIntValue,
                minValue: 0,
                maxValue: 9,
                step: 1,
                onChanged: _handleValueChanged,
              ),
              NumberPicker.integer(
                initialValue: _currentIntValue2,
                minValue: 0,
                maxValue: 9,
                step: 1,
                onChanged: _handleValueChanged2,
              ),
              NumberPicker.integer(
                initialValue: _currentIntValue3,
                minValue: 0,
                maxValue: 9,
                step: 1,
                onChanged: _handleValueChanged3,
              ),
            ]),
            SizedBox(height: 30),
            DropdownButton(
              hint: _dropDownValue == null
                  ? Text('Wybierz porę')
                  : Text(
                      _dropDownValue,
                    ),

              isExpanded: true,
              iconSize: 30.0,
              items: ['Przed posiłkiem', 'Po posiłku'].map(
                (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                  () {
                    _dropDownValue = val;
                    updateTitle(_dropDownValue);
                    print(_dropDownValue);
                  },
                );
              },
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
                icon: Icon(Icons.perm_device_info),
              ),
            ),
            SizedBox(height: 30),
            RaisedButton(
              color: pink,
              //color: Colors.pinkAccent,
              child: Text(
                "Dodaj",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: _save,
            ),
          ],
        ),
      ),
    );
  }

  void moveToLastScreen() {
    Navigator.pop(context, true);
  }

  void updateTitle(String meal) {
    todo.title = meal;
  }

  void updateDescription() {
    todo.description = descriptionController.text;
  }

  void updateLevelOfSugar(int num1, int num2, int num3) {
    int res = num1 * 100 + num2 * 10 + num3;
    todo.levelOfSugar = res;
  }

  void _save() async {
    moveToLastScreen();
    DateTime now = new DateTime.now();
    DateTime nowHours = new DateTime(now.hour, now.minute);

    DateFormat dateFormat = DateFormat("dd.MM.yyyy");

    todo.date = dateFormat.format(now);
    todo.hour = DateFormat.Hm().format(now);

    int result;
    if (todo.id != null) {
      result = await helper.updateTodo(todo);
    } else {
      result = await helper.insertTodo(todo);
    }

    if (result != 0) {
      _showAlertDialog('Status', 'Poziom cukru zapisany');
    } else {
      _showAlertDialog(
          'Status', 'Problem z zapisem. Spróbuj dodać wynik jeszcze raz');
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
    showDialog(context: context, builder: (_) => alertDialog);
  }

  Future _showIntegerDialog() async {
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return new NumberPickerDialog.integer(
          minValue: 0,
          maxValue: 9,
          step: 1,
          initialIntegerValue: _currentIntValue,
        );
      },
    ).then(_handleValueChangedExternally);
  }
}
