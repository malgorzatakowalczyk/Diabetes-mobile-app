import 'package:flutter/material.dart';
import 'bmiCalculator.dart';
import 'homairCalculator.dart';
import 'sugarUnitConverter.dart';
import 'listOfSugarLevels.dart';
import 'average.dart';


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
      ),
      body: Container(
      decoration: new BoxDecoration(
    image: new DecorationImage(
    image: new AssetImage('assets/11.png'),
    fit: BoxFit.cover,
    ),
      ),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
        RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.pink[600])),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ListOfSugarLevels()),
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
                  MaterialPageRoute(builder: (context) => BmiCalculator()),
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
                  MaterialPageRoute(builder: (context) => HomairCalculator()),
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
                  MaterialPageRoute(builder: (context) => SugarUnitConverter()),
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
                  MaterialPageRoute(builder: (context) => Demo6()),
                );
              },
              padding: EdgeInsets.all(20.0),
              //color: Colors.pinkAccent,
              color: Colors.pink[600],
              textColor: Colors.white,
              child: Text("Statystyki                    ",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20
                  )),
            ),

          ],
        ),
      ),
    );
  }
}