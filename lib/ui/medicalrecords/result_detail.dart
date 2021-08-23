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
    DateTime dateTime = DateTime.now();
    DateTime _pickedDate =
        DateTime.parse(createdAt); // Some other DateTime instance

    var hx = patient['hx']
        .where((ele) =>
            DateTime.parse(ele['createdAt']).difference(_pickedDate).inHours ==
            0)
        .toList();
    var pres = patient['prescription']
        .where((ele) =>
            DateTime.parse(ele['createdAt']).difference(_pickedDate).inHours ==
            0)
        .toList();
    var px = patient['px']
        .where((ele) =>
            DateTime.parse(ele['createdAt']).difference(_pickedDate).inHours ==
            0)
        .toList();
    var dx = patient['dx']
        .where((ele) =>
            DateTime.parse(ele['createdAt']).difference(_pickedDate).inHours ==
            0)
        .toList();
    var ix = patient['ix']
        .where((ele) =>
    DateTime.parse(ele['createdAt']).difference(_pickedDate).inHours ==
        0)
        .toList();
    var diagnosis = dx[0]['diagnosis'];
    final splitNames = diagnosis.split(',');

    print("patientpatientpatientpatient ${ix[0]['serology']['ana']}");
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
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(hx[0]['cc'] != null ? hx[0]['cc'] : '')
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
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(hx[0]['hpi'] != null ? hx[0]['hpi'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'PX',
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
                        'Vital Sign',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Text(
                        'BP',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['bp'] != null ? px[0]['bp'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Text(
                        'PR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['pr'] != null ? px[0]['pr'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Text(
                        'RR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['rr'] != null ? px[0]['rr'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Text(
                        'T',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['temp'] != null ? px[0]['temp'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'HEENT',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['heent'] != null ? px[0]['heent'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'LGS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['lgs'] != null ? px[0]['lgs'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'RS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['rs'] != null ? px[0]['rs'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'CVS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['cvs'] != null ? px[0]['cvs'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'ABD',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['abd'] != null ? px[0]['abd'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'GUS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['gus'] != null ? px[0]['gus'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'MSK',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['msk'] != null ? px[0]['msk'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'INTS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['ints'] != null ? px[0]['ints'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'CNS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['cns'] != null ? px[0]['cns'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'IX',
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
                        'Hematology',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'HGB',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['ints'] != null ? px[0]['ints'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'CNS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('--'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(px[0]['cns'] != null ? px[0]['cns'] : '')
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'Chemistry',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'DX/ASST',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 25.0),
                      ),
                    )
                  ],
                ),
                Column(
                    children: splitNames.map<Widget>((e) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "${splitNames.indexOf(e) + 1}",
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
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(e)
                    ],
                  );
                }).toList()),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        'RX',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            fontSize: 25.0),
                      ),
                    )
                  ],
                ),
                Column(
                    children: pres.map<Widget>((e) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                          "${pres.indexOf(e) + 1}",
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
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                          '${e['drug_name']} ${e['strength']} ${e['unit']} ${e['route']} Every ${e['frequency']} For ${e['takein']}'),
                    ],
                  );
                }).toList()),
              ],
            ),
          )
        ],
      ),
    );
  }
}
