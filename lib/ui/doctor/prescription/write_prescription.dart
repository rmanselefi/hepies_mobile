import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/models/dx.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/models/hx.dart';
import 'package:hepies/models/px.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/doctor/calculator/calculator.dart';
import 'package:hepies/ui/doctor/favorites/favorites.dart';
import 'package:hepies/ui/doctor/guidelines/guidelines.dart';
import 'package:hepies/ui/doctor/prescription/forms/prescribe_form.dart';
import 'package:hepies/ui/doctor/prescription/forms/prescribe_narco_form.dart';
import 'package:hepies/ui/doctor/prescription/forms/prescribe_psyco_form.dart';
import 'package:hepies/ui/doctor/prescription/papers/prescription_paper.dart';
import 'package:hepies/ui/doctor/prescription/papers/psycho_narco_paper.dart';
import 'package:hepies/ui/doctor/prescription/papers/psycho_paper.dart';
import 'package:hepies/ui/welcome.dart';
import 'package:hepies/util/database_helper.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:hepies/constants.dart';

enum type { general, narcotic, psychotropic, instrument }

class WritePrescription extends StatefulWidget {
  final Diagnosis diagnosis;
  final String type;
  final String from;
  final data;
  WritePrescription({this.diagnosis, this.type, this.from, this.data});
  @override
  _WritePrescriptionState createState() => _WritePrescriptionState();
}

