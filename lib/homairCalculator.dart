import 'package:flutter/material.dart';

class Demo2 extends StatefulWidget {
  @override
  _DemoState createState() => _DemoState();
}

class _DemoState extends State<Demo2> {
  final TextEditingController _insulinController = TextEditingController();
  final TextEditingController _glucoseController = TextEditingController();

  String _comment;
  Color color=Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HOMA-IR'),
        centerTitle: true,
        backgroundColor: Colors.pink[800],
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
               // hintText: "Insulina na czczo mU/ml",
                icon: Icon(Icons.trending_up),
                labelText: 'Insulina na czczo mU/ml',
              ),
            ),
            SizedBox(height: 15),
            TextField(
              controller: _glucoseController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Glukoza na czczo mmol/l',
                //hintText: "Glukoza na czczo mmol/l",
                icon: Icon(Icons.line_weight),
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
              onPressed: calculateHOMAIR,
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

  void calculateHOMAIR() {
    if (_insulinController.text != "" && _glucoseController.text != "") {
      double height = double.parse(_insulinController.text);
      double weight = double.parse(_glucoseController.text);

      double result = (height * weight) / 22.5;
      String resultStr = result.toStringAsFixed(2);
      if (result < 1) {
        _comment = "Wskaźnik wynosi $resultStr. Wyniki prawidłowe.";
        color = Colors.lightGreenAccent;
      }
      else if (result >= 1 && result < 2) {
        _comment =
        "Wskaźnik wynosi $resultStr. Konieczna jest dalsza diagnostyka u lekarza";
        color = Colors.yellowAccent;
      }
      else if (result >= 2) {
        _comment =
        "Wskaźnik wynosi $resultStr. Może to świadczyć o insulinooporności";
        color = Colors.redAccent;
      }

      setState(() {});
    }
  }
}