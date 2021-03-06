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
                "Sprawd??",
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
                      ? "Uzupe??nij brakuj??ce warto??ci"
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
      _comment = "Wska??nik BMI przeznaczony jest dla os??b doros??ych";
      colorOfButton = Colors.cyanAccent;
    } else {
      if (result < 16) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na wyg??odzeni??";
        colorOfButton = Colors.redAccent;
      } else if (result >= 16 && result < 17) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na wychudzeni??";
        colorOfButton = Colors.orangeAccent;
      } else if (result >= 17 && result < 18.5) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na niedowag??";
        colorOfButton = Colors.yellowAccent;
      } else if (result >= 18.5 && result < 25) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na prawid??ow?? wag??";
        colorOfButton = Colors.lightGreenAccent;
      } else if (result >= 25 && result < 30) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na nadwag??";
        colorOfButton = Colors.yellowAccent;
      } else if (result >= 30 && result < 35) {
        _comment =
            "Twoje bmi wynosi $resultStr i wskazuje na oty??o???? pierwszego stopnia";
        colorOfButton = Colors.orangeAccent;
      } else if (result >= 35 && result < 40) {
        _comment =
            "Twoje bmi wynosi $resultStr i wskazuje na oty??o???? drugiego stopnia";
        colorOfButton = Colors.redAccent;
      } else if (result >= 40) {
        _comment = "Twoje bmi wynosi $resultStr i wskazuje na skrajn?? oty??o????";
        colorOfButton = Colors.redAccent;
      }
    }
    height = height * 100;
    setState(() {});
  }
}
