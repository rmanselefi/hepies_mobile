import 'dart:math';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hepies/providers/patient_provider.dart';
import 'package:hepies/ui/medicalrecords/result.dart';
import 'package:hepies/widgets/header.dart';
import 'package:provider/provider.dart';

class MedicalRecord extends StatefulWidget {
  @override
  _MedicalRecordState createState() => _MedicalRecordState();
}

class _MedicalRecordState extends State<MedicalRecord> {
  final formKey = new GlobalKey<FormState>();
  var phoneController = new TextEditingController();
  var pinController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        onSaved: (val){
                          pinController.text=val;
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
                        onSaved: (val){
                          pinController.text=val;
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
                    GestureDetector(
                      onTap: () async {
                        print("object clicked ${phoneController.text}");
                        // formKey.currentState.save();
                        var res = await Provider.of<PatientProvider>(context,listen: false).getMedicalRecord(phoneController.text);
                        print("objectobjectobjectobject $res");
                        if(res.length!=0){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MedicalResult(res:res)),
                          );
                        }
                        else{
                          Flushbar(
                            title: 'Error',
                            message: 'Unable to load medical record',
                            duration: Duration(seconds: 10),
                          ).show(context);
                        }
                      },
                      child: Container(
                        width: 180,
                        height: 70,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(40.0),
                            border: Border.all(color: Colors.black45, width: 1)),
                        child: Center(
                          child: Text('See Record',style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold
                          ),),
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