class _WritePrescriptionState extends State<WritePrescription> {
  var pretype = "general";
  List<dynamic> prescription = [];
  List<dynamic> patient = [];
  List<dynamic> psycoPrescription = [];
  List<dynamic> narcoPrescription = [];
  bool favorite = false;
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
    String from = widget.from;
    print("widget.from ===== > ${widget.from}");
    if (from == "sent") {
      showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: "Your prescriptions are sent successfully",
        ),
      );
      setState(() {
        from = "not";
      });
    }
    var fav = widget.data;
    print("i am here from fav $fav");
    if (fav != null) {
      setFromFavorites(fav);
    }
    setIsFit();
    setState(() {
      pretype = widget.type != null ? widget.type : 'general';
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
  }

  void setFavorite(bool val) {
    setState(() {
      favorite = val;
    });
  }

  void setIsFit() async {
    var user = await UserProvider().getProfile();
    print("isFitisFitisFit ${user['isFit']}");
    setState(() {
      isFit = user['isFit'];
    });
  }

  void setFromFavorites(List<dynamic> fav) async {
    List<dynamic> press = [];
    User user = await UserPreferences().getUser();
    var profession = "${user.profession} ${user.name} ${user.fathername}";
    for (var i = 0; i < fav.length; i++) {
      final Map<String, dynamic> prescriptionData = {
        'drug_name': fav[i]['drug_name'],
        "strength": fav[i]['strength'],
        "unit": fav[i]['unit'],
        "route": fav[i]['route'],
        "takein": fav[i]['takein'],
        "frequency": fav[i]['frequency'],
        "drug": fav[i]['drug'],
        "professional": profession,
        "material_name": "",
        "size": "",
        "type": fav[i]['type'],
        "ampule": "",
        "dx": {
          "diagnosis": "",
        },
      };
      press.add(prescriptionData);
    }
    Future.delayed(Duration.zero, () async {
      setState(() {
        prescription = press;
      });
    });
  }

  var favoriteController = new TextEditingController();

  void _setPrescription(List<dynamic> pres, List<dynamic> pat) {
    setState(() {
      prescription = pres;
      patient = pat;
    });
  }

  void _setPatient(List<dynamic> pat) {
    setState(() {
      patient = pat;
    });
  }

  void _setPsycoPrescription(List<dynamic> pres, List<dynamic> pat) {
    setState(() {
      psycoPrescription = pres;
      patient = pat;
    });
  }

  void _setNarcoPrescription(List<dynamic> pres, List<dynamic> pat) {
    setState(() {
      narcoPrescription = pres;
      patient = pat;
    });
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator(), Text("Sending..")],
  );

  @override
  Widget build(BuildContext context) {
    var prescProvider = Provider.of<PrescriptionProvider>(context);
    return WillPopScope(
      onWillPop: () async {
          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Welcome(
                                  currenIndex: 0,
                                )));    
        return;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.9,
                child: ListView(
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 0.0),
                          child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Welcome()));
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
                              height: 30,
                              width: width(context) * 0.225,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black45, width: 2),
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
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Calculator()));
                            },
                            child: Container(
                              height: 30,
                              width: width(context) * 0.225,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black45, width: 2),
                              ),
                              child: Center(
                                  child: Text('Calculator',
                                      style: TextStyle(fontSize: 16.0))),
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
                              height: 30,
                              width: width(context) * 0.225,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.black45, width: 2),
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
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: width(context) * 0.225,
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
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: width(context) * 0.225,
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
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        isFit == "true"
                            ? Builder(builder: (context) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        width: width(context) * 0.225,
                                        margin: EdgeInsets.all(3),
                                        child: MaterialButton(
                                          padding: EdgeInsets.all(2),
                                          color: Colors.redAccent[400],
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black45,
                                                width: 2),
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
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width(context) * 0.225,
                                        margin: EdgeInsets.all(3),
                                        child: MaterialButton(
                                          padding: EdgeInsets.all(2),
                                          color: Colors.purple,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black45,
                                                width: 2),
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
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                            : Builder(builder: (context) {
                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: width(context) * 0.225,
                                        margin: EdgeInsets.all(3),
                                        child: MaterialButton(
                                          padding: EdgeInsets.all(2),
                                          color: Colors.redAccent[400],
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black45,
                                                width: 2),
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
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: width(context) * 0.225,
                                        margin: EdgeInsets.all(3),
                                        child: MaterialButton(
                                          padding: EdgeInsets.all(2),
                                          color: Colors.purple,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                                color: Colors.black45,
                                                width: 2),
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
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              })
                      ],
                    ),
                    Builder(builder: (context) {
                      // print("prescriptionprescription $prescription");
                      if (pretype == "general") {
                        return PrescribeForm(
                            setPrescription: _setPrescription,
                            setPatient: _setPatient,
                            setFav: setFavorite,
                            initialPrescription: prescription,
                            type: 'general',
                            color: Colors.white,
                            from: widget.from);
                      } else if (pretype == "instrument") {
                        return PrescribeForm(
                            setPrescription: _setPrescription,
                            setPatient: _setPatient,
                            initialPrescription: prescription,
                            type: 'instrument',
                            color: Color(0xff0BE9E2),
                            from: widget.from);
                      } else if (pretype == "narcotic") {
                        return PrescribeNarcoForm(
                            setPrescription: _setNarcoPrescription,
                            setPatient: _setPatient,
                            setFav: setFavorite,
                            initialPrescription: narcoPrescription,
                            type: 'narcotic',
                            color: Color(0xffF211C5),
                            from: widget.from);
                      } else if (pretype == "psychotropic") {
                        return PrescribePsychoForm(
                            setPrescription: _setPsycoPrescription,
                            setPatient: _setPatient,
                            setFav: setFavorite,
                            initialPrescription: psycoPrescription,
                            type: 'psychotropic',
                            color: Color(0xffD24F95),
                            from: widget.from);
                      } else {
                        return Container();
                      }
                    }),
                    // pretype == "general" || pretype == "instrument"
                    //     ? PrescriptionPaper(prescription, pretype)
                    //     : pretype == 'narcotics'
                    //         ? PsychoNarcoPaper(narcoPrescription)
                    //         : PsychoPaper(psycoPrescription),
                    SizedBox(height: 5.0),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !favorite
                        ? SizedBox(width: 0)
                        : GestureDetector(
                            onTap: () {
                              showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: const Text('AlertDialog Title'),
                                  content: TextFormField(
                                    controller: favoriteController,
                                    decoration:
                                        InputDecoration(hintText: 'Group name'),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, 'Cancel'),
                                      child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        var user =
                                            await UserPreferences().getUser();
                                        if (prescription.length > 0) {
                                          prescription.forEach((element) async {
                                            Favorites favorites = new Favorites(
                                                drug_name: element['drug_name'],
                                                drug:
                                                    int.parse(element['drug']),
                                                name: favoriteController.text,
                                                profession_id:
                                                    user.professionid,
                                                route: element['route'],
                                                strength: element['strength'],
                                                unit: element['unit'],
                                                type: element['type'],
                                                frequency: element['frequency'],
                                                takein: element['takein']);

                                            var db = new DatabaseHelper();
                                            var res = await db
                                                .saveFavorites(favorites);
                                          });
                                          Navigator.pop(context, 'OK');
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.success(
                                              message:
                                                  "Your prescriptions are saved to favorites successfully",
                                            ),
                                          );
                                        } else {
                                          Navigator.pop(context, 'OK');
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message:
                                                  "No prescriptions found. you have to write at least one pescription",
                                            ),
                                          );
                                        }
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
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ),
                    !favorite
                        ? SizedBox(width: 0)
                        : SizedBox(width: width(context) * 0.15),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Welcome()),
                          ModalRoute.withName('/'),
                        );
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
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          )),
                        ),
                      ),
                    ),
                    favorite
                        ? SizedBox(width: 0)
                        : SizedBox(width: width(context) * 0.15),
                    prescProvider.sentStatus == PrescriptionStatus.Sending
                        ? loading
                        : favorite
                            ? SizedBox(width: 0)
                            : GestureDetector(
                                onTap: () async {
                                  try {
                                    if (pretype == "general" ||
                                        pretype == "instrument") {
                                      // print("patientpatient $patient");
                                      if (prescription.length != 0 &&
                                          patient.length != 0) {
                                        for (var i = 0;
                                            i < patient.length;
                                            i++) {
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
                                        var res = await prescProvider
                                            .writePrescription(
                                                prescription, patient);
                                        if (res['status']) {
                                          Provider.of<PrescriptionProvider>(
                                                  context,
                                                  listen: false)
                                              .resetStatus();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WritePrescription(
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
                                        var res = await prescProvider
                                            .writePrescription(
                                                psycoPrescription, patient);
                                        if (res['status']) {
                                          Provider.of<PrescriptionProvider>(
                                                  context,
                                                  listen: false)
                                              .resetStatus();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WritePrescription(
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

                                      if (narcoPrescription.length != 0) {
                                        var res = await prescProvider
                                            .writePrescription(
                                                narcoPrescription, patient);
                                        if (res['status']) {
                                          Provider.of<PrescriptionProvider>(
                                                  context,
                                                  listen: false)
                                              .resetStatus();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      WritePrescription(
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
                                    margin:
                                        EdgeInsets.only(right: 10.0, top: 0.0),
                                    decoration: BoxDecoration(
                                        color: Color(0xff07febb),
                                        border:
                                            Border.all(color: Colors.black45),
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: Center(
                                        child: Text(
                                      'Send',
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
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
          children: prescription.map<Widget>((pres) {
            return Row(
              children: [
                Expanded(
                  child: pres['type'] == "general"
                      ? Text(
                          '${prescription.indexOf(pres) + 1}. ${pres['drug_name']} ${pres['strength']} '
                          '${pres['unit']} ${pres['route']} Every ${pres['frequency']} For ${pres['takein']}')
                      : Text(
                          '${prescription.indexOf(pres) + 1}. ${pres['material_name']} ${pres['size']} ${pres['amount']}'),
                ),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          print("object $pres");
                          Provider.of<PrescriptionProvider>(context,
                                  listen: false)
                              .setPrescriptionForm(
                                  pres, prescription.indexOf(pres));
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          var index = prescription.indexOf(pres);
                          setState(() {
                            prescription.removeAt(index);
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
