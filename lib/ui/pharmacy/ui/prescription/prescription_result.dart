import 'package:flutter/material.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/doctor/medicalrecords/personal_info.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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
      Text("Sending your prescription ... Please wait")
    ],
  );
  @override
  Widget build(BuildContext context) {
    var prescProvider = Provider.of<PrescriptionProvider>(context);
    print("readreadread ${widget.result}");
    List<dynamic> result = widget.result;
    var patient = result[0]['patient'];
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
                    height: 600.0,
                    decoration: BoxDecoration(
                        border:
                            Border.all(width: 2.0, color: Color(0xff707070))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            children: result.map<Widget>((e) {
                          return Row(
                            children: [
                              Text(
                                '${result.indexOf(e) + 1}',
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
                              Checkbox(
                                value: selectedList.contains(e['id']),
                                onChanged: (bool value) {
                                  setState(() {
                                    if (value) {
                                      selectedList.add(e['id']);
                                    } else {
                                      selectedList.remove(e['id']);
                                    }
                                  });
                                },
                              ),
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
                                  .acceptPrescription(selectedList);
                              if (res['status']) {

                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.success(
                                    message:
                                    'Your prescriptions are sent succesfully',
                                  ),
                                );
                              } else {
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.error(
                                    message:
                                    'Unable to send your prescriptions'
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
