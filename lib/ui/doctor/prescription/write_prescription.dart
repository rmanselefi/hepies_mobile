import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/models/dx.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/models/hx.dart';
import 'package:hepies/models/px.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/doctor/favorites/favorites.dart';
import 'package:hepies/ui/doctor/guidelines/guidelines.dart';
import 'package:hepies/ui/doctor/medicalrecords/add_history.dart';
import 'package:hepies/ui/doctor/prescription/forms/prescribe_form.dart';
import 'package:hepies/ui/doctor/prescription/papers/prescription_paper.dart';
import 'package:hepies/ui/doctor/prescription/papers/psycho_narco_paper.dart';
import 'package:hepies/ui/doctor/prescription/prescription_types/general_prescription.dart';
import 'package:hepies/ui/doctor/prescription/prescription_types/instrument_prescription.dart';
import 'package:hepies/ui/doctor/prescription/prescription_types/narcotic_prescription.dart';
import 'package:hepies/ui/doctor/prescription/prescription_types/psychotropic_prescription.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:provider/provider.dart';

enum type { general, narcotic, psychotropic, instrument }

class WritePrescription extends StatefulWidget {
  final History history;
  final Diagnosis diagnosis;
  final Physical physical;
  final String type;
  final String from;
  WritePrescription(
      {this.physical, this.diagnosis, this.history, this.type, this.from});
  @override
  _WritePrescriptionState createState() => _WritePrescriptionState();
}

