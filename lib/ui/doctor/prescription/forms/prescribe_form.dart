import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hepius/constants.dart';
import 'package:hepius/models/drug.dart';
import 'package:hepius/models/hx.dart';
import 'package:hepius/models/patient.dart';
import 'package:hepius/models/prescription.dart';
import 'package:hepius/models/user.dart';
import 'package:hepius/providers/drug_provider.dart';
import 'package:hepius/providers/patient_provider.dart';
import 'package:hepius/providers/prescription_provider.dart';
import 'package:hepius/util/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phone_number/phone_number.dart';

// ignore: must_be_immutable
class PrescribeForm extends StatefulWidget {
  final Function setPrescription;
  final Function setPatient;
  final Function setFav;
  final List<dynamic> initialPrescription;
  final String type;
  final Color color;
  var from;
  PrescribeForm(
      {this.setPrescription,
      this.setFav,
      this.type,
      this.color,
      this.from,
      this.initialPrescription,
      this.setPatient});
  @override
  _PrescribeFormState createState() => _PrescribeFormState();
}

class _PrescribeFormState extends State<PrescribeForm> {
  bool isValidPhoneNumber = false;
  String status = 'add';
  var action_status = 'populate';
  String _chosenValue = "Male";
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
  var diagnosisController = new TextEditingController();
  var addressController = new TextEditingController();
  var routeController = new TextEditingController();
  var remarkController = new TextEditingController();
  var favoriteController = new TextEditingController();
  var materialController = new TextEditingController();
  var sizeController = new TextEditingController();
  var drugnameController = new TextEditingController();
  var materialNameController = new TextEditingController();

  List<dynamic> finaPrescription = [];
  List<dynamic> finaPatient = [];
  List<dynamic> drugs;

  String _selectedDrug = "";

  final TextEditingController _controller = new TextEditingController();
  int presIndex = 0;
  bool isAmpule = true;
  bool isEvery = true;
  bool ampule = true;
  var _currentSelectedValue;
  bool rememberMe = false;
  bool isPatient = false;
  bool showPatient = false;

  var from = "";
  List<dynamic> generalDrugs = [];
  List<dynamic> instruments = [];
  List<String> sizes = [];

  var _labelController = "Y";
  var _forController = "D";
  String _countryCode;

  var amountController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Provider.of<PrescriptionProvider>(context).resetStatus();

