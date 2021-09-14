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
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/doctor/medicalrecords/add_history.dart';
import 'package:hepies/util/database_helper.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrescribeForm extends StatefulWidget {
  final Function setPrescription;
  final String type;
  final color;
  final from;
  PrescribeForm(this.setPrescription, this.type, this.color, this.from);
  @override
  _PrescribeFormState createState() => _PrescribeFormState();
}

class _PrescribeFormState extends State<PrescribeForm> {
  String status = 'add';
  var action_status = 'populate';
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
  var materialController = new TextEditingController();
  var sizeController = new TextEditingController();
  var drugnameController = new TextEditingController();
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

  int presIndex = 0;

  void _setHx(History hx) {
    setState(() {
      history = hx;
    });
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
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<PrescriptionProvider>(context).resetStatus();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (widget.from == "favorites" && status != "edit") {
      List<dynamic> favorites =
          Provider.of<PrescriptionProvider>(context).prescription;
      setFromFavorites(favorites);
      Future.delayed(Duration.zero, () async {
        widget.setPrescription(finaPrescription);
      });
    }
  }

  @override
  void didUpdateWidget(covariant PrescribeForm oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);

    var selectedPrescription =
        Provider.of<PrescriptionProvider>(context).singlePrescription;
    var statuse = Provider.of<PrescriptionProvider>(context).status;
    var actionstatus = Provider.of<PrescriptionProvider>(context).actionStatus;
    var index = Provider.of<PrescriptionProvider>(context).prescriptionIndex;