class _WritePrescriptionState extends State<WritePrescription> {
  var pretype = "general";
  List<dynamic> prescription = [];
  List<dynamic> psycoPrescription = [];
  String phoneNumber = "";
  String age = "";
  String name = "";
  String fatherName = "";
  String sex = "";
  String weight = "";
  String isFit = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setIsFit();
    setState(() {
      pretype = widget.type != null ? widget.type : 'general';
    });
  }

  @override
  void didUpdateWidget(covariant WritePrescription oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  // @override
  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   super.didChangeDependencies();
  //   print("widget.from ===== > ${widget.from}");
  //   if (widget.from == "favorites") {
  //     List<dynamic> favorites =
  //         Provider.of<PrescriptionProvider>(context).prescription;
  //     prescription.clear();
  //     setFromFavorites(favorites);
  //   }
  // }

  void setIsFit() async {
    var user = await UserPreferences().getUser();
    setState(() {
      isFit = user.isFit;
    });
  }

  void setFromFavorites(List<dynamic> fav) {
    List<dynamic> favorites = [];
    for (var i = 0; i < fav.length; i++) {
      final Map<String, dynamic> precriptionData = {
        'drug_name': fav[i]['drug_name'],
        "strength": fav[i]['strength'],
        "unit": fav[i]['unit'],
        "route": fav[i]['route'],
        "takein": fav[i]['takein'],
        "frequency": fav[i]['frequency'],
        "drug": "",
        "professional": "",
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
        }
      };
      favorites.add(precriptionData);
    }
    _setPrescription(favorites);
  }

  void _setPrescription(List<dynamic> pres) {
    setState(() {
      prescription = pres;
    });
  }

  void _setPsycoPrescription(List<dynamic> pres) {
    setState(() {
      psycoPrescription = pres;
    });
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("Sending your prescription ... Please wait")
    ],
  );

  @override
  Widget build(BuildContext context) {
    var prescProvider = Provider.of<PrescriptionProvider>(context);
    return Scaffold(
      body: ListView(
        children: [
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Guidelines()));
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
          Row(
            children: [
              SizedBox(
                width: 50.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    pretype = 'general';
                  });
                },
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 2),
                  ),
                  child: Center(
                      child: Text(
                    'General',
                    style: TextStyle(fontSize: 15.0),
                  )),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    pretype = 'instrument';
                  });
                },
                child: Container(
                  height: 30,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    border: Border.all(color: Colors.black45, width: 2),
                  ),
                  child: Center(
                      child: Text('Instruments',
                          style: TextStyle(fontSize: 15.0))),
                ),
              ),
              SizedBox(
                width: 10.0,
              ),
              isFit == "true"
                  ? Builder(builder: (context) {
                      return Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                pretype = 'psychotropic';
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.redAccent[400],
                                border:
                                    Border.all(color: Colors.black45, width: 2),
                              ),
                              child: Center(
                                  child: Text(
                                'Psychotropic',
                                style: TextStyle(fontSize: 14.0),
                              )),
                            ),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                pretype = 'narcotic';
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 80,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                border:
                                    Border.all(color: Colors.black45, width: 2),
                              ),
                              child: Center(
                                  child: Text('Narcotic',
                                      style: TextStyle(fontSize: 15.0))),
                            ),
                          ),
                        ],
                      );
                    })
                  : Container(),
            ],
          ),
          Builder(builder: (context) {
            if (pretype == "general") {
              return PrescribeForm(
                  _setPrescription, 'general', Colors.white, widget.from);
            } else if (pretype == "instrument") {
              return PrescribeForm(
                  _setPrescription, 'instrument', Colors.white, widget.from);
            } else if (pretype == "narcotic") {
              return PrescribeForm(
                  _setPrescription, 'narcotic', Colors.white, widget.from);
            } else if (pretype == "psychotropic") {
              return PrescribeForm(
                  _setPrescription, 'psychotropic', Colors.white, widget.from);
            } else {
              return Container();
            }
          }),
          pretype == "general" || pretype == "instrument"
              ? PrescriptionPaper(prescription, pretype)
              : PsychoNarcoPaper(psycoPrescription),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 100,
                    height: 40,
                    margin: EdgeInsets.only(right: 20.0, top: 0.0),
                    decoration: BoxDecoration(
                        color: Color(0xff07febb),
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                        child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
              prescProvider.sentStatus == PrescriptionStatus.Sending
                  ? loading
                  : GestureDetector(
                      onTap: () async {


                        try {
                          if (pretype == "general" || pretype == "instrument") {
                            print("prescriptionprescription $prescription");
                            if (prescription.length != 0) {
                              for (var i = 0; i < prescription.length; i++) {
                                var phone = prescription[i]['patient']['phone'];
                                var name = prescription[i]['patient']['name'];
                                var age = prescription[i]['patient']['age'];
                                var sex = prescription[i]['patient']['sex'];
                                if (phone == "" ||
                                    phone == null ||
                                    sex == "" ||
                                    sex == null ||
                                    name == "" ||
                                    name == null ||
                                    age == "" ||
                                    age == null) {
                                  Flushbar(
                                    title: 'Error',
                                    message:
                                        'Please make sure all patient information is provided before sending prescription',
                                    duration: Duration(seconds: 10),
                                  ).show(context);
                                  return;
                                }
                              }
                              var res = await prescProvider
                                  .writePrescription(prescription);
                              if (res['status']) {
                                Flushbar(
                                  title: 'Sent',
                                  message:
                                      'Your prescriptions are sent succesfully',
                                  duration: Duration(seconds: 10),
                                ).show(context);
                              } else {
                                Flushbar(
                                  title: 'Error',
                                  message: 'Unable to send your prescriptions',
                                  duration: Duration(seconds: 10),
                                ).show(context);
                              }
                            } else {
                              Flushbar(
                                title: 'Error',
                                message:
                                    'Please fill at least one prescription.',
                                duration: Duration(seconds: 10),
                              ).show(context);
                            }
                          } else {
                            if (psycoPrescription.length != 0) {
                              var res = await prescProvider
                                  .writePrescription(psycoPrescription);
                              if (res['status']) {
                                Flushbar(
                                  title: 'Sent',
                                  message:
                                      'Your prescriptions are sent succesfully',
                                  duration: Duration(seconds: 10),
                                ).show(context);
                              } else {
                                Flushbar(
                                  title: 'Error',
                                  message: 'Unable to send your prescriptions',
                                  duration: Duration(seconds: 10),
                                ).show(context);
                              }
                            } else {
                              Flushbar(
                                title: 'Error',
                                message:
                                    'Please fill at least one prescription.',
                                duration: Duration(seconds: 10),
                              ).show(context);
                            }
                          }
                        } catch (e) {
                          print("object $e");
                        }
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Container(
                          width: 100,
                          height: 40,
                          margin: EdgeInsets.only(right: 20.0, top: 0.0),
                          decoration: BoxDecoration(
                              color: Color(0xff07febb),
                              border: Border.all(color: Colors.black45),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Center(
                              child: Text(
                            'Send',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
