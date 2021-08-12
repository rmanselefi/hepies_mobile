import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hepies/models/drug.dart';
import 'package:hepies/models/dx.dart';
import 'package:hepies/models/hx.dart';
import 'package:hepies/models/investigation.dart';
import 'package:hepies/models/patient.dart';
import 'package:hepies/models/prescription.dart';
import 'package:hepies/models/px.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/medicalrecords/add_history.dart';
import 'package:hepies/ui/medicalrecords/historypages/hx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InstrumentPrescription extends StatefulWidget {
  final Function setPrescription;
  InstrumentPrescription({this.setPrescription});
  @override
  _InstrumentPrescriptionState createState() => _InstrumentPrescriptionState();
}

class _InstrumentPrescriptionState extends State<InstrumentPrescription> {
  final formKey = new GlobalKey<FormState>();
  var prescription = new Prescription();
  var patient = new Patient();
  var drug = new Drug();
  var hx = new History();
  var strengthController = new TextEditingController();
  var unitController = new TextEditingController();
  var routeController = new TextEditingController();
  var materialController = new TextEditingController();
  var sizeController = new TextEditingController();
  List<dynamic> finaPrescription = [];
  List<dynamic> drugs;
  String _selectedAnimal;

  var history = new History();
  var physical = new Physical();
  var diagnosis = new Diagnosis();
  var ix = new Investigation();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void _setHx(History hx) {
    setState(() {
      history = hx;
    });
    print("object hx ${history.hpi}");
  }

  void _setPx(Physical px) {
    setState(() {
      physical = px;
    });
  }

  void _setDx(Diagnosis dx) {
    setState(() {
      diagnosis = dx;
    });
  }

