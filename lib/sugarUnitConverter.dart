import 'package:flutter/material.dart';

class SugarUnitConverter extends StatefulWidget {
  @override
  _SugarUnitConverterState createState() => _SugarUnitConverterState();
}

class _SugarUnitConverterState extends State<SugarUnitConverter> {
  final TextEditingController _unit1Controller = TextEditingController();
  final TextEditingController _unit2Controller = TextEditingController();

  String _comment;
  double result = 0;
  Color darkPink=Colors.pink[800];
  Color pink=Colors.pink[600];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Przelicznik jednostek cukru'),
        centerTitle: true,
        backgroundColor: darkPink,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _unit1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Glikemia mg/dL",
                icon: Icon(Icons.trending_up),
              ),
            ),
            SizedBox(height: 15),
            RaisedButton(
              color: pink,
              child: Text(
                "Przelicz",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: calculateUnit1ToUnit2,
            ),
            TextField(
              controller: _unit2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Glikemia mmol/L",
                icon: Icon(Icons.line_weight),
              ),
            ),
            SizedBox(height: 15),
            RaisedButton(
              color: pink,
              child: Text(
                "Przelicz",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: calculateUnit2ToUnit1,
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 300,
              height: 100,
              child: RaisedButton(
                color: Colors.white,
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

  void calculateUnit1ToUnit2() {
    if (_unit1Controller.text != "") {
      double unit2 = double.parse(_unit1Controller.text);
      result = unit2 / 18;
      String resultStr = result.toStringAsFixed(2);
      _comment = "$resultStr mmol/L";
      setState(() {});
    }
  }

  void calculateUnit2ToUnit1() {
    if (_unit2Controller.text != "") {
      double unit1 = double.parse(_unit2Controller.text);
      result = unit1 * 18;
      String resultStr = result.toStringAsFixed(2);
      _comment = "$resultStr mg/dL";
      setState(() {});
    }
  }
}
