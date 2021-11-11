import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/ui/doctor/calculator/calculator_button.dart';
import 'package:hepies/ui/doctor/favorites/favorites.dart';
import 'package:hepies/ui/doctor/guidelines/guidelines.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _history = '';
  String _expression = '';

  void numClick(String text) {
    setState(() => _expression += text);
  }

  void allClear(String text) {
    setState(() {
      _history = '';
      _expression = '';
    });
  }

  void clear(String text) {
    setState(() {
      _expression = '';
    });
  }

  void evaluate(String text) {
    Parser p = Parser();
    Expression exp = p.parse(_expression);
    ContextModel cm = ContextModel();

    setState(() {
      _history = _expression;
      _expression = exp.evaluate(EvaluationType.REAL, cm).toString();
    });
  }

// Milkessa: BMI calculator has been added to this page using an enum 'calcState' which controls the type of calculator to display
// added variables: 'calcState', 'weightInput', 'bmiResult'
//added method: 'bmiCalc'
  CalcState calcState = CalcState.normal;
  String weightInput, heightInput;
  String bmiResult = '';
  bool calculated = false;
  String bmiCalc(double weight, double height) {
    double bmi = weight * 10000 / (height * height);
    print(bmi);
    return bmi.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 0.0),
                    child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Guidelines()));
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45, width: 2),
                        ),
                        child: Center(
                            child: Text(
                          'Guidelines',
                          style: TextStyle(fontSize: 18.0),
                        )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Calculator()));
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45, width: 2),
                        ),
                        child: Center(
                            child: Text('Calculator',
                                style: TextStyle(fontSize: 18.0))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () async {
                        var user = await UserPreferences().getUser();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FavoritesPage(user.professionid)));
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45, width: 2),
                        ),
                        child: Center(
                            child: Text('Favorites',
                                style: TextStyle(fontSize: 18.0))),
                      ),
                    ),
                  )
                ],
              ),
              GestureDetector(
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(13.0),
                  margin: EdgeInsets.only(left: 10, top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 2),
                  ),
                  child: Center(
                      child: Text(
                    'BMI',
                    style: TextStyle(fontSize: 18, color: Color(0xff07febb)),
                  )),
                ),
                onTap: () {
                  setState(() {
                    calcState = CalcState.bmi;
                  });
                },
              ),
              GestureDetector(
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(13.0),
                  margin: EdgeInsets.only(left: 10, top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 2),
                  ),
                  child: Center(
                      child: Text(
                    'GFR',
                    style: TextStyle(fontSize: 18, color: Color(0xff07febb)),
                  )),
                ),
                onTap: () {
                  setState(() {
                    calcState = CalcState.normal;
                  });
                },
              ),
              calcState == CalcState.normal
                  ? Container(
                      child: Column(
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Text(
                                _history,
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    fontSize: 24,
                                    color: Color(0xFF545F61),
                                  ),
                                ),
                              ),
                            ),
                            alignment: Alignment(1.0, 1.0),
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Text(
                                _expression,
                                style: GoogleFonts.rubik(
                                  textStyle: TextStyle(
                                    fontSize: 48,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            alignment: Alignment(1.0, 1.0),
                          ),
                          SizedBox(height: 40),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CalcButton(
                                text: 'AC',
                                fillColor: 0xFF6C807F,
                                textSize: 20,
                                callback: allClear,
                              ),
                              CalcButton(
                                text: 'C',
                                fillColor: 0xFF6C807F,
                                callback: clear,
                              ),
                              CalcButton(
                                text: '%',
                                fillColor: 0xFFFFFFFF,
                                textColor: 0xFF65BDAC,
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '/',
                                fillColor: 0xFFFFFFFF,
                                textColor: 0xFF65BDAC,
                                callback: numClick,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CalcButton(
                                text: '7',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '8',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '9',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '*',
                                fillColor: 0xFFFFFFFF,
                                textColor: 0xFF65BDAC,
                                textSize: 24,
                                callback: numClick,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CalcButton(
                                text: '4',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '5',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '6',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '-',
                                fillColor: 0xFFFFFFFF,
                                textColor: 0xFF65BDAC,
                                textSize: 38,
                                callback: numClick,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CalcButton(
                                text: '1',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '2',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '3',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '+',
                                fillColor: 0xFFFFFFFF,
                                textColor: 0xFF65BDAC,
                                textSize: 30,
                                callback: numClick,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              CalcButton(
                                text: '.',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '0',
                                callback: numClick,
                              ),
                              CalcButton(
                                text: '00',
                                callback: numClick,
                                textSize: 26,
                              ),
                              CalcButton(
                                text: '=',
                                fillColor: 0xFFFFFFFF,
                                textColor: 0xFF65BDAC,
                                callback: evaluate,
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: width(context) * 0.125,
                        vertical: height(context) * 0.125,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          children: [
                            calculated == false
                                ? Container(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Calculate BMI',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25.0),
                                        ),
                                        SizedBox(height: 15),
                                        TextField(
                                          autofocus: false,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                                Icons.monitor_weight,
                                                color: Color.fromRGBO(
                                                    50, 62, 72, 1.0)),
                                            hintText: "Weight (Kg)",
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          onChanged: (input) {
                                            weightInput = input;
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        TextField(
                                          autofocus: false,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.height,
                                                color: Color.fromRGBO(
                                                    50, 62, 72, 1.0)),
                                            hintText: "Height (cm)",
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0)),
                                          ),
                                          onChanged: (input) {
                                            heightInput = input;
                                          },
                                        ),
                                        SizedBox(height: 20),
                                      ],
                                    ),
                                  )
                                : Container(
                                    height: height(context) * 0.3,
                                    width: width(context) * 0.3,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 5,
                                      ),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Text(
                                        bmiResult,
                                        textScaleFactor: 2.5,
                                        style: TextStyle(fontWeight: bold),
                                      ),
                                    ),
                                  ),
                            Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Center(
                                child: Container(
                                  width: width(context) * 0.2375,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                  ),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (weightInput != null) {
                                            calculated = !calculated;
                                            bmiResult = bmiCalc(
                                              double.parse(weightInput ?? 0),
                                              double.parse(heightInput ?? 1),
                                            );
                                          } else {
                                            calculated = false;
                                          }
                                        });
                                      },
                                      child: Center(
                                        child: Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: Text(
                                            !calculated ? 'calculate' : 'reset',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

enum CalcState { normal, bmi, gfr }
