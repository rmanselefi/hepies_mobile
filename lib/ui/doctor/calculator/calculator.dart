// ignore_for_file: unrelated_type_equality_checks, unused_local_variable

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

// Milkessa: BMI and GFR calculators have been added to this page using an enum 'calcState' which controls the type of calculator to display
// added variables: 'calcState', 'weightInput', 'bmiResult', gfrWeight, age, sex
//added method: 'bmiCalc', gfrCalc
  CalcState calcState = CalcState.normal;
  String weightInput, heightInput;
  String bmiResult = '';
  bool calculated = false;
  String bmiCalc(double weight, double height) {
    double bmi = weight * 10000 / (height * height);
    return bmi.toStringAsFixed(1);
  }

  double gfrWeight, sCr, gfrResult;
  int age;
  String sex = 'm';
  bool gfrCalculated = false;
  double gfrCalc(double gfrWeight, double sCr, int age, String sex) {
    double gfr = (140 - age) * gfrWeight / (72 * sCr);
    if (sex == 'f') gfr = gfr * 0.85;
    return gfr;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
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
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Guidelines()));
                    },
                    child: Container(
                      height: 30,
                      width: width(context) * 0.24,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 2),
                      ),
                      child: Center(
                          child: Text(
                        'Guidelines',
                        style: TextStyle(fontSize: 16.0),
                      )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Calculator()));
                    },
                    child: Container(
                      height: 30,
                      width: width(context) * 0.24,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 2),
                      ),
                      child: Center(
                          child: Text('Calculator',
                              style: TextStyle(fontSize: 16.0))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
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
                      height: 30,
                      width: width(context) * 0.24,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45, width: 2),
                      ),
                      child: Center(
                          child: Text('Favorites',
                              style: TextStyle(fontSize: 16.0))),
                    ),
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Container(
                    width: width(context) * 0.3,
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      color: calcState == CalcState.normal
                          ? Colors.black87
                          : Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      'NORMAL',
                      style: TextStyle(fontSize: 16, color: Color(0xff07febb)),
                    )),
                  ),
                  onTap: () {
                    setState(() {
                      calcState = CalcState.normal;
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    width: width(context) * 0.24,
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.only(left: 10, top: 10 , bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      color: calcState == CalcState.bmi
                          ? Colors.black87
                          : Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      'BMI',
                      style: TextStyle(fontSize: 16, color: Color(0xff07febb)),
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
                    width: width(context) * 0.24,
                    padding: EdgeInsets.all(5.0),
                    margin: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 2),
                      color: calcState == CalcState.gfr
                          ? Colors.black87
                          : Colors.white,
                    ),
                    child: Center(
                        child: Text(
                      'GFR',
                      style: TextStyle(fontSize: 16, color: Color(0xff07febb)),
                    )),
                  ),
                  onTap: () {
                    setState(() {
                      calcState = CalcState.gfr;
                    });
                  },
                ),
              ],
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
                                  color: Colors.black,
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
                : calcState == CalcState.bmi
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: width(context) * 0.125,
                          vertical: height(context) * 0.125,
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Column(
                            children: [
                              !calculated
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
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
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
                                      color: Color(0xff07febb),
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
                                              !calculated
                                                  ? 'calculate'
                                                  : 'reset',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
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
                              !gfrCalculated
                                  ? Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            'Calculate GFR',
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
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                            onChanged: (input) {
                                              gfrWeight = double.parse(input);
                                            },
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Flexible(
                                                child: TextField(
                                                  autofocus: false,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                        Icons.timelapse,
                                                        color: Color.fromRGBO(
                                                            50, 62, 72, 1.0)),
                                                    hintText: "Age",
                                                    contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            20.0,
                                                            15.0,
                                                            20.0,
                                                            15.0),
                                                    border: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0)),
                                                  ),
                                                  onChanged: (input) {
                                                    age = int.parse(input);
                                                  },
                                                ),
                                              ),
                                              SizedBox(width: 20),
                                              DropdownButton(
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text('Male'),
                                                    value: 'm',
                                                    enabled: true,
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text('Female'),
                                                    value: 'f',
                                                    enabled: true,
                                                  ),
                                                ],
                                                value: sex,
                                                onChanged: (input) {
                                                  setState(() {
                                                    sex = input;
                                                  });
                                                },
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                ),
                                                hint: Text('Sex'),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          TextField(
                                            autofocus: false,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              prefixIcon: Icon(Icons.input,
                                                  color: Color.fromRGBO(
                                                      50, 62, 72, 1.0)),
                                              hintText: "sRc (mg/dl)",
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0)),
                                            ),
                                            onChanged: (input) {
                                              sCr = double.parse(input);
                                            },
                                          ),
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
                                          gfrResult.toStringAsFixed(2),
                                          textScaleFactor: 2.5,
                                          style: TextStyle(fontWeight: bold),
                                        ),
                                      ),
                                    ),
                              SizedBox(height: 25),
                              Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Center(
                                  child: Container(
                                    width: width(context) * 0.2375,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: Color(0xff07febb),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(4.0),
                                      ),
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (gfrWeight != null &&
                                                sCr != null &&
                                                age != null) {
                                              gfrCalculated = !gfrCalculated;
                                              gfrResult = gfrCalc(
                                                  gfrWeight, sCr, age, sex);
                                            } else {
                                              gfrCalculated = false;
                                            }
                                          });
                                        },
                                        child: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(4.0),
                                            child: Text(
                                              !gfrCalculated
                                                  ? 'calculate'
                                                  : 'reset',
                                              style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.black,
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
    );
  }
}

enum CalcState { normal, bmi, gfr }
