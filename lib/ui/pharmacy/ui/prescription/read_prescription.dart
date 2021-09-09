import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hepies/providers/patient_provider.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/pharmacy/ui/prescription/prescription_result.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/ui/pharmacy/widgets/header.dart';
import 'package:provider/provider.dart';

class ReadPrescription extends StatefulWidget {
  @override
  _ReadPrescriptionState createState() => _ReadPrescriptionState();
}

class _ReadPrescriptionState extends State<ReadPrescription> {
  var codeController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var prescriptionProvider = Provider.of<PrescriptionProvider>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'Enter Code',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: codeController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.read_more,
                            color: Color.fromRGBO(50, 62, 72, 1.0)),
                        // hintText: hintText,
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  prescriptionProvider.readStatus == ReadStatus.Fetching
                      ? loading
                      : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                            onTap: () async {
                              var res = await prescriptionProvider
                                  .readPrescription(codeController.text);
                              print("objectobjectobjectobject $res");
                              if (res != null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PrescriptionResult(res)),
                                );
                              } else {
                                Flushbar(
                                  title: 'Error',
                                  message:
                                      'Unable to read prescription. Make sure to provide correct code',
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
                                  border: Border.all(
                                      color: Colors.black45, width: 1)),
                              child: Center(
                                child: Text(
                                  'READ',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                      ),
                ],
              ),
            ),
            PharmacyFooter()
          ],
        ),
      ),
    );
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("Reading prescription ... Please wait")
    ],
  );
}