    setState(() {
      status = statuse;
      action_status = actionstatus;
      presIndex = index;
    });
    print("i got here =======> $action_status");
    if (status == 'edit' && action_status == 'populate') {
      drugnameController.value =
          TextEditingValue(text: selectedPrescription['drug_name']);
      _selectedAnimal = selectedPrescription['drug_name'];
      phoneController.text = selectedPrescription['patient']['phone'];
      nameController.text = selectedPrescription['patient']['name'];
      fnameController.text = selectedPrescription['patient']['fathername'];
      weightController.text = selectedPrescription['patient']['weight'];
      ageController.text = selectedPrescription['patient']['age'];
      strengthController.text = selectedPrescription['strength'];
      unitController.text = selectedPrescription['unit'];
      routeController.text = selectedPrescription['route'];
      everyController.text = selectedPrescription['frequency'];
      forController.text = selectedPrescription['takein'];
      ampuleController.text = selectedPrescription['ampule'];
    }
  }

  void setFromFavorites(List<dynamic> fav) async {
    User user = await UserPreferences().getUser();
    var profession = "${user.profession} ${user.name} ${user.fathername}";
    for (var i = 0; i < fav.length; i++) {
      final Map<String, dynamic> precriptionData = {
        'drug_name': fav[i]['drug_name'],
        "strength": fav[i]['strength'],
        "unit": fav[i]['unit'],
        "route": fav[i]['route'],
        "takein": fav[i]['takein'],
        "frequency": fav[i]['frequency'],
        "drug": "",
        "professional": profession,
        "material_name": "",
        "size": "",
        "type": fav[i]['type'],
        "ampule": "",
        "patient": {
          "name": "",
          "age": "",
          "fathername": "",
          "grandfathername": "kebede",
          "phone": "",
          "sex": "",
          "weight": "",
          "dx": {
            "diagnosis": "",
          },
          "hx": {"cc": "", "hpi": ""},
          "px": {
            "abd": "",
            "bp": "",
            "cvs": "",
            "ga": "",
            "heent": "",
            "lgs": "",
            "pr": "",
            "rr": "",
            "rs": "",
            "temp": "",
            "gus": "",
            "msk": "",
            "ints": "",
            "cns": "",
            "general_apearnce": ""
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
      finaPrescription.add(precriptionData);
    }
  }

  @override
  Widget build(BuildContext context) {
    drugs = Provider.of<DrugProvider>(context).drugs;
    var patientProvider = Provider.of<PatientProvider>(context);
    return Form(
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Container(
                color: widget.color,
                child: Column(
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
                              onSaved: (value) {
                                setState(() {
                                  patient.phone = value;
                                });
                              },
                              onChanged: (String val) async {
                                if (val.length > 9) {
                                  var res = await patientProvider
                                      .getPatient(val);
                                  if (res != null) {
                                    setState(() {
                                      ageController.text = res['age'];
                                      _chosenValue = res['sex'];
                                      nameController.text = res['name'];
                                      fnameController.text =
                                          res['fathername'];
                                      weightController.text = res['weight'];
                                    });
                                  }
                                  setState(() {
                                    patient.phone = val;
                                  });
                                }
                              },
                              decoration: InputDecoration(
                                  suffix: patientProvider.fetchStatus ==
                                          Status.Fetching
                                      ? Container(
                                          height: 20.0,
                                          width: 20.0,
                                          child: CircularProgressIndicator())
                                      : null,
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
                        widget.type == 'instrument'
                            ? _instrumentForm()
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 290,
                                      height: 40,
                                      child: Autocomplete(
                                        optionsBuilder:
                                            (TextEditingValue value) {
                                          // When the field is empty
                                          if (value.text.isEmpty) {
                                            return [];
                                          }

                                          // The logic to find out which ones should appear
                                          return drugs.where((drug) {
                                            return drug['name']
                                                .toLowerCase()
                                                .contains(
                                                    value.text.toLowerCase());
                                          });
                                        },
                                        onSelected: (value) {
                                          strengthController.text =
                                              value['strength'];
                                          unitController.text = value['unit'];
                                          routeController.text = value['route'];
                                          setState(() {
                                            prescription.drug =
                                                value['id'].toString();
                                            _selectedAnimal = value['name'];
                                          });
                                        },
                                        displayStringForOption: (option) =>
                                            option['name'],
                                        fieldViewBuilder: (BuildContext context,
                                            TextEditingController
                                                fieldTextEditingController,
                                            FocusNode fieldFocusNode,
                                            VoidCallback onFieldSubmitted) {
                                          return Container(
                                            height: textHeight,
                                            child: TextFormField(
                                              controller:
                                                  fieldTextEditingController,
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
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 10.0),
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
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
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
                  ],
                ),
              ),
              Center(
                child: MaterialButton(
                  onPressed: () async {
                    _formKey.currentState.save();
                    if (forController.text == "" &&
                        everyController.text == "" &&
                        ampuleController.text == "" &&
                        widget.type == "general") {
                      Flushbar(
                        title: 'Error',
                        message:
                            'You got provide at least ampule or frequency(take in)',
                        duration: Duration(seconds: 10),
                      ).show(context);
                    } else {
                      if (_formKey.currentState.validate()) {
                        var diag_list = diagnosis.diagnosis_list != null
                            ? diagnosis.diagnosis_list
                                .where((element) => element != "")
                                .toList()
                            : [];
                        User user = await UserPreferences().getUser();
                        var profession =
                            "${user.profession} ${user.name} ${user.fathername}";

                        print("statusstatusstatus ===> ${status}");
                        if (status == 'add') {
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
                            "material_name": materialController.text,
                            "size": sizeController.text,
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
                                "diagnosis": diag_list.length != 0
                                    ? diag_list.join(",")
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
                          setState(() {
                            finaPrescription.add(precriptionData);
                          });
                        } else {
                          setState(() {
                            status = 'add';
                            action_status = 'manipulate';
                            finaPrescription[presIndex]['drug_name'] =
                                _selectedAnimal;
                            finaPrescription[presIndex]["strength"] =
                                strengthController.text;
                            finaPrescription[presIndex]["unit"] =
                                unitController.text;
                            finaPrescription[presIndex]['route'] =
                                routeController.text;
                            finaPrescription[presIndex]['takein'] =
                                forController.text;
                            finaPrescription[presIndex]['frequency'] =
                                everyController.text;
                            finaPrescription[presIndex]['ampule'] =
                                ampuleController.text;
                            finaPrescription[presIndex]["drug"] =
                                prescription.drug;
                            finaPrescription[presIndex]["type"] = widget.type;

                            finaPrescription[presIndex]['patient']['name'] =
                                patient.name;
                            finaPrescription[presIndex]["patient"]['age'] =
                                ageController.text;
                            finaPrescription[presIndex]["patient"]
                                ['fathername'] = fnameController.text;
                            finaPrescription[presIndex]['patient']
                                ['grandfathername'] = 'kebede';
                            finaPrescription[presIndex]['patient']['phone'] =
                                phoneController.text;
                            finaPrescription[presIndex]['patient']['sex'] =
                                _chosenValue;
                            finaPrescription[presIndex]["patient"]['weight'] =
                                weightController.text;
                            finaPrescription[presIndex]["patient"]['dx']
                                    ['diagnosis'] =
                                diagnosis.diagnosis_list != null
                                    ? diagnosis.diagnosis_list.join(",")
                                    : "";
                            finaPrescription[presIndex]["patient"]['hx']['cc'] =
                                history.cc;
                            finaPrescription[presIndex]["patient"]['hx']
                                ['hpi'] = history.hpi;
                            finaPrescription[presIndex]["patient"]['px']
                                ['abd'] = physical.abd;
                            finaPrescription[presIndex]["patient"]['px']
                                ['cvs'] = physical.cvs;
                            finaPrescription[presIndex]["patient"]['px']['ga'] =
                                physical.ga;
                            finaPrescription[presIndex]["patient"]['px']['bp'] =
                                physical.bp;
                            finaPrescription[presIndex]["patient"]['px']
                                ['heent'] = physical.heent;
                            finaPrescription[presIndex]["patient"]['px']
                                ['lgs'] = physical.lgs;
                            finaPrescription[presIndex]["patient"]['px']['pr'] =
                                physical.pr;
                            finaPrescription[presIndex]["patient"]['px']['rr'] =
                                physical.rr;
                            finaPrescription[presIndex]["patient"]['px']['rs'] =
                                physical.rs;
                            finaPrescription[presIndex]["patient"]['px']
                                ['temp'] = physical.temp;
                            finaPrescription[presIndex]["patient"]['px']
                                    ['general_apearance'] =
                                physical.general_apearance;
                            finaPrescription[presIndex]["patient"]['px']
                                ['ints'] = physical.ints;
                            finaPrescription[presIndex]["patient"]['px']
                                ['cns'] = physical.cns;
                            finaPrescription[presIndex]["patient"]['px']
                                ['msk'] = physical.msk;
                            finaPrescription[presIndex]["patient"]['px']
                                ['gus'] = physical.gus;

                            finaPrescription[presIndex]["patient"]['ix']
                                ['microbiology'] = ix.microbiology;
                            finaPrescription[presIndex]["patient"]['ix']
                                ['pathologyindex'] = ix.pathologyindex;
                            finaPrescription[presIndex]["patient"]['ix']
                                ['radiologyindex'] = ix.radiologyindex;
                            finaPrescription[presIndex]["patient"]['ix']
                                ['chemistry'] = chemistry.toJson();

                            finaPrescription[presIndex]["patient"]['ix']
                                ['hemathology'] = hematology.toJson();
                            finaPrescription[presIndex]["patient"]['ix']
                                ['endocrinology'] = endocrinology.toJson();
                            finaPrescription[presIndex]["patient"]['ix']
                                ['serology'] = serology.toJson();
                            finaPrescription[presIndex]["patient"]['ix']
                                ['urine'] = urine.toJson();
                          });
                        }
                        widget.setPrescription(finaPrescription);
                        _formKey.currentState.reset();
                        drugnameController.text = "";
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
            ],
          ),
        ));
  }

  Widget _instrumentForm() {
    return Column(
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
    );
  }
}
