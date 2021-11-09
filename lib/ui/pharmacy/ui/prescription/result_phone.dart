import 'package:flutter/material.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/doctor/medicalrecords/personal_info.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PrescriptionResultPhone extends StatefulWidget {
  final result;
  PrescriptionResultPhone(this.result);
  @override
  _PrescriptionResultState createState() => _PrescriptionResultState();
}

class _PrescriptionResultState extends State<PrescriptionResultPhone> {
  bool value = false;
  List<int> selectedList = [];
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

    List<dynamic> result = widget.result;
    var patient = result[0];
    var prescription=result[0]['prescription'];
    List<dynamic> notReadPrescription = prescription.where((i) => i['status']=="NotRead").toList();
    List<dynamic> list_id=[];
    notReadPrescription.forEach((element) {
      list_id.add(element['id']);
    });
    print("readreadread $list_id");
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PersonalInfo(patient),
            ),
            Expanded(
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 650.0,
                        decoration: BoxDecoration(
                            border:
                            Border.all(width: 2.0, color: Color(0xff707070))),
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
                                  return Row(
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
                                              fontSize: 20.0),
                                        ),
                                      ),
                                      InkWell(
                                        child: Container(
                                          width: 20,
                                          height: 20,
                                          margin:EdgeInsets.only(right: 10.0),
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
                                      // Checkbox(
                                      //   value: selectedList.contains(e['id']),
                                      //
                                      //   onChanged: (bool value) {
                                      //     setState(() {
                                      //       if (value) {
                                      //         selectedList.add(e['id']);
                                      //       } else {
                                      //         selectedList.remove(e['id']);
                                      //       }
                                      //     });
                                      //   },
                                      //
                                      // ),
                                    ],
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
                            var res = await prescProvider
                                .acceptPrescription(selectedList,list_id);
                            if (res['status']) {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.success(
                                  message:
                                  'Your have accepted prescriptions successfully',
                                ),
                              );
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomePharmacy()));
                            } else {
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                    message:
                                    'Unable to accept prescriptions'
                                ),
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
                        )
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