    getGeneralDrugs();
    getInstruments();
    from = widget.from;
    if (from == "favorites") {
      setState(() {
        isPatient = true;
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (rememberMe != Provider.of<PrescriptionProvider>(context).isFavourite)
      Provider.of<PrescriptionProvider>(context).isFavourite = false;
    super.didChangeDependencies();
    if (from == "favorites" && status != "edit") {
      List<dynamic> favorites =
          Provider.of<PrescriptionProvider>(context).prescription;
      setFromFavorites(favorites);
      Future.delayed(Duration.zero, () async {
        widget.setPrescription(finaPrescription);
      });
      setState(() {
        from = "null";
      });
    }
  }

  @override
  void didUpdateWidget(covariant PrescribeForm oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  void getGeneralDrugs() {
    PrescriptionProvider().getGeneralDrugs().then((value) {
      setState(() {
        generalDrugs = value;
      });
    });
  }

  void getInstruments() {
    PrescriptionProvider().getInstruments().then((value) {
      setState(() {
        instruments = value;
      });
    });
  }

  void setFromFavorites(List<dynamic> fav) async {
    User user = await UserPreferences().getUser();
    var profession = "${user.profession} ${user.name} ${user.fathername}";
    // setFormFromFav(fav[0]);
    for (var i = 0; i < fav.length; i++) {
      final Map<String, dynamic> precriptionData = {
        'drug_name': fav[i]['drug_name'],
        "strength": fav[i]['strength'],
        "unit": fav[i]['unit'],
        "route": fav[i]['route'],
        "takein": fav[i]['takein'],
        "frequency": fav[i]['frequency'],
        "drug": fav[i]['drug'],
        "professional": profession,
        "material_name": fav[i]['material_name'],
        "size": fav[i]['size'],
        "amount": fav[i]['amount'],
        "type": fav[i]['type'],
        "ampule": fav[i]['ampule'],
        "dx": {
          "diagnosis": "",
        },
      };

      finaPrescription.add(precriptionData);
    }
  }

  Widget _textRoute() {
    var routes = [
      "PO",
      "IV",
      "IM",
      "PR",
      "SC",
      "PV",
      "SL",
      "Topical",
      "Nasal",
      "Articular",
      "Inhale",
      "Otic",
      "Occular"
    ];
    return Container(
      height: 40.0,
      width: width(context) * 0.3,
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: Container(
                  width: 80.0,
                  child: new TextField(
                    controller: routeController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      border: OutlineInputBorder(),
                      hintText: 'Route',
                      hintStyle: TextStyle(fontSize: 15.0),
                      suffixIcon: Container(
                        width: 10.0,
                        margin: const EdgeInsets.only(left: 5.0),
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            routeController.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return routes
                                .map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget _textSizes() {
    return Container(
      height: 40.0,
      width: width(context) * 0.3,
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: Container(
                  width: 80.0,
                  child: new TextField(
                    controller: sizeController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      border: OutlineInputBorder(),
                      hintText: 'Size',
                      hintStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15.0),
                      suffixIcon: Container(
                        width: 10.0,
                        margin: const EdgeInsets.only(left: 5.0),
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            sizeController.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return sizes
                                .map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget _textEvery() {
    var frequency = ["Qd", "BID", "TID", "QID", "PRN"];
    return Container(
      height: 40.0,
      margin: EdgeInsets.only(left: 5),
      width: width(context) * 0.3,
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: Container(
                  width: 100.0,
                  child: new TextField(
                    controller: everyController,
                    onChanged: (val) {
                      prescription.frequency = val;
                      if (val.isNotEmpty) {
                        setState(() {
                          isAmpule = false;
                        });
                      }
                      if (val.isEmpty) {
                        setState(() {
                          isAmpule = true;
                        });
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      border: OutlineInputBorder(),
                      hintText: 'Every',
                      enabled: isEvery,
                      hintStyle: TextStyle(
                          color: isEvery ? Colors.redAccent : Colors.grey,
                          fontSize: 15.0),
                      suffixIcon: Container(
                        width: 8.0,
                        margin: const EdgeInsets.only(left: 5.0),
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            everyController.text = value;
                            prescription.frequency = value;
                            if (value.isNotEmpty) {
                              setState(() {
                                isAmpule = false;
                              });
                            }
                            if (value.isEmpty) {
                              setState(() {
                                isAmpule = true;
                              });
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            return frequency
                                .map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  Widget _textUnit() {
    var frequency = ["Mg", "Ml", "Gm", "L", "IU", "Tab", "Sachet"];
    return Container(
      height: 40.0,
      width: width(context) * 0.25,
      child: new Row(
        children: <Widget>[
          new Expanded(
              child: Container(
                  width: 80.0,
                  child: new TextField(
                    controller: unitController,
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      border: OutlineInputBorder(),
                      hintText: 'Unit',
                      hintStyle: TextStyle(fontSize: 15.0),
                      suffixIcon: Container(
                        width: 10.0,
                        margin: const EdgeInsets.only(left: 5.0),
                        child: PopupMenuButton<String>(
                          icon: const Icon(Icons.arrow_drop_down),
                          onSelected: (String value) {
                            unitController.text = value;
                          },
                          itemBuilder: (BuildContext context) {
                            return frequency
                                .map<PopupMenuItem<String>>((String value) {
                              return new PopupMenuItem(
                                  child: new Text(value), value: value);
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    drugs = Provider.of<DrugProvider>(context).drugs;
    var pres = Provider.of<PrescriptionProvider>(context);
    var patientProvider = Provider.of<PatientProvider>(context);
    final professionField = DropdownButtonFormField(
      decoration: InputDecoration(contentPadding: EdgeInsets.all(0.0)),
      icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
      value: _labelController,
      items: ["Y", "M", "D"]
          .map((label) => DropdownMenuItem(
                child: Text(label.toString()),
                value: label,
              ))
          .toList(),
      hint: Text(''),
      onChanged: (value) {
        widget.setPatient('ageLabel', value);
        setState(() {
          _labelController = value;
        });
      },
    );
    final forField = DropdownButtonFormField(
      decoration: InputDecoration(contentPadding: EdgeInsets.all(0.0)),
      icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
      value: _forController,
      items: ["D", "W", "M"]
          .map((label) => DropdownMenuItem(
                child: Text(label.toString()),
                value: label,
              ))
          .toList(),
      hint: Text(''),
      onChanged: (value) {
        setState(() {
          _forController = value;
        });
      },
    );
    return Container(
      height: 650,
      child: Column(
        children: [
          Form(
              // autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: widget.color.withOpacity(0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: width(context) * 0.3,
                              child: CheckboxListTile(
                                title: Text(
                                  "Favourite",
                                  style: TextStyle(fontSize: 12),
                                ),
                                value: rememberMe,
                                onChanged: (newValue) {
                                  setState(() {
                                    rememberMe = newValue;
                                  });
                                  widget.setFav(newValue);
                                },
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                //  <-- leading Checkbox
                                contentPadding: EdgeInsets.all(0.0),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: !rememberMe
                                      ? () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                              shape: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 5,
                                              child: Container(
                                                width: width(context) * 0.8,
                                                height: height(context) * 0.4,
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          diagnosisController,
                                                      enabled: !rememberMe,
                                                      onChanged: (val) {
                                                        setState(() {
                                                          prescription
                                                              .diagnosis = val;
                                                          widget.setPatient(
                                                              "diagnosis", val);
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 1.0),
                                                        ),
                                                        hintText:
                                                            'DX/Diagnosis',
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Center(
                                                        child: Container(
                                                          width:
                                                              width(context) *
                                                                  0.2375,
                                                          height: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xff07febb),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  4.0),
                                                            ),
                                                          ),
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Center(
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Text(
                                                                    'done',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      : () {},
                                  child: Container(
                                    width: width(context) * 0.15,
                                    height: 40,
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      boxShadow: [buttonShadow],
                                      color: diagnosisController.text.isEmpty
                                          ? Colors.white
                                          : Colors.green,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'DX',
                                        overflow: TextOverflow.clip,
                                        textScaleFactor: 0.775,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                  onTap: !rememberMe
                                      ? () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => Dialog(
                                              shape: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              elevation: 5,
                                              child: Container(
                                                width: width(context) * 0.8,
                                                height: height(context) * 0.4,
                                                padding: EdgeInsets.all(10),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextFormField(
                                                      controller:
                                                          addressController,
                                                      enabled: !rememberMe,
                                                      onChanged: (val) {
                                                        widget.setPatient(
                                                            'address', val);
                                                        // setState(() {
                                                        //   prescription.ampule =
                                                        //       val;
                                                        // });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Colors
                                                                      .green,
                                                                  width: 1.0),
                                                        ),
                                                        hintText: 'MRN',
                                                      ),
                                                    ),
                                                    SizedBox(height: 10),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Center(
                                                        child: Container(
                                                          width:
                                                              width(context) *
                                                                  0.2375,
                                                          height: 35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Color(
                                                                0xff07febb),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  4.0),
                                                            ),
                                                          ),
                                                          child: Material(
                                                            color: Colors
                                                                .transparent,
                                                            child: InkWell(
                                                              onTap: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Center(
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              4.0),
                                                                  child: Text(
                                                                    'done',
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        }
                                      : () {},
                                  child: Container(
                                    width: width(context) * 0.15,
                                    height: 40,
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      boxShadow: [buttonShadow],
                                      color: addressController.text.isEmpty
                                          ? Colors.white
                                          : Colors.green,
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'MRN',
                                        overflow: TextOverflow.clip,
                                        textScaleFactor: 0.775,
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 5),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: width(context) * 0.575,
                                height: 55.0,
                                child: IntlPhoneField(
                                  countries: ["ET"],
                                  onTap: () {},
                                  initialCountryCode: 'ET',
                                  showDropdownIcon: false,
                                  // Milkessa: Fixed phone input field formatting
                                  textAlign: TextAlign.start,
                                  controller: phoneController,
                                  enabled: !rememberMe || status == "edit",
                                  keyboardType: TextInputType.phone,
                                  onSaved: (value) {
                                    setState(() {
                                      patient.phone = "+251${value.number}";
                                    });
                                  },
                                  onChanged: (value) async {
                                    var phone = "+251${value.number}";
                                    PhoneNumberUtil plugin = PhoneNumberUtil();
                                    RegionInfo region =
                                        RegionInfo(code: 'ET', prefix: 251);
                                    if (value.number.length == 9) {
                                      bool isValid = await plugin.validate(
                                          phone, region.code);
                                      if (isValid) {
                                        setState(() {
                                          isValidPhoneNumber = true;
                                        });
                                      }

                                      widget.setPatient('phone', phone);
                                      var res = await patientProvider
                                          .getPatient(phone);
                                      if (res != null) {
                                        setState(() {
                                          ageController.text = res['age'];
                                          widget.setPatient('age', res['age']);
                                          widget.setPatient('sex', res['sex']);
                                          _chosenValue = res['sex'];
                                          nameController.text = res['name'];
                                          widget.setPatient(
                                              'name', res['name']);
                                          fnameController.text =
                                              res['fathername'];
                                          widget.setPatient(
                                              'fatherName', res['fathername']);
                                          phoneController.text =
                                              phone.substring(4);
                                        });
                                      }
                                    }
                                    widget.setPatient('phone', phone);
                                    setState(() {
                                      patient.phone = phone;
                                    });
                                  },

                                  decoration: InputDecoration(
                                      labelText: 'Phone Number',
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(),
                                      ),
                                      suffix: patientProvider.fetchStatus ==
                                              Status.Fetching
                                          ? Container(
                                              height: 20.0,
                                              width: 20.0,
                                              child:
                                                  CircularProgressIndicator())
                                          : null,
                                      hintStyle: TextStyle(
                                          color: !rememberMe
                                              ? Colors.redAccent
                                              : Colors.black26)),
                                ),
                              ),
                            ),
                            Container(
                              width: width(context) * 0.15,
                              height: 40,
                              child: Row(
                                children: [
                                  Flexible(
                                      flex: 2,
                                      child: TextFormField(
                                        controller: ageController,
                                        keyboardType: TextInputType.number,
                                        enabled:
                                            !rememberMe || status == "edit",
                                        inputFormatters: <TextInputFormatter>[],
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.all(0.0),
                                            // border: OutlineInputBorder(),
                                            hintText: 'Age',
                                            hintStyle: TextStyle(
                                                color: Colors.black26)),
                                        onChanged: (String newValue) {
                                          patient.age = newValue;
                                          widget.setPatient('age', newValue);
                                        },
                                      )),
                                  Flexible(
                                    flex: 1,
                                    child: professionField,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Container(
                              width: width(context) * 0.15,
                              height: 40.0,
                              padding: const EdgeInsets.only(left: 5.0),
                              child: DropdownButton<String>(
                                // decoration:
                                //     InputDecoration(border: OutlineInputBorder()),
                                focusColor: Colors.blueAccent,
                                value: _chosenValue,
                                elevation: 5,
                                style: TextStyle(color: Colors.white),
                                iconEnabledColor: Colors.black,
                                isExpanded: true,
                                items: <String>[
                                  'Male',
                                  'Female',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value.substring(0, 1),
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  );
                                }).toList(),
                                hint: Text(
                                  "Sex",
                                  style: TextStyle(
                                      color: Colors.black26,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                onChanged: (String value) {
                                  widget.setPatient('sex', value);
                                  setState(() {
                                    _chosenValue = value;
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 0.0,
                            ),
                            Container(
                              width: width(context) * 0.325,
                              height: 40.0,
                              child: TextFormField(
                                controller: nameController,
                                enabled: !rememberMe || status == "edit",
                                onSaved: (value) => patient.name = value,
                                maxLines: 1,
                                onChanged: (val) {
                                  widget.setPatient('name', val);
                                  setState(() {
                                    patient.name = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    isDense: true,
                                    hintText: 'Name',
                                    hintStyle:
                                        TextStyle(color: Colors.black26)),
                              ),
                            ),
                            Container(
                              width: width(context) * 0.375,
                              height: 40.0,
                              child: TextFormField(
                                controller: fnameController,
                                enabled: !rememberMe || status == "edit",
                                onSaved: (value) => patient.fathername = value,
                                onChanged: (val) {
                                  widget.setPatient('fatherName', val);
                                  setState(() {
                                    patient.fathername = val;
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Father Name',
                                    hintStyle:
                                        TextStyle(color: Colors.black26)),
                              ),
                            ),
                            Container(
                              width: width(context) * 0.2,
                              height: 40.0,
                              decoration: BoxDecoration(
                                  // border: Border.all(
                                  //     color: Colors.green[400], width: 1.5),
                                  // borderRadius: BorderRadius.circular(10.0)
                                  ),
                              child: TextFormField(
                                controller: weightController,
                                enabled: !rememberMe || status == "edit",
                                onSaved: (value) => patient.weight = value,
                                onChanged: (val) {
                                  widget.setPatient('weight', val);
                                  setState(() {
                                    patient.weight = val;
                                  });
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.green[400],
                                            width: 1.5)),
                                    hintText: 'Kg'),
                              ),
                            ),
                            SizedBox(
                              width: 0.0,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            widget.type == 'instrument'
                                ? _instrumentForm()
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FutureBuilder<List<dynamic>>(
                                          future:
                                              Provider.of<DrugProvider>(context)
                                                  .getDrugsLocal(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return Center(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 5,
                                                    horizontal: 20,
                                                  ),
                                                  child: Text(
                                                    'Loading drug list...',
                                                    style: TextStyle(
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            } else {
                                              if (snapshot.data == null) {
                                                return Center(
                                                  child:
                                                      Text('No drug to show'),
                                                );
                                              }
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: width(context) * 0.95,
                                                  height: 60,
                                                  child: Autocomplete(
                                                    optionsBuilder:
                                                        (TextEditingValue
                                                            value) {
                                                      // When the field is empty
                                                      if (value.text.isEmpty) {
                                                        return [];
                                                      }

                                                      // The logic to find out which ones should appear
                                                      // Milkessa: implemented a search mechanism that is organized and alphabetical
                                                      List<dynamic> drugRes;
                                                      for (int i = 0;
                                                          i < 2;
                                                          i++) {
                                                        if (i == 0)
                                                          drugRes = snapshot
                                                              .data
                                                              .where((element) =>
                                                                  element['name']
                                                                      .startsWith(
                                                                          value
                                                                              .text))
                                                              .toList();
                                                        else
                                                          drugRes.addAll(snapshot
                                                              .data
                                                              .where((element) =>
                                                                  element['name']
                                                                      .contains(
                                                                          value
                                                                              .text) &
                                                                  !element[
                                                                          'name']
                                                                      .startsWith(
                                                                          value
                                                                              .text))
                                                              .toList());
                                                      }
                                                      return drugRes;
                                                    },
                                                    onSelected: (value) {
                                                      strengthController.text =
                                                          value['strength'];
                                                      unitController.text =
                                                          value['unit'];
                                                      routeController.text =
                                                          value['route'];
                                                      setState(() {
                                                        prescription.drug =
                                                            value['id']
                                                                .toString();
                                                        _selectedDrug =
                                                            value['name'];
                                                      });
                                                    },
                                                    displayStringForOption:
                                                        (option) =>
                                                            option['name'],
                                                    fieldViewBuilder: (BuildContext
                                                            context,
                                                        TextEditingController
                                                            fieldTextEditingController,
                                                        FocusNode
                                                            fieldFocusNode,
                                                        VoidCallback
                                                            onFieldSubmitted) {
                                                      drugnameController =
                                                          fieldTextEditingController;
                                                      return Container(
                                                        height: 60,
                                                        child: TextFormField(
                                                          controller:
                                                              fieldTextEditingController,
                                                          focusNode:
                                                              fieldFocusNode,
                                                          textCapitalization:
                                                              TextCapitalization
                                                                  .words,
                                                          decoration: InputDecoration(
                                                              border:
                                                                  OutlineInputBorder(),
                                                              isDense: true,
                                                              hintText:
                                                                  'Name of Drug',
                                                              hintStyle: TextStyle(
                                                                  color: _selectedDrug ==
                                                                          ""
                                                                      ? Colors
                                                                          .red
                                                                      : Colors
                                                                          .grey)),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                          }),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: width(context) * 0.3375,
                                            height: 40.0,
                                            child: TextFormField(
                                              controller: strengthController,
                                              onChanged: (val) {
                                                setState(() {
                                                  drug.strength = val;
                                                });
                                              },
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText: 'Strength',
                                                  hintStyle: TextStyle(
                                                      color: drug.strength !=
                                                              null
                                                          ? Colors.grey
                                                          : Colors.redAccent)),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          _textUnit(),
                                          SizedBox(
                                            width: 8.0,
                                          ),
                                          _textRoute()
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          _textEvery(),
                                          Container(
                                            width: width(context) * 0.25,
                                            height: 40,
                                            child: Row(
                                              children: [
                                                SizedBox(width: 5),
                                                Flexible(
                                                  flex: 2,
                                                  child: TextFormField(
                                                    controller: forController,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    onChanged: (val) {
                                                      setState(() {
                                                        prescription.takein =
                                                            val;
                                                      });
                                                      if (val.isNotEmpty) {
                                                        setState(() {
                                                          isAmpule = false;
                                                        });
                                                      }
                                                      if (val.isEmpty) {
                                                        setState(() {
                                                          isAmpule = true;
                                                        });
                                                      }
                                                    },
                                                    enabled: isEvery,
                                                    decoration: InputDecoration(
                                                        hintText: 'For',
                                                        hintStyle: TextStyle(
                                                            color: isEvery
                                                                ? Colors
                                                                    .redAccent
                                                                : Colors.grey)),
                                                  ),
                                                ),
                                                SizedBox(width: 5),
                                                Flexible(child: forField),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            'OR',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Container(
                                              width: width(context) * 0.3,
                                              height: 40,
                                              child: TextFormField(
                                                controller: ampuleController,
                                                onChanged: (val) {
                                                  setState(() {
                                                    prescription.ampule = val;
                                                  });
                                                  if (val.isNotEmpty) {
                                                    setState(() {
                                                      isEvery = false;
                                                      ampule = true;
                                                    });
                                                  }
                                                  if (val.isEmpty) {
                                                    setState(() {
                                                      isEvery = true;
                                                      ampule = false;
                                                    });
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText: 'Ampule',
                                                    enabled: isAmpule,
                                                    hintStyle: TextStyle(
                                                        color: isAmpule
                                                            ? Colors.redAccent
                                                            : Colors.grey)),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            margin: EdgeInsets.only(left: 2),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: TextFormField(
                              controller: remarkController,
                              enabled: !rememberMe ? true : false,
                              onChanged: (val) {
                                widget.setPatient('remark', val);
                              },
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
                  Center(
                    child: MaterialButton(
                      onPressed: () async {
                        _formKey.currentState.save();
                        if (_selectedDrug == "" &&
                            widget.type != 'instrument') {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "Drug is required",
                            ),
                          );
                        } else if (strengthController.text == "" &&
                            widget.type != 'instrument') {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "Strength is required",
                            ),
                          );
                        } else if (unitController.text == "" &&
                            widget.type != 'instrument') {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "Unit is required",
                            ),
                          );
                        } else if (routeController.text == "" &&
                            widget.type != "instrument") {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "Route is required",
                            ),
                          );
                        } else if (isEvery &&
                            (forController.text == "" ||
                                everyController.text == "") &&
                            widget.type != "instrument") {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message:
                                  "You got provide at least Frequency(Every) and For ",
                            ),
                          );
                        } else if (!isEvery &&
                            ampuleController.text == "" &&
                            widget.type != "instrument") {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message: "You got provide at least Ampule",
                            ),
                          );
                        } else if (weightController.text != "" &&
                            (double.parse(weightController.text) < 1.5 ||
                                double.parse(weightController.text) > 135) &&
                            widget.type != "instrument") {
                          showTopSnackBar(
                            context,
                            CustomSnackBar.error(
                              message:
                                  "The weight value must be between 1.5 and 135 (Kg)",
                            ),
                          );
                        } else {
                          User user = await UserPreferences().getUser();
                          var profession =
                              "${user.profession} ${user.name} ${user.fathername}";
                          if (status == 'add') {
                            final Map<String, dynamic> patientData = {
                              "name": patient.name,
                              "age": ageController.text,
                              "age_label": _labelController,
                              "fathername": patient.fathername,
                              "grandfathername": "kebede",
                              "phone": patient.phone,
                              "sex": _chosenValue,
                              "weight": patient.weight,
                              "mrn": addressController.text,
                              "professionid": user.professionid
                            };
                            final Map<String, dynamic> precriptionData = {
                              'drug_name': _selectedDrug != null
                                  ? _selectedDrug
                                  : drug.name,
                              "strength": strengthController.text,
                              "unit": unitController.text,
                              "route": routeController.text,
                              "takein": prescription.takein != null
                                  ? widget.type != "instrument"
                                      ? prescription.takein +
                                          (_forController == 'D'
                                              ? ' Days'
                                              : _forController == 'W'
                                                  ? ' Weeks'
                                                  : ' Months')
                                      : ""
                                  : '',
                              "createdAt": new DateTime.now().toIso8601String(),
                              "frequency": prescription.frequency,
                              "drug": prescription.drug,
                              "professional": profession,
                              "material_name": materialController.text,
                              "size": sizeController.text,
                              "amount": amountController.text,
                              "type": widget.type,
                              "ampule": ampuleController.text,
                              "remark": remarkController.text
                            };
                            if (finaPatient.length == 0) {
                              setState(() {
                                finaPatient.add(patientData);
                              });
                            }
                            setState(() {
                              finaPrescription.add(precriptionData);
                              isAmpule = true;
                              isEvery = true;
                              // ampule = false;
                            });
                          } else if (status == 'edit') {
                            Provider.of<PrescriptionProvider>(context,
                                    listen: false)
                                .resetStatus();

                            setState(() {
                              status = 'add';
                              finaPrescription[presIndex]['drug_name'] =
                                  _selectedDrug;
                              finaPrescription[presIndex]["strength"] =
                                  strengthController.text;
                              finaPrescription[presIndex]["unit"] =
                                  unitController.text;
                              finaPrescription[presIndex]['route'] =
                                  routeController.text;
                              finaPrescription[presIndex]['takein'] =
                                  forController.text +
                                      (_forController == 'D'
                                          ? ' Days'
                                          : _forController == 'W'
                                              ? ' Weeks'
                                              : ' Months');
                              finaPrescription[presIndex]['frequency'] =
                                  everyController.text;
                              finaPrescription[presIndex]['ampule'] =
                                  ampuleController.text;
                              finaPrescription[presIndex]["drug"] =
                                  prescription.drug;
                              finaPrescription[presIndex]["remark"] =
                                  remarkController.text;
                              finaPrescription[presIndex]["type"] = widget.type;
                              finaPrescription[presIndex]['material_name'] =
                                  materialController.text;
                              finaPrescription[presIndex]['size'] =
                                  sizeController.text;
                              finaPrescription[presIndex]['amount'] =
                                  amountController.text;
                              //update the patient info

                              if (finaPatient.length == 0) {
                                final Map<String, dynamic> patientData = {
                                  "name": patient.name,
                                  "age": ageController.text,
                                  "fathername": fnameController.text,
                                  "grandfathername": "kebede",
                                  "phone": phoneController.text,
                                  "sex": _chosenValue,
                                  "weight": weightController.text,
                                  "mrn": addressController.text,
                                  "professionid": user.professionid
                                };
                                finaPatient.add(patientData);
                              } else {
                                finaPatient[0]['name'] = patient.name;
                                finaPatient[0]['age'] = ageController.text;
                                finaPatient[0]['fathername'] =
                                    fnameController.text;
                                finaPatient[0]['grandfathername'] = 'kebede';
                                finaPatient[0]['phone'] = phoneController.text;
                                finaPatient[0]['sex'] = _chosenValue;
                                finaPatient[0]['weight'] =
                                    weightController.text;
                                finaPatient[0]['mrn'] = addressController.text;
                                finaPatient[0]['professionid'] =
                                    user.professionid;
                                finaPatient[0]['dx']['diagnosis'] =
                                    diagnosisController.text;
                              }
                            });
                          }
                          widget.setPrescription(finaPrescription);
                          _formKey.currentState.reset();
                          drugnameController.text = "";
                          strengthController.text = '';
                          unitController.text = '';
                          routeController.text = '';
                          everyController.text = '';
                          forController.text = '';
                          // diagnosisController.text = "";
                          // addressController.text = "";
                          // remarkController.text = "";
                          materialController.text = "";
                          sizeController.text = "";
                          amountController.text = "";
                          _selectedDrug = "";
                          ampuleController.text = "";
                        }
                      },
                      child: Container(
                        width: width(context) * 0.33,
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Center(
                            child: Text(
                          status == 'add' ? 'ADD' : 'Done Editing',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.green[400],
                          ),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              )),
          prescriptionPaper(prescription, widget.type)
        ],
      ),
    );
  }

  Widget _instrumentForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            width: MediaQuery.of(context).size.width - 20,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: width(context) * 0.7,
                height: 40,
                child: Autocomplete(
                  optionsBuilder: (TextEditingValue value) {
                    // When the field is empty
                    if (value.text.isEmpty) {
                      return [];
                    }

                    // The logic to find out which ones should appear
                    // Milkessa: implemented a search mechanism that is organized and alphabetical
                    List<dynamic> instrumentRes;
                    for (int i = 0; i < 2; i++) {
                      if (i == 0)
                        instrumentRes = instruments
                            .where((element) =>
                                element['material_name'].startsWith(value.text))
                            .toList();
                      else
                        instrumentRes.addAll(instruments
                            .where((element) =>
                                element['material_name'].contains(value.text) &
                                !element['material_name']
                                    .startsWith(value.text))
                            .toList());
                    }
                    return instrumentRes;
                  },
                  onSelected: (value) {
                    setState(() {
                      prescription.drug = value['id'].toString();
                      _selectedDrug = value['material_name'];
                      sizes = value['size'].split(',');
                    });
                  },
                  displayStringForOption: (option) => option['material_name'],
                  fieldViewBuilder: (BuildContext context,
                      TextEditingController fieldTextEditingController,
                      FocusNode fieldFocusNode,
                      VoidCallback onFieldSubmitted) {
                    materialController = fieldTextEditingController;
                    return Container(
                      height: 50.0,
                      child: TextFormField(
                        controller: materialController,
                        focusNode: fieldFocusNode,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            isDense: true,
                            hintText: 'Name of Instrument',
                            hintStyle: TextStyle(color: Colors.redAccent)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
        Row(
          children: [
            Padding(padding: const EdgeInsets.all(8.0), child: _textSizes()),
            Container(
              width: 80,
              height: 40,
              child: TextField(
                controller: amountController,
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

  Widget prescriptionPaper(prescription, pretype) {
    return Expanded(
      flex: 5,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            color: Colors.grey[100]),
        child: ListView(
          children: widget.initialPrescription.map<Widget>((pres) {
            return Row(
              children: [
                Expanded(
                  child: pres['type'] == "general"
                      ? pres['ampule'] != "" && pres['ampule'] != null
                          ? Text(
                              '${widget.initialPrescription.indexOf(pres) + 1}. ${pres['drug_name'] != null ? pres['drug_name'] : ""} ${pres['strength'] != null ? pres['strength'] : ""}${pres['unit'] != null ? pres['unit'] : ""} '
                              ' ${pres['route'] != null ? pres['route'] : ""} #${pres['ampule']} Amp')
                          : Text(
                              '${widget.initialPrescription.indexOf(pres) + 1}. ${pres['drug_name'] != null ? pres['drug_name'] : ""} ${pres['strength'] != null ? pres['strength'] : ""}${pres['unit'] != null ? pres['unit'] : ""} '
                              ' ${pres['route'] != null ? pres['route'] : ""} Every ${pres['frequency'] != null ? pres['frequency'] : ""} For ${pres['takein'] != null ? pres['takein'] : ""}')
                      : Text(
                          '${widget.initialPrescription.indexOf(pres) + 1}. ${pres['material_name'] != null ? pres['material_name'] : ""} ${pres['size'] != null ? pres['size'] : ""} ${pres['amount'] != null ? '#${pres['amount']}' : ""}'),
                ),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            presIndex =
                                widget.initialPrescription.indexOf(pres);
                            remarkController.text = pres['remark'];
                            if (pres['type'] == "general" &&
                                widget.type == "general") {
                              drugnameController.value =
                                  TextEditingValue(text: pres['drug_name']);
                              _selectedDrug = pres['drug_name'];
                              strengthController.text = pres['strength'];
                              unitController.text = pres['unit'];
                              routeController.text = pres['route'];
                              if (pres['ampule'] != "") {
                                isEvery = false;
                                isAmpule = true;
                                everyController.text = "";
                                forController.text = "";
                                ampuleController.text = pres['ampule'];
                              } else if (pres["ampule"] == "") {
                                isEvery = true;
                                isAmpule = false;
                                everyController.text = pres['frequency'];
                                forController.text = pres['takein'] != ""
                                    ? pres['takein'].split(" ")[0]
                                    : "";
                                ampuleController.text = "";
                              }
                              // diagnosisController.text =
                              //     pres['dx']['diagnosis'];
                              status = 'edit';
                              action_status = 'populate';
                            } else if (pres['type'] == "instrument" &&
                                widget.type == "instrument") {
                              materialController.text = pres['material_name'];
                              sizeController.text = pres['size'];
                              amountController.text = pres['amount'];
                              status = 'edit';
                              action_status = 'populate';
                            }
                          });
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          var index = widget.initialPrescription.indexOf(pres);
                          setState(() {
                            widget.initialPrescription.removeAt(index);
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
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
