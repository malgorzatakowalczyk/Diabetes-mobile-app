import 'package:flutter/material.dart';
import 'bmiCalculator.dart';
import 'homairCalculator.dart';
import 'sugarUnitConverter.dart';
import 'todo_list.dart';
import 'todo_details.dart';
import 'statistic.dart';


import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: FirstRoute(),
  ));
}

class FirstRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetycy'),
        centerTitle: true,
        backgroundColor: Colors.pink[800],
        //backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
      decoration: new BoxDecoration(
    image: new DecorationImage(
    image: new AssetImage('assets/11.png'),
    fit: BoxFit.cover,
    ),
      ),
        alignment: Alignment.center,
       //padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          //  SizedBox(height: 25),
        RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.pink[600])),
         // side: BorderSide(color: Colors.pinkAccent)),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => TodoList()),
        );
      },
      padding: EdgeInsets.all(20.0),
          //color: Colors.pinkAccent,
        color: Colors.pink[600],
      textColor: Colors.white,
      child: Text("Dodaj poziom cukru ",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20)),
    ),
            SizedBox(height: 25),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color:  Colors.pink[600])),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Demo()),
                );
              },
              padding: EdgeInsets.all(20.0),
              color: Colors.pink[600],
             // color: Colors.pinkAccent,
              textColor: Colors.white,
              child: Text("Kalkulator BMI          ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 25),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color:  Colors.pink[600])),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Demo2()),
                );
              },
              padding: EdgeInsets.all(20.0),
              //color: Colors.pinkAccent,
              color: Colors.pink[600],
              textColor: Colors.white,
              child: Text("HOMA-IR                    ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 25),

            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color:  Colors.pink[600])),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Demo3()),
                );
              },
              padding: EdgeInsets.all(20.0),
              //color: Colors.pinkAccent,
              color: Colors.pink[600],
              textColor: Colors.white,
              child: Text("Przelicznik jednostek",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 25),

            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  side: BorderSide(color: Colors.pink[600])),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LineChartSample2()),
                );
              },
              padding: EdgeInsets.all(20.0),
              //color: Colors.pinkAccent,
              color: Colors.pink[600],
              textColor: Colors.white,
              child: Text("Statystyki                    ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20)),
            ),

          ],
        ),
      ),
    );
  }
}
