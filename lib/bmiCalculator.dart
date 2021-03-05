import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  String _comment;
  Color color=Colors.white;
  double _value = 0.0;
  void _setvalue(double value) => setState(() => _value = value);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.pink[800],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Podaj wzrost w cm",
                icon: Icon(Icons.trending_up),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
               // labelText: 'Podaj wagę w kg',
                hintText: "Podaj wagę w kg",
                icon: Icon(Icons.line_weight),
              ),
            ),
            SizedBox(height: 15),
            /*Column(
              children: <Widget>[
                new Text('Podaj wiek: ${(_value * 200).round()}'),
                new Slider(value: _value, onChanged: _setvalue)
              ],
            ),*/
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
               // labelText: 'Podaj wiek',
                hintText: "Podaj wiek",
                icon: Icon(Icons.face),
              ),
            ),
            SizedBox(height: 15),
            RaisedButton(
              color: Colors.pink[600],
              //color: Colors.pinkAccent,
              child: Text(
                "Sprawdź",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: calculateBMI,
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 300,
              height: 100,
              child: RaisedButton(
                color: color,
                child: Text(
                  _comment == null ? "Uzupełnij brakujące wartości" : "$_comment",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }

  void calculateBMI() {
    if (_heightController.text != "" && _weightController.text != "" &&
        _ageController.text != "") {
      double height = double.parse(_heightController.text) / 100;
      double weight = double.parse(_weightController.text);
      int age = int.parse(_ageController.text);

      double heightSquare = height * height;
      double result = weight / heightSquare;
      String resultStr = result.toStringAsFixed(2);
      if (age < 18) {
        _comment = "Wskaźnik BMI przeznaczony jest dla osób dorosłych";
        color = Colors.cyanAccent;
      }
      else {
        // _result = result;
        if (result < 16) {
          _comment = "Twoje bmi wynosi $resultStr i wskazuje na wygłodzenię";
          color = Colors.redAccent;
        }
        else if (result >= 16 && result < 17) {
          _comment = "Twoje bmi wynosi $resultStr i wskazuje na wychudzenię";
          color = Colors.orangeAccent;
        }
        else if (result >= 17 && result < 18.5) {
          _comment = "Twoje bmi wynosi $resultStr i wskazuje na niedowagę";
          color = Colors.yellowAccent;
        }
        else if (result >= 18.5 && result < 25) {
          _comment =
          "Twoje bmi wynosi $resultStr i wskazuje na prawidłową wagę";
          color = Colors.lightGreenAccent;
        }
        else if (result >= 25 && result < 30) {
          _comment = "Twoje bmi wynosi $resultStr i wskazuje na nadwagę";
          color = Colors.yellowAccent;
        }
        else if (result >= 30 && result < 35) {
          _comment =
          "Twoje bmi wynosi $resultStr i wskazuje na otyłość pierwszego stopnia";
          color = Colors.orangeAccent;
        }
        else if (result >= 35 && result < 40) {
          _comment =
          "Twoje bmi wynosi $resultStr i wskazuje na otyłość drugiego stopnia";
          color = Colors.redAccent;
        }
        else if (result >= 40) {
          _comment =
          "Twoje bmi wynosi $resultStr i wskazuje na skrajną otyłość";
          color = Colors.redAccent;
        }
      }
      setState(() {});
    }
  }
}