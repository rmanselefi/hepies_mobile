import 'package:flutter/material.dart';
import 'package:hepies/ui/medicalrecords/personal_info.dart';
import 'package:intl/intl.dart';
import 'package:hepies/ui/medicalrecords/add_history.dart';
import 'package:hepies/ui/medicalrecords/result_detail.dart';
import 'package:hepies/widgets/header.dart';

class MedicalResult extends StatefulWidget {
  final List<dynamic> res;
  MedicalResult({this.res});
  @override
  _MedicalResultState createState() => _MedicalResultState();
}

class _MedicalResultState extends State<MedicalResult> {
  @override
  Widget build(BuildContext context) {
    var patient = widget.res[0];
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            Header(),
            SizedBox(
              height: 20.0,
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PersonalInfo(patient),
                      MaterialButton(
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                        child: Text('Back'),
                        color: Color(0xff07febb),
                        textColor: Colors.black,
                      )
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddHistory(pageNumber: 0)));
                      },
                      child: Container(
                        width: 100,
                        height: 40,
                        alignment: Alignment.centerRight,
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.white24),
                            borderRadius: BorderRadius.circular(40.0),
                            color: Colors.green),
                        child: Center(
                          child: Text('ADD'),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 2 * MediaQuery.of(context).size.height / 3,
                      child: ListView(
                          children: patient['prescription'].map<Widget>((e) {
                        var date = DateFormat.yMMMd()
                            .format(DateTime.parse(e['createdAt']));
                        var hour = DateFormat.jm()
                            .format(DateTime.parse(e['createdAt']));
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ResultDetail(patient,e['createdAt'],e['professional'])));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10.0),
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                    width: 1
                              )
                            ),
                            child: Text(
                              '$date                           $hour',
                              style: TextStyle(
                                  fontSize: 23.0),
                            ),
                          ),
                        );
                      }).toList()),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
