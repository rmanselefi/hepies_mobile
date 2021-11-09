import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hepies/providers/patient_provider.dart';
import 'package:hepies/ui/doctor/medicalrecords/result.dart';
import 'package:hepies/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class MedicalRecord extends StatefulWidget {
  @override
  _MedicalRecordState createState() => _MedicalRecordState();
}

class _MedicalRecordState extends State<MedicalRecord> {
  final formKey = new GlobalKey<FormState>();
  var phoneController = new TextEditingController();
  var pinController = new TextEditingController();
  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("Sending your prescription ... Please wait")
    ],
  );
  @override
  Widget build(BuildContext context) {
    var patientProvider = Provider.of<PatientProvider>(context);
    return Scaffold(
      body: ListView(
        children: [
          Header(),
          SizedBox(
            height: 50.0,
          ),
          Form(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Phone Number',
                      style: TextStyle(fontSize: 25.0, color: Colors.green),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      child: TextFormField(
                        controller: phoneController,
                        onSaved: (val) {
                          pinController.text = val;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Phone Number',
                            hintText: 'Phone Number'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Clients PIN',
                      style: TextStyle(fontSize: 25.0, color: Colors.green),
                    ),
                    Container(
                      height: 40,
                      width: 200,
                      child: TextFormField(
                        controller: pinController,
                        onSaved: (val) {
                          pinController.text = val;
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Clients PIN',
                            hintText: 'Clients PIN'),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                    ),
                    patientProvider.fetchStatus == Status.Fetching
                        ? loading
                        : GestureDetector(
                            onTap: () async {
                              print("object clicked ${phoneController.text}");
                              // formKey.currentState.save();
                              var res = await patientProvider
                                  .getMedicalRecord(phoneController.text);
                              print("objectobjectobjectobject $res");
                              if (res.length != 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MedicalResult(res: res)),
                                );
                              } else {

                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message:
                                    "Unable to load medical record",
                                  ),
                                );
                              }
                            },
                            child: Container(
                              width: 180,
                              height: 70,
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.circular(40.0),
                                  border: Border.all(
                                      color: Colors.black45, width: 1)),
                              child: Center(
                                child: Text(
                                  'See Record',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
