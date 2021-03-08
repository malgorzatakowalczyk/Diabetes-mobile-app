import 'package:flutter/material.dart';

class HomairCalculator extends StatefulWidget {
  @override
  _HomairCalculatorState createState() => _HomairCalculatorState();
}

class _HomairCalculatorState extends State<HomairCalculator> {
  final TextEditingController _insulinController = TextEditingController();
  final TextEditingController _glucoseController = TextEditingController();

  String _comment;
  Color colorOfButton = Colors.white;
  Color darkPink = Colors.pink[800];
  Color pink = Colors.pink[600];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOMA-IR'),
        centerTitle: true,
        backgroundColor: darkPink,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _insulinController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                icon: Icon(Icons.medical_services_outlined),
                labelText: 'Insulina na czczo mU/ml',
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _glucoseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Glukoza na czczo mmol/l',
                icon: Icon(Icons.medical_services),
              ),
            ),
            SizedBox(height: 15),
            RaisedButton(
              color: pink,
              child: Text(
                "Sprawdź",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: calculateHOMAIR,
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

  void calculateHOMAIR() {
    if (_insulinController.text != "" && _glucoseController.text != "") {
      double height = double.parse(_insulinController.text);
      double weight = double.parse(_glucoseController.text);

      double result = (height * weight) / 22.5;
      String resultStr = result.toStringAsFixed(2);
      if (result < 1) {
        _comment = "Wskaźnik wynosi $resultStr. Wyniki prawidłowe.";
        colorOfButton = Colors.lightGreenAccent;
      } else if (result >= 1 && result < 2) {
        _comment =
            "Wskaźnik wynosi $resultStr. Konieczna jest dalsza diagnostyka u lekarza";
        colorOfButton = Colors.yellowAccent;
      } else if (result >= 2) {
        _comment =
            "Wskaźnik wynosi $resultStr. Może to świadczyć o insulinooporności";
        colorOfButton = Colors.redAccent;
      }
      setState(() {});
    }
  }
}
