import 'package:flutter/material.dart';

class BmiCalculator extends StatefulWidget {
  @override
  _BmiCalculatorState createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  String _comment;
  Color colorOfButton = Colors.white;
  Color darkPink=Colors.pink[800];
  Color pink=Colors.pink[600];
  double height = 1, weight = 1, age = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: darkPink,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('Podaj wzrost [cm]:'),
            Slider(
              activeColor: pink,
              value: height,
              min: 0,
              max: 250,
              divisions: 250,
              label: height.round().toString(),
              onChanged: (double value) {
                setState(() {
                  height = value;
                });
              },
            ),
            new Text('Podaj wage [kg]:'),
            Slider(
              activeColor: pink,
              value: weight,
              min: 0,
              max: 250,
              divisions: 250,
              label: weight.round().toString(),
              onChanged: (double value) {
                setState(() {
                  weight = value;
                });
              },
            ),
            new Text('Podaj wiek:'),
            Slider(
              activeColor: pink,
              value: age,
              min: 0,
              max: 100,
              divisions: 100,
              label: age.round().toString(),
              onChanged: (double value) {
                setState(() {
                  age = value;
                });
              },
            ),
            SizedBox(height: 15),
            RaisedButton(
              color: pink,
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
                color: colorOfButton,
                child: Text(
                  _comment == null
                      ? "Uzupełnij brakujące wartości"
                      : "$_comment",
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

    height /= 100;
    double heightSquare = height * height;
    double result = weight / heightSquare;
    String resultStr = result.toStringAsFixed(2);
    int ageBMI = age.toInt();

    if (ageBMI < 18) {
      _comment = "Wskaźnik BMI przeznaczony jest dla osób dorosłych";
      colorOfButton = Colors.cyanAccent;
    } else {
      if (result < 16) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na wygłodzenię";
        colorOfButton = Colors.redAccent;
      } else if (result >= 16 && result < 17) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na wychudzenię";
        colorOfButton = Colors.orangeAccent;
      } else if (result >= 17 && result < 18.5) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na niedowagę";
        colorOfButton = Colors.yellowAccent;
      } else if (result >= 18.5 && result < 25) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na prawidłową wagę";
        colorOfButton = Colors.lightGreenAccent;
      } else if (result >= 25 && result < 30) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na nadwagę";
        colorOfButton = Colors.yellowAccent;
      } else if (result >= 30 && result < 35) {
        _comment =
            "Twoje bmi wynosi $resultStr i wskazuje na otyłość pierwszego stopnia";
        colorOfButton = Colors.orangeAccent;
      } else if (result >= 35 && result < 40) {
        _comment =
            "Twoje bmi wynosi $resultStr i wskazuje na otyłość drugiego stopnia";
        colorOfButton = Colors.redAccent;
      } else if (result >= 40) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na skrajną otyłość";
        colorOfButton = Colors.redAccent;
      }
    }
    height = height * 100;
    setState(() {});
  }
}
