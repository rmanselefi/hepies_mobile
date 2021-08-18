import 'package:flutter/material.dart';
import 'package:hepies/ui/medicalrecords/personal_info.dart';
import 'package:hepies/widgets/header.dart';
import 'package:intl/intl.dart';

class ResultDetail extends StatefulWidget {
  final patient;
  final createdAt;
  final professional;
  ResultDetail(this.patient, this.createdAt, this.professional);
  @override
  _ResultDetailState createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail> {
  @override
  Widget build(BuildContext context) {
    var patient = widget.patient;
    var createdAt = widget.createdAt;
    var professional = widget.professional;
    print("patientpatientpatientpatient $patient");
    var date = DateFormat.yMMMd().format(DateTime.parse(createdAt));
    var hour = DateFormat.jm().format(DateTime.parse(createdAt));
    return Scaffold(
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
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Back'),
                      color: Color(0xff07febb),
                      textColor: Colors.black,
                    )
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: Text(
                        professional,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10.0),
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1)),
                    child: Text(
                      '$date                           $hour',
                      style: TextStyle(fontSize: 23.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'HX',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 25.0),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'C/C',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'HPI',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'PX',
                        style: TextStyle(
                            color: Colors.greenAccent, fontSize: 25.0),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'IX',
                        style: TextStyle(
                            color: Colors.greenAccent, fontSize: 25.0),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'DX',
                        style: TextStyle(
                            color: Colors.greenAccent, fontSize: 25.0),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'RX',
                        style: TextStyle(
                            color: Colors.greenAccent, fontSize: 25.0),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
