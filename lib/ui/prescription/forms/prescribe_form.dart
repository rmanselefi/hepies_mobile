import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hepies/models/chemistry.dart';
import 'package:hepies/models/drug.dart';
import 'package:hepies/models/dx.dart';
import 'package:hepies/models/endocrinology.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/models/hematology.dart';
import 'package:hepies/models/hx.dart';
import 'package:hepies/models/investigation.dart';
import 'package:hepies/models/patient.dart';
import 'package:hepies/models/prescription.dart';
import 'package:hepies/models/px.dart';
import 'package:hepies/models/serology.dart';
import 'package:hepies/models/tumor.dart';
import 'package:hepies/models/urine.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/favorites.dart';
import 'package:hepies/providers/patient_provider.dart';
import 'package:hepies/ui/medicalrecords/add_history.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrescribeForm extends StatefulWidget {
  final Function setPrescription;
  final String type;
  PrescribeForm(this.setPrescription, this.type);
  @override
  _PrescribeFormState createState() => _PrescribeFormState();
}

class _PrescribeFormState extends State<PrescribeForm> {
  String status = 'add';
  int pesIndex = 0;
  String _chosenValue;
  var textHeight = 40.0;
  final _formKey = new GlobalKey<FormState>();
  var prescription = new Prescription();
  var patient = new Patient();
  var drug = new Drug();
  var hx = new History();
  var phoneController = new TextEditingController();
  var strengthController = new TextEditingController();
  var unitController = new TextEditingController();
  var ageController = new TextEditingController();
  var nameController = new TextEditingController();
  var fnameController = new TextEditingController();
  var weightController = new TextEditingController();
  var everyController = new TextEditingController();
  var forController = new TextEditingController();
  var ampuleController = new TextEditingController();
  var routeController = new TextEditingController();
  var remarkController = new TextEditingController();
  var favoriteController = new TextEditingController();
  List<dynamic> finaPrescription = [];
  List<dynamic> drugs;
  String _selectedAnimal;

  var history = new History();
  var physical = new Physical();
  var tumor = new Tumor();
  var diagnosis = new Diagnosis();
  var hematology = new Hematology();
  var serology = new Serology();
  var chemistry = new Chemistry();
  var endocrinology = new Endocrinology();
  var urine = new Urine();
  var ix = new Investigation();

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

  void _setHematology(Hematology hema) {
    setState(() {
      hematology = hema;
    });
    print("object hx ${history.hpi}");
  }

  void _setSerology(Serology sero) {
    setState(() {
      serology = sero;
    });
  }

  void _setChemistry(Chemistry chem) {
    setState(() {
      chemistry = chem;
    });
  }

  void _setEndocrinology(Endocrinology endoc) {
    setState(() {
      endocrinology = endoc;
    });
    print("object hx ${history.hpi}");
  }

  void _setUrine(Urine uri) {
    setState(() {
      urine = uri;
    });
  }

  void _setInvestigation(Investigation inv) {
    setState(() {
      ix = inv;
    });
  }

  void _setTumor(Tumor tum) {
    setState(() {
      tumor = tum;
    });
  }

