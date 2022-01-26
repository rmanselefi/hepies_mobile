import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/patient_provider.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/pharmacy/ui/prescription/prescription_result.dart';
import 'package:hepies/ui/pharmacy/ui/prescription/result_phone.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/ui/pharmacy/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView(
                children: [
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    child: Center(
                      child: Text(
                        'Enter prescription code',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      controller: codeController,
                      enabled: true,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(
                              right: 5, left: 10, top: 5, bottom: 5),
                        ),
                        hintText: 'Enter code here...',
                        counterText: "",
                        contentPadding: EdgeInsets.all(5),
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
                                  .readPrescription('${codeController.text}');
                              print("objectobjectobjectobject $res");
                              if (res['status']) {
                                if (res['isPhone']) {
                                  res = await prescriptionProvider
                                      .readPrescription(
                                          '${codeController.text}');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PrescriptionResultPhone(
                                                res['data'])),
                                  );
                                } else {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PrescriptionResult(res)),
                                  );
                                }
                              } else {
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message:
                                        "Unable to read prescription. Make sure to provide correct code/phone",
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
            Center(child: PharmacyFooter())
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
