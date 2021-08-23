import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/models/dx.dart';
import 'package:hepies/models/hx.dart';
import 'package:hepies/models/px.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/favorites/favorites.dart';
import 'package:hepies/ui/guidelines/guidelines.dart';
import 'package:hepies/ui/medicalrecords/add_history.dart';
import 'package:hepies/ui/prescription/prescription_types/general_prescription.dart';
import 'package:hepies/ui/prescription/prescription_types/instrument_prescription.dart';
import 'package:hepies/ui/prescription/prescription_types/narcotic_prescription.dart';
import 'package:hepies/ui/prescription/prescription_types/psychotropic_prescription.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:provider/provider.dart';

enum type { general, narcotic, psychotropic, instrument }

class WritePrescription extends StatefulWidget {
  final History history;
  final Diagnosis diagnosis;
  final Physical physical;
  final String type;
  WritePrescription({this.physical, this.diagnosis, this.history, this.type});
  @override
  _WritePrescriptionState createState() => _WritePrescriptionState();
}

class _WritePrescriptionState extends State<WritePrescription> {
  var pretype = "general";
  List<dynamic> prescription = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      pretype = widget.type != null ? widget.type : 'general';
    });
  }

  void _setPrescription(Map pres) {
    setState(() {
      prescription.add(pres);
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
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
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
                    border: Border.all(color: Colors.black45, width: 2),
                  ),
                  child: Center(
                      child: Text(
                    'Psychotropic',
                    style: TextStyle(fontSize: 14.0),
                  )),
                ),
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
                    border: Border.all(color: Colors.black45, width: 2),
                  ),
                  child: Center(
                      child:
                          Text('Narcotic', style: TextStyle(fontSize: 15.0))),
                ),
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
              )
            ],
          ),
          Builder(builder: (context) {
            if (pretype == "general") {
              return GeneralPrescription(setPrescription: _setPrescription);
            } else if (pretype == "instrument") {
              return InstrumentPrescription(setPrescription: _setPrescription);
            } else if (pretype == "narcotic") {
              return NarcoticPrescription(setPrescription: _setPrescription);
            } else if (pretype == "psychotropic") {
              return PsychotropicPrescription(
                  setPrescription: _setPrescription);
            } else {
              return Container();
            }
          }),
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
              prescProvider.sentStatus == Status.Sending
                  ? loading
                  : GestureDetector(
                      onTap: () async {
                        print("object $prescription");
                        try {
                          if(prescription.length!=0){
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
                          }
                          else{
                            Flushbar(
                              title: 'Error',
                              message: 'Please fill at least one prescription.',
                              duration: Duration(seconds: 10),
                            ).show(context);
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
