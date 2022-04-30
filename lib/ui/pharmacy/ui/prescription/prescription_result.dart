import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/doctor/medicalrecords/personal_info.dart';
import 'package:hepies/ui/doctor/medicalrecords/personal_info_code.dart';
import 'package:hepies/ui/pharmacy/ui/profile/profile.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';

import '../../../../providers/user_provider.dart';

class PrescriptionResult extends StatefulWidget {
  final result;
  PrescriptionResult(this.result);
  @override
  _PrescriptionResultState createState() => _PrescriptionResultState();
}

class _PrescriptionResultState extends State<PrescriptionResult> {
  bool value = false;
  List<int> selectedList = [];
  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("Accepting your prescription ... Please wait")
    ],
  );
  @override
  Widget build(BuildContext context) {
    var prescProvider = Provider.of<PrescriptionProvider>(context);

    List<dynamic> result = widget.result['data'];
    List<dynamic> notReadPrescription = result
        .where((i) =>
            i['status'] == "NotRead" &&
            DateTime.now().difference(DateTime.parse(i['createdAt'])).inDays <=
                15)
        .toList();
    var diagnosis = result[0]['prescription']['diagnosis'];
    var prescription = result[0];
    var patient = prescription['patient'];
    List<dynamic> list_id = [];
    notReadPrescription.forEach((element) {
      list_id.add(element['id']);
    });
    // print(prescription);
    // print("readreadread $prescription");
    UserProvider nav = Provider.of<UserProvider>(context);

    return SafeArea(
        child: Scaffold(
            body: WillPopScope(
      onWillPop: () async {
        return Navigator.push(context,
            MaterialPageRoute(builder: (context) => WelcomePharmacy()));
      },
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(8.0),
          child: PersonalInfoCode(patient: prescription, diagnosis: diagnosis),
        ),
        Expanded(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 480.0,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Color(0xff707070))),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'RX',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 23.0),
                        ),
                      ),
                      Column(
                          children: notReadPrescription.map<Widget>((e) {
                        return Container(
                          margin: EdgeInsets.all(5),
                          child: Row(
                            children: [
                              Text(
                                '${notReadPrescription.indexOf(e) + 1}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Expanded(
                                child: Text(
                                  ' ${e['drug_name']} ${e['strength']} '
                                  '${e['unit']} ${e['route']} Every ${e['frequency']} For ${e['takein']}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0),
                                ),
                              ),
                              InkWell(
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  margin: EdgeInsets.only(right: 10.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black26, width: 1.5)),
                                  child: selectedList.contains(e['id'])
                                      ? FittedBox(
                                          child: Icon(
                                          Icons.cancel,
                                          size: 10,
                                        ))
                                      : Container(),
                                ),
                                onTap: () {
                                  setState(() {
                                    var selected =
                                        selectedList.contains(e['id']);
                                    if (!selected) {
                                      selectedList.add(e['id']);
                                    } else {
                                      selectedList.remove(e['id']);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList())
                    ],
                  ),
                ),
              ),
              prescProvider.sentStatus == PrescriptionStatus.Sending
                  ? loading
                  : Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              width: 100,
                              height: 40,
                              margin: EdgeInsets.only(right: 20.0, top: 0.0),
                              decoration: BoxDecoration(
                                  color: Color(0xff88DE91),
                                  border: Border.all(color: Colors.black45),
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Center(
                                  child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            print("object $selectedList");
                            var res = await prescProvider.acceptPrescription(
                                selectedList, list_id);
                            if (res['status']) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.success(
                                  message:
                                      'Your prescriptions are sent succesfully',
                                ),
                              );
                              nav.changeNavSelection(NavSelection.home);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WelcomePharmacy()));
                            } else {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                    message:
                                        'Unable to send your prescriptions'),
                              );
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
                                'Accept',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PrescriberProfile(
                                            patient: prescription,
                                            id: prescription['professionalid'],
                                            from: 'code',
                                            diagnosis: diagnosis,
                                          )));
                            },
                            child: Container(
                              child: Text(
                                '${prescription['professional']}',
                                style: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: Colors.grey),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ]),
    )));
  }
}