  String _chosenValue;
  void _openImagePicker(BuildContext context, int pageNum) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              height: MediaQuery.of(context).size.height - 50.0,
              child: AddHistory(
                pageNumber: pageNum,
                setDx: _setDx,
                setHx: _setHx,
                setPx: _setPx,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    drugs = Provider.of<DrugProvider>(context, listen: true).drugs;
    return Container(
      child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30.0,
              ),
              Container(
                decoration: BoxDecoration(color: Colors.blue),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 200,
                            height: 40,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  patient.phone = val;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Enter Phone Number',
                                  hintText: 'Enter Phone Number'),
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 40,
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                patient.age = val;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Age',
                                hintText: 'Age'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            focusColor: Colors.white,
                            value: _chosenValue,
                            //elevation: 5,
                            style: TextStyle(color: Colors.white),
                            iconEnabledColor: Colors.black,
                            items: <String>[
                              'Male',
                              'Female',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(color: Colors.black),
                                ),
                              );
                            }).toList(),
                            hint: Text(
                              "Sex",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            onChanged: (String value) {
                              setState(() {
                                _chosenValue = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 150,
                            height: 40,
                            child: TextFormField(
                              onChanged: (val) {
                                setState(() {
                                  patient.name = val;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                  hintText: 'Name'),
                            ),
                          ),
                        ),
                        Container(
                          width: 150,
                          height: 40,
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                patient.fathername = val;
                              });
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Father Name',
                                hintText: 'Father Name'),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 40,
                          child: TextFormField(
                            onChanged: (val) {
                              setState(() {
                                patient.weight = val;
                              });
                            },
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Kg',
                                hintText: 'Kg'),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 270,
                                height: 40,
                                child: TextFormField(
                                  controller: materialController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name Of Instrument',
                                      hintText: 'Name Of Instrument'),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width: 120,
                                    height: 40,
                                    child: TextFormField(
                                      controller: sizeController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Size',
                                          hintText: 'Size'),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 40,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: '#',
                                        hintText: '#'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('type', 'instrument');
                                    _openImagePicker(context, 3);

                                  },
                                  child: Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green[400], width: 2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'DX',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('type', 'instrument');
                                    _openImagePicker(context, 2);

                                  },
                                  child: Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green[400], width: 2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'IX',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('type', 'instrument');
                                    _openImagePicker(context, 0);

                                  },
                                  child: Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green[400], width: 2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'HX',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('type', 'instrument');
                                    _openImagePicker(context, 1);

                                  },
                                  child: Container(
                                    width: 50,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.green[400], width: 2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'PX',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Remark',
                              hintText: 'Remark'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onTap: (){
                  final Map<String, dynamic> precriptionData = {
                    'drug_name': "",
                    "strength": strengthController.text,
                    "unit": unitController.text,
                    "route": routeController.text,
                    "takein": prescription.takein,
                    "frequency": prescription.frequency,
                    "drug": prescription.drug,
                    "material_name":materialController.text,
                    "size":sizeController.text,
                    "type":"instrument",
                    "patient": {
                      "name": patient.name,
                      "age": patient.age,
                      "fathername": patient.fathername,
                      "grandfathername": "kebede",
                      "phone": patient.phone,
                      "sex": _chosenValue,
                      "weight": patient.weight,
                      "dx": {"diagnosis": diagnosis.diagnosis},
                      "hx": {"cc": history.cc, "hpi": history.hpi},
                      "px": {
                        "abd": physical.abd,
                        "bp": physical.bp,
                        "cvs": physical.cvs,
                        "ga": physical.ga,
                        "heent": physical.heent,
                        "lgs": physical.lgs,
                        "pr": physical.pr,
                        "rr": physical.rr,
                        "rs": physical.rs,
                        "temp": physical.temp
                      },
                      "ix": {
                        "microbiology": "micro",
                        "pathologyindex": "1023",
                        "radiologyindex": "456",
                        "others": "",
                        "chemistry": {
                          "TIBC": "",
                          "albumin": "",
                          "alp": "",
                          "altsgpt": "",
                          "amylase": "",
                          "ferritin": "",
                          "hba1c": "",
                          "hdl": "",
                          "astsgot": "",
                          "bunurea": "",
                          "calcium": "",
                          "calciumionized": "",
                          "chloride": "",
                          "cholesterol": "",
                          "fbs": "",
                          "iron": "",
                          "ldl": "",
                          "lipase": "",
                          "magnesium": "",
                          "phosphorous": "",
                          "potassium": "",
                          "protein": "",
                          "rbs": "",
                          "serumfolate": "",
                          "sodium": "",
                          "transferrinsaturation": "",
                          "triglyceride": ""
                        },
                        "endocrinology": {
                          "erythropoietin": "",
                          "estradiol": "",
                          "fsh": "",
                          "growthhormone": "",
                          "lh": "",
                          "progesterone": "",
                          "prolactin": "",
                          "pth": "",
                          "serumcalcitonin": "",
                          "serumcortisol": "",
                          "t3": "",
                          "t4": "",
                          "testosterone": "",
                          "tsh": "",
                          "vitD": "",
                          "vitb12": ""
                        },
                        "hemathology": {
                          "bgrh": "",
                          "esr": "",
                          "hct": "",
                          "mch": "",
                          "mchc": "",
                          "mcv": "",
                          "pltcount": "",
                          "reticulocyte": "",
                          "wbccount": ""
                        },
                        "serology": {
                          "CD4count": "",
                          "HBsAg": "",
                          "HIVmedical": "",
                          "HIVviralload": "",
                          "ana": "",
                          "aso": "",
                          "betahcg": "",
                          "coombs": "",
                          "crp": "",
                          "rf": "",
                          "welfelix": "",
                          "widal": ""
                        },
                        "urine": {
                          "stoolexam": "",
                          "stooloccultblood": "",
                          "stoolplylori": "",
                          "urinehcg": ""
                        }
                      }
                    }
                  };
                  print("objectobjectobjectobject $precriptionData");
                  setState(() {
                    finaPrescription.add(precriptionData);
                  });
                  widget.setPrescription(precriptionData);
                  formKey.currentState.reset();
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 50,
                      height: 30,
                      decoration: BoxDecoration(
                        color: Colors.green[400],
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: Center(
                          child: Text(
                        'ADD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      )),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[200]),
                      color: Colors.lightBlueAccent[100]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Cefriaxon 1gm IV BID 07 Days................'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            'Cefriaxon 1gm IV BID 07 Days................'),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