  void _openHistoryForm(BuildContext context, int pageNum) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SafeArea(
              child: Container(
                height: MediaQuery.of(context).size.height - 40,
                child: AddHistory(
                    pageNumber: pageNum,
                    setDx: _setDx,
                    setHx: _setHx,
                    setPx: _setPx,
                    setChemistry: _setChemistry,
                    setEndocrinology: _setEndocrinology,
                    setHematology: _setHematology,
                    setSerology: _setSerology,
                    setUrine: _setUrine,
                    setTumor: _setTumor,
                    setInvestigation: _setInvestigation),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    drugs = Provider.of<DrugProvider>(context, listen: true).drugs;
    return Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: textHeight,
                      child: TextFormField(
                        controller: phoneController,
                        validator: (val) {
                          if (val.isEmpty) {
                            setState(() {
                              textHeight = 60.0;
                            });
                            return '';
                          } else {
                            setState(() {
                              textHeight = 60.0;
                            });
                            return null;
                          }
                        },
                        onSaved: (value) {
                          setState(() {
                            patient.phone = value;
                          });
                        },
                        onChanged: (val) async {
                          var res = await Provider.of<PatientProvider>(context,
                                  listen: false)
                              .getMedicalRecord(val);
                          if (res.length != 0) {
                            print("resresresres ${res}");
                            setState(() {
                              ageController.text = res[0]['age'];
                              _chosenValue = res[0]['sex'];
                              nameController.text = res[0]['name'];
                              fnameController.text = res[0]['fathername'];
                              weightController.text = res[0]['weight'];
                            });
                          }
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
                    height: textHeight,
                    child: TextFormField(
                      controller: ageController,
                      validator: (val) {
                        if (val.isEmpty) {
                          setState(() {
                            textHeight = 60.0;
                          });
                          return '';
                        } else {
                          setState(() {
                            textHeight = 60.0;
                          });
                          return null;
                        }
                      },
                      onSaved: (value) => patient.age = value,
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
                      height: textHeight,
                      child: TextFormField(
                        controller: nameController,
                        validator: (val) {
                          if (val.isEmpty) {
                            setState(() {
                              textHeight = 60.0;
                            });
                            return '';
                          } else {
                            setState(() {
                              textHeight = 60.0;
                            });
                            return null;
                          }
                        },
                        onSaved: (value) => patient.name = value,
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
                    height: textHeight,
                    child: TextFormField(
                      controller: fnameController,
                      validator: (val) {
                        print("valval ${val}");
                        if (val.isEmpty) {
                          setState(() {
                            textHeight = 60.0;
                          });
                          return '';
                        } else {
                          setState(() {
                            textHeight = 60.0;
                          });
                          return null;
                        }
                      },
                      onSaved: (value) => patient.fathername = value,
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
                    height: textHeight,
                    child: TextFormField(
                      controller: weightController,
                      onSaved: (value) => patient.weight = value,
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
                          child: Autocomplete(
                            optionsBuilder: (TextEditingValue value) {
                              // When the field is empty
                              if (value.text.isEmpty) {
                                return [];
                              }

                              // The logic to find out which ones should appear
                              return drugs.where((drug) {
                                return drug['name']
                                    .toLowerCase()
                                    .contains(value.text.toLowerCase());
                              });
                            },
                            onSelected: (value) {
                              strengthController.text = value['strength'];
                              unitController.text = value['unit'];
                              routeController.text = value['route'];
                              setState(() {
                                prescription.drug = value['id'].toString();
                                _selectedAnimal = value['name'];
                              });
                            },
                            displayStringForOption: (option) => option['name'],
                            fieldViewBuilder: (BuildContext context,
                                TextEditingController
                                    fieldTextEditingController,
                                FocusNode fieldFocusNode,
                                VoidCallback onFieldSubmitted) {
                              return Container(
                                height: textHeight,
                                child: TextFormField(
                                  controller: fieldTextEditingController,
                                  focusNode: fieldFocusNode,
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      setState(() {
                                        textHeight = 60.0;
                                      });
                                      return '';
                                    } else {
                                      setState(() {
                                        textHeight = 60.0;
                                      });
                                      return null;
                                    }
                                  },
                                  onSaved: (val) {
                                    setState(() {
                                      drug.name = val;
                                    });
                                  },
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: 'Name Of Drug',
                                      hintText: 'Name Of Drug'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 120,
                              height: textHeight,
                              child: TextFormField(
                                validator: (val) {
                                  if (val.isEmpty) {
                                    setState(() {
                                      textHeight = 60.0;
                                    });
                                    return '';
                                  } else {
                                    setState(() {
                                      textHeight = 60.0;
                                    });
                                    return null;
                                  }
                                },
                                controller: strengthController,
                                onChanged: (val) {
                                  setState(() {
                                    drug.strength = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Strength',
                                    hintText: 'Strength'),
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: textHeight,
                            child: TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  setState(() {
                                    textHeight = 60.0;
                                  });
                                  return '';
                                } else {
                                  setState(() {
                                    textHeight = 60.0;
                                  });
                                  return null;
                                }
                              },
                              controller: unitController,
                              onChanged: (val) {
                                setState(() {
                                  drug.unit = val;
                                });
                              },
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  labelText: 'Unit',
                                  hintText: 'Unit'),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: textHeight,
                            child: TextFormField(
                              validator: (val) {
                                if (val.isEmpty) {
                                  setState(() {
                                    textHeight = 60.0;
                                  });
                                  return '';
                                } else {
                                  setState(() {
                                    textHeight = 60.0;
                                  });
                                  return null;
                                }
                              },
                              controller: routeController,
                              onChanged: (val) {
                                setState(() {
                                  prescription.route = val;
                                });
                              },
                              minLines: 1,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Route',
                                hintText: 'Route',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.0, horizontal: 10.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80,
                              height: 40,
                              child: TextFormField(
                                controller: everyController,
                                onChanged: (val) {
                                  setState(() {
                                    prescription.frequency = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Every',
                                    hintText: 'Every'),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80,
                              height: 40,
                              child: TextFormField(
                                controller: forController,
                                onChanged: (val) {
                                  setState(() {
                                    prescription.takein = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'For',
                                    hintText: 'For'),
                              ),
                            ),
                          ),
                          Text(
                            'OR',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80,
                              height: 40,
                              child: TextFormField(
                                controller: ampuleController,
                                onChanged: (val) {
                                  setState(() {
                                    prescription.ampule = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Ampule',
                                    hintText: 'Ampule'),
                              ),
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
                              prefs.setString('type', widget.type);
                              _openHistoryForm(context, 3);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => AddHistory(3)));
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
                              prefs.setString('type', widget.type);
                              _openHistoryForm(context, 2);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => AddHistory(2)));
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
                              prefs.setString('type', widget.type);
                              _openHistoryForm(context, 0);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => AddHistory(0)));
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
                              prefs.setString('type', widget.type);
                              _openHistoryForm(context, 1);
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
                  child: TextFormField(
                    controller: remarkController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Remark',
                        hintText: 'Remark'),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: MaterialButton(
                  onPressed: () async {
                    _formKey.currentState.save();
                    if (forController.text == "" &&
                        everyController.text == "" &&
                        ampuleController.text == "") {
                      Flushbar(
                        title: 'Error',
                        message:
                            'You got provide at least ampule or frequency(take in)',
                        duration: Duration(seconds: 10),
                      ).show(context);
                    } else {
                      if (_formKey.currentState.validate()) {
                        print("saved ${serology.toJson()}");
                        User user = await UserPreferences().getUser();
                        var profession =
                            "${user.profession} ${user.name} ${user.fathername}";
                        final Map<String, dynamic> precriptionData = {
                          'drug_name': _selectedAnimal != null
                              ? _selectedAnimal
                              : drug.name,
                          "strength": strengthController.text,
                          "unit": unitController.text,
                          "route": routeController.text,
                          "takein": prescription.takein,
                          "frequency": prescription.frequency,
                          "drug": prescription.drug,
                          "professional": profession,
                          "material_name": "",
                          "size": "",
                          "type": widget.type,
                          "ampule": ampuleController.text,
                          "patient": {
                            "name": patient.name,
                            "age": patient.age,
                            "fathername": patient.fathername,
                            "grandfathername": "kebede",
                            "phone": patient.phone,
                            "sex": _chosenValue,
                            "weight": patient.weight,
                            "dx": {
                              "diagnosis": diagnosis.diagnosis_list.length != 0
                                  ? diagnosis.diagnosis_list.join(",")
                                  : ""
                            },
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
                              "temp": physical.temp,
                              "gus": physical.gus,
                              "msk": physical.msk,
                              "ints": physical.ints,
                              "cns": physical.cns,
                              "general_apearnce": physical.general_apearance
                            },
                            "ix": {
                              "microbiology": ix.microbiology,
                              "pathologyindex": ix.pathologyindex,
                              "radiologyindex": ix.radiologyindex,
                              "chemistry": chemistry.toJson(),
                              "endocrinology": endocrinology.toJson(),
                              "hemathology": hematology.toJson(),
                              "serology": serology.toJson(),
                              "urine": urine.toJson()
                            }
                          }
                        };
                        print("objectobjectobjectobject ${ix.microbiology}");
                        if (status == 'add') {
                          setState(() {
                            finaPrescription.add(precriptionData);
                          });
                        } else {
                          print(
                              "finaPrescription[pesIndex] ${finaPrescription[pesIndex]['drug_name']}");
                          setState(() {
                            finaPrescription[pesIndex]['drug_name'] =
                                _selectedAnimal;
                            finaPrescription[pesIndex]["strength"] =
                                strengthController.text;
                            finaPrescription[pesIndex]["unit"] =
                                unitController.text;
                            finaPrescription[pesIndex]['route'] =
                                routeController.text;
                            finaPrescription[pesIndex]['takein'] =
                                prescription.takein;
                            finaPrescription[pesIndex]['frequency'] =
                                prescription.frequency;
                            finaPrescription[pesIndex]["drug"] =
                                prescription.drug;
                            finaPrescription[pesIndex]["type"] = widget.type;

                            finaPrescription[pesIndex]['patient']['name'] =
                                patient.name;
                            finaPrescription[pesIndex]["patient"]['age'] =
                                ageController.text;
                            finaPrescription[pesIndex]["patient"]
                                ['fathername'] = fnameController.text;
                            finaPrescription[pesIndex]['patient']
                                ['grandfathername'] = 'kebede';
                            finaPrescription[pesIndex]['patient']['phone'] =
                                phoneController.text;
                            finaPrescription[pesIndex]['patient']['sex'] =
                                _chosenValue;
                            finaPrescription[pesIndex]["patient"]['weight'] =
                                weightController.text;
                            finaPrescription[pesIndex]["patient"]['dx']
                                    ['diagnosis'] =
                                diagnosis.diagnosis_list.join(",");
                            finaPrescription[pesIndex]["patient"]['hx']['cc'] =
                                history.cc;
                            finaPrescription[pesIndex]["patient"]['hx']['hpi'] =
                                history.hpi;
                            finaPrescription[pesIndex]["patient"]['px']['abd'] =
                                physical.abd;
                            finaPrescription[pesIndex]["patient"]['px']['cvs'] =
                                physical.cvs;
                            finaPrescription[pesIndex]["patient"]['px']['ga'] =
                                physical.ga;
                            finaPrescription[pesIndex]["patient"]['px']['bp'] =
                                physical.bp;
                            finaPrescription[pesIndex]["patient"]['px']
                                ['heent'] = physical.heent;
                            finaPrescription[pesIndex]["patient"]['px']['lgs'] =
                                physical.lgs;
                            finaPrescription[pesIndex]["patient"]['px']['pr'] =
                                physical.pr;
                            finaPrescription[pesIndex]["patient"]['px']['rr'] =
                                physical.rr;
                            finaPrescription[pesIndex]["patient"]['px']['rs'] =
                                physical.rs;
                            finaPrescription[pesIndex]["patient"]['px']
                                ['temp'] = physical.temp;
                            finaPrescription[pesIndex]["patient"]['px']
                                    ['general_apearance'] =
                                physical.general_apearance;
                            finaPrescription[pesIndex]["patient"]['px']
                                ['ints'] = physical.ints;
                            finaPrescription[pesIndex]["patient"]['px']['cns'] =
                                physical.cns;
                            finaPrescription[pesIndex]["patient"]['px']['msk'] =
                                physical.msk;
                            finaPrescription[pesIndex]["patient"]['px']['gus'] =
                                physical.gus;
                          });
                        }
                        widget.setPrescription(precriptionData);
                        _formKey.currentState.reset();
                        nameController.text = '';
                        fnameController.text = '';
                        weightController.text = '';
                        phoneController.text = '';
                        ageController.text = '';
                        strengthController.text = '';
                        unitController.text = '';
                        routeController.text = '';
                        everyController.text = '';
                        forController.text = '';

                        setState(() {
                          status = 'add';
                        });
                      }
                    }
                  },
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
                        status == 'add' ? 'ADD' : 'EDIT',
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
              Container(
                height: 230.0,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[200]),
                    color: Colors.lightBlueAccent[100]),
                child: Column(
                  children: [
                    Row(
                      children: [
                        finaPrescription.length != 0
                            ? MaterialButton(
                                color: Colors.green[400],
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('AlertDialog Title'),
                                      content: TextFormField(
                                        controller: favoriteController,
                                        decoration: InputDecoration(
                                            hintText: 'Group name'),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            var user = await UserPreferences()
                                                .getUser();
                                            finaPrescription.forEach((element) {
                                              Favorites favorites =
                                                  new Favorites(
                                                      drug_name:
                                                          element['drug_name'],
                                                      name: favoriteController
                                                          .text,
                                                      professional_id:
                                                          user.professionid,
                                                      route: element['route'],
                                                      strength:
                                                          element['strength']);

                                              Provider.of<FavoritesProvider>(
                                                      context)
                                                  .saveFavorites(favorites);
                                            });

                                            Navigator.pop(context, 'OK');
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text('Add to favorites'),
                              )
                            : Container()
                      ],
                      mainAxisAlignment: MainAxisAlignment.end,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: finaPrescription.map<Widget>((pres) {
                        return Row(
                          children: [
                            Text(
                                '${finaPrescription.indexOf(pres) + 1}. ${pres['drug_name']} ${pres['strength']} ${pres['unit']} ${pres['route']} Every ${pres['frequency']} For ${pres['takein']}'),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print("object $pres");
                                    setState(() {
                                      status = 'edit';
                                      pesIndex = finaPrescription.indexOf(pres);
                                    });
                                    phoneController.text =
                                        pres['patient']['phone'];
                                    nameController.text =
                                        pres['patient']['name'];
                                    fnameController.text =
                                        pres['patient']['fathername'];
                                    weightController.text =
                                        pres['patient']['weight'];
                                    ageController.text = pres['patient']['age'];
                                    strengthController.text = pres['strength'];
                                    unitController.text = pres['unit'];
                                    routeController.text = pres['route'];
                                    everyController.text = pres['frequency'];
                                    forController.text = pres['takein'];
                                    ampuleController.text = pres['ampule'];
                                  },
                                  icon: Icon(Icons.edit),
                                ),
                                IconButton(
                                  onPressed: () {
                                    var index = pesIndex =
                                        finaPrescription.indexOf(pres);
                                    setState(() {
                                      finaPrescription.removeAt(index);
                                    });
                                  },
                                  icon: Icon(Icons.cancel),
                                  padding: EdgeInsets.all(0.0),
                                  iconSize: 20.0,
                                ),
                              ],
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
