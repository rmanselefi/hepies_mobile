import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/models/dx.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/models/hx.dart';
import 'package:hepies/models/px.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/doctor/calculator/calculator.dart';
import 'package:hepies/ui/doctor/favorites/favorites.dart';
import 'package:hepies/ui/doctor/guidelines/guidelines.dart';
import 'package:hepies/ui/doctor/medicalrecords/add_history.dart';
import 'package:hepies/ui/doctor/prescription/forms/prescribe_form.dart';
import 'package:hepies/ui/doctor/prescription/forms/prescribe_narco_form.dart';
import 'package:hepies/ui/doctor/prescription/papers/prescription_paper.dart';
import 'package:hepies/ui/doctor/prescription/papers/psycho_narco_paper.dart';
import 'package:hepies/ui/doctor/prescription/prescription_types/general_prescription.dart';
import 'package:hepies/ui/doctor/prescription/prescription_types/instrument_prescription.dart';
import 'package:hepies/ui/doctor/prescription/prescription_types/narcotic_prescription.dart';
import 'package:hepies/ui/doctor/prescription/prescription_types/psychotropic_prescription.dart';
import 'package:hepies/ui/welcome.dart';
import 'package:hepies/util/database_helper.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';

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
  List<dynamic> patient = [];
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

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("widget.from ===== > ${widget.from}");
    if (widget.from == "sent") {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "Your prescriptions are sent successfully",
        ),
      );
    }
  }

  void setIsFit() async {
    var user = await UserPreferences().getUser();
    setState(() {
      isFit = user.isFit;
    });
  }

  var favoriteController = new TextEditingController();

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
    // _setPrescription(favorites);
  }

  void _setPrescription(List<dynamic> pres, List<dynamic> pat) {
    setState(() {
      prescription = pres;
      patient = pat;
    });
  }

  void _setPsycoPrescription(List<dynamic> pres) {
    setState(() {
      psycoPrescription = pres;
    });
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator(), Text("Sending..")],
  );

  @override
  Widget build(BuildContext context) {
    var prescProvider = Provider.of<PrescriptionProvider>(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
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
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Calculator()));
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
          Row(
            children: [
              SizedBox(
                width: 20.0,
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(3),
                  child: MaterialButton(
                    padding: EdgeInsets.all(2),
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black45, width: 2),
                    ),
                    onPressed: () {
                      setState(() {
                        pretype = 'general';
                      });
                    },
                    child: Text(
                      'Normal',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(3),
                  child: MaterialButton(
                    padding: EdgeInsets.all(2),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black45, width: 2),
                    ),
                    onPressed: () {
                      setState(() {
                        pretype = 'instrument';
                      });
                    },
                    child: Text(
                      'Instruments',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
              isFit == "true"
                  ? Builder(builder: (context) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.all(3),
                              child: MaterialButton(
                                padding: EdgeInsets.all(2),
                                color: Colors.redAccent[400],
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black45, width: 2),
                                ),
                                onPressed: () {
                                  setState(() {
                                    pretype = 'psychotropic';
                                  });
                                },
                                child: Text(
                                  'Psychotropic',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.all(3),
                              child: MaterialButton(
                                padding: EdgeInsets.all(2),
                                color: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black45, width: 2),
                                ),
                                onPressed: () {
                                  setState(() {
                                    pretype = 'narcotic';
                                  });
                                },
                                child: Text(
                                  'Narcotic',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })
                  : Builder(builder: (context) {
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.all(3),
                              child: MaterialButton(
                                padding: EdgeInsets.all(2),
                                color: Colors.redAccent[400],
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black45, width: 2),
                                ),
                                onPressed: () {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "Please contact your workplace to be authorized for writing psychotropic/narcotic medications",
                                    ),
                                  );
                                },
                                child: Text(
                                  'Psychotropic',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.all(3),
                              child: MaterialButton(
                                padding: EdgeInsets.all(2),
                                color: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Colors.black45, width: 2),
                                ),
                                onPressed: () {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "Please contact your workplace to be authorized for writing psychotropic/narcotic medications",
                                    ),
                                  );
                                },
                                child: Text(
                                  'Narcotic',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    })
            ],
          ),
          Builder(builder: (context) {
            if (pretype == "general") {
              return PrescribeForm(
                  _setPrescription, 'general', Colors.white, widget.from);
            } else if (pretype == "instrument") {
              return PrescribeForm(_setPrescription, 'instrument',
                  Color(0xff0BE9E2), widget.from);
            } else if (pretype == "narcotic") {
              return PrescribeNarcoForm(
                  _setPrescription, 'narcotic', Color(0xffF211C5), widget.from);
            } else if (pretype == "psychotropic") {
              return PrescribeNarcoForm(_setPrescription, 'psychotropic',
                  Color(0xffD24F95), widget.from);
            } else {
              return Container();
            }
          }),
          pretype == "general" || pretype == "instrument"
              ? PrescriptionPaper(prescription, pretype)
              : PsychoNarcoPaper(psycoPrescription),
          SizedBox(
            height: 5.0,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('AlertDialog Title'),
                      content: TextFormField(
                        controller: favoriteController,
                        decoration: InputDecoration(hintText: 'Group name'),
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'Cancel'),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () async {
                            var user = await UserPreferences().getUser();
                            prescription.forEach((element) async {
                              Favorites favorites = new Favorites(
                                  drug_name: element['drug_name'],
                                  drug: int.parse(element['drug']),
                                  name: favoriteController.text,
                                  profession_id: user.professionid,
                                  route: element['route'],
                                  strength: element['strength'],
                                  unit: element['unit'],
                                  type: element['type'],
                                  frequency: element['frequency'],
                                  takein: element['takein']);

                              var db = new DatabaseHelper();
                              var res = await db.saveFavorites(favorites);
                            });
                            Navigator.pop(context, 'OK');
                            showTopSnackBar(
                              context,
                              CustomSnackBar.success(
                                message:
                                    "Your prescriptions are saved to favorites successfully",
                              ),
                            );
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 150,
                    height: 40,
                    margin: EdgeInsets.only(right: 20.0, top: 0.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45),
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Center(
                        child: Text(
                      'Save to favorites',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Welcome()));
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 100,
                    height: 40,
                    margin: EdgeInsets.only(right: 20.0, top: 0.0),
                    decoration: BoxDecoration(
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
                            print("prescriptionprescription $patient");
                            if (prescription.length != 0 &&
                                patient.length != 0) {
                              for (var i = 0; i < patient.length; i++) {
                                var phone = patient[i]['phone'];
                                var name = patient[i]['name'];
                                var age = patient[i]['age'];
                                var sex = patient[i]['sex'];
                                if (phone == "" ||
                                    phone == null ||
                                    sex == "" ||
                                    sex == null ||
                                    name == "" ||
                                    name == null ||
                                    age == "" ||
                                    age == null) {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "Please make sure all patient information is provided before sending prescription",
                                    ),
                                  );

                                  return;
                                }
                              }
                              var res = await prescProvider.writePrescription(
                                  prescription, patient);
                              if (res['status']) {
                                Provider.of<PrescriptionProvider>(context,
                                        listen: false)
                                    .resetStatus();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WritePrescription(
                                              from: 'sent',
                                            )));
                              } else {
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message:
                                        "Unable to send your prescriptions",
                                  ),
                                );
                              }
                            } else {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      'Please fill at least one prescription.',
                                ),
                              );
                            }
                          } else {
                            if (psycoPrescription.length != 0) {
                              var res = await prescProvider.writePrescription(
                                  psycoPrescription, patient);
                              if (res['status']) {
                                Provider.of<PrescriptionProvider>(context,
                                        listen: false)
                                    .resetStatus();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WritePrescription(
                                              from: 'sent',
                                            )));
                              } else {
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message:
                                        'Unable to send your prescriptions',
                                  ),
                                );
                              }
                            } else {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message:
                                      'Please fill at least one prescription.',
                                ),
                              );
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
                          margin: EdgeInsets.only(right: 10.0, top: 0.0),
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
