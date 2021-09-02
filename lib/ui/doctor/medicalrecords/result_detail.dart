import 'package:flutter/material.dart';
import 'package:hepies/models/consult.dart';
import 'package:hepies/ui/doctor/medicalrecords/personal_info.dart';
import 'package:hepies/widgets/header.dart';
import 'package:intl/intl.dart';

class ResultDetail extends StatefulWidget {
  final patient;
  final createdAt;
  final professional;
  final code;
  ResultDetail(this.patient, this.createdAt, this.professional,this.code);
  @override
  _ResultDetailState createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail> {
  @override
  Widget build(BuildContext context) {
    var patient = widget.patient;
    var createdAt = widget.createdAt;
    var code=widget.code;
    var professional = widget.professional;
    DateTime dateTime = DateTime.now();
    DateTime _pickedDate =
        DateTime.parse(createdAt); // Some other DateTime instance

    var hx = patient['hx']
        .where((ele) =>
            DateTime.parse(ele['createdAt']).difference(_pickedDate).inMinutes ==
            0)
        .toList();
    var pres = patient['prescription']
        .where((ele) =>
            DateTime.parse(ele['createdAt']).difference(_pickedDate).inMinutes ==
            0)
        .toList();
    var px = patient['px']
        .where((ele) =>
            DateTime.parse(ele['createdAt']).difference(_pickedDate).inMinutes ==
            0)
        .toList();
    var dx = patient['dx']
        .where((ele) =>
            DateTime.parse(ele['createdAt']).difference(_pickedDate).inMinutes ==
            0)
        .toList();
    var ix = patient['ix']
        .where((ele) =>
            DateTime.parse(ele['createdAt']).difference(_pickedDate).inMinutes ==
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
                _hematologyList(ix),
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
                _chemistryList(ix),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'Serology',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                _serologyList(ix),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 50.0),
                      child: Text(
                        'Endocrinology',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0),
                      ),
                    ),
                  ],
                ),
                _endocrinologyList(ix),
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

  Widget _hematologyList(ix) {
    var hema = ix[0]['hemathology'];
    return Column(
      children: [
        hema['wbccount'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'WBC count',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['wbccount'])
                ],
              )
            : Container(),
        hema['hgb'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'HGB',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['hgb'])
                ],
              )
            : Container(),
        hema['hct'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'HCT',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['hct'])
                ],
              )
            : Container(),
        hema['mcv'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'MCV',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['mcv'])
                ],
              )
            : Container(),
        hema['mch'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'MCH',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['mch'])
                ],
              )
            : Container(),
        hema['mchc'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'MCHC',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['mchc'])
                ],
              )
            : Container(),
        hema['pltcount'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Pltcount',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['pltcount'])
                ],
              )
            : Container(),
        hema['reticulocyte'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'reticulocyte',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['reticulocyte'])
                ],
              )
            : Container(),
        hema['bgrh'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'BGRH',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['bgrh'])
                ],
              )
            : Container(),
        hema['esr'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'ESR',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['esr'])
                ],
              )
            : Container(),
      ],
    );
  }

  Widget _chemistryList(ix) {
    var hema = ix[0]['chemistry'];
    print("object $hema");
    return Column(
      children: [
        hema['albumin'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Albumin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['albumin'])
                ],
              )
            : Container(),
        hema['alp'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Alp',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['alp'])
                ],
              )
            : Container(),
        hema['altsgpt'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Altsgpt',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['altsgpt'])
                ],
              )
            : Container(),
        hema['amylase'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Amylase',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['amylase'])
                ],
              )
            : Container(),
        hema['astsgot'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Astsgot',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['astsgot'])
                ],
              )
            : Container(),
        hema['bunurea'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Bunurea',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['bunurea'])
                ],
              )
            : Container(),
        hema['calcium'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Calcium',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['calcium'])
                ],
              )
            : Container(),
        hema['totalprotein'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Total Protein',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['totalprotein'])
                ],
              )
            : Container(),
        hema['calciumionized'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Calcium Ionized',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['calciumionized'])
                ],
              )
            : Container(),
        hema['bilirubindirect'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Bilirubin direct',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['bilirubindirect'])
                ],
              )
            : Container(),
        hema['bilirubinindirect'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Bilirubin indirect',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['bilirubinindirect'])
                ],
              )
            : Container(),
        hema['bilirubintotal'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Bilirubin total',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['bilirubintotal'])
                ],
              )
            : Container(),
        hema['creatinine'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Creatinine',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['creatinine'])
                ],
              )
            : Container(),
        hema['chloride'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Chloride',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['chloride'])
                ],
              )
            : Container(),
        hema['cholesterol'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Cholesterol',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['cholesterol'])
                ],
              )
            : Container(),
        hema['fbs'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'FBS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['fbs'])
                ],
              )
            : Container(),
        hema['ferritin'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Ferritin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['ferritin'])
                ],
              )
            : Container(),
        hema['hba1c'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'HBA1C',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['hba1c'])
                ],
              )
            : Container(),
        hema['hdl'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'HDL',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['hdl'])
                ],
              )
            : Container(),
        hema['iron'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Iron',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['iron'])
                ],
              )
            : Container(),
        hema['ldl'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'LDL',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['ldl'])
                ],
              )
            : Container(),
        hema['lipase'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Lipase',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['lipase'])
                ],
              )
            : Container(),
        hema['magnesium'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Magnesium',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['magnesium'])
                ],
              )
            : Container(),
        hema['phosphorous'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Phosphorous',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['phosphorous'])
                ],
              )
            : Container(),
        hema['potassium'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Potassium',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['potassium'])
                ],
              )
            : Container(),
        hema['protein'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Protein',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['protein'])
                ],
              )
            : Container(),
        hema['rbs'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'RBS',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['rbs'])
                ],
              )
            : Container(),
        hema['serumfolate'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Serumfolate',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['serumfolate'])
                ],
              )
            : Container(),
        hema['sodium'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Sodium',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['sodium'])
                ],
              )
            : Container(),
        hema['TIBC'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'TIBC',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['TIBC'])
                ],
              )
            : Container(),
        hema['transferrinsaturation'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Transferrin saturation',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['transferrinsaturation'])
                ],
              )
            : Container(),
        hema['triglyceride'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Triglyceride',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['triglyceride'])
                ],
              )
            : Container(),
      ],
    );
  }

  Widget _serologyList(ix) {
    var hema = ix[0]['serology'];
    print("object $hema");
    return Column(
      children: [
        hema['ana'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'ANA',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['ana'])
                ],
              )
            : Container(),
        hema['cd4count'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Cd4count',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['cd4count'])
                ],
              )
            : Container(),
        hema['hbsag'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'HBSAG',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['hbsag'])
                ],
              )
            : Container(),
        hema['aso'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'ASO',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['aso'])
                ],
              )
            : Container(),
        hema['betahcg'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Betahcg',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['betahcg'])
                ],
              )
            : Container(),
        hema['coombs'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Coombs',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['coombs'])
                ],
              )
            : Container(),
        hema['crp'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'CRP',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['crp'])
                ],
              )
            : Container(),
        hema['hivmedical'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'HIV medical',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['hivmedical'])
                ],
              )
            : Container(),
        hema['hivviralload'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'HIV viral load',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['hivviralload'])
                ],
              )
            : Container(),
        hema['rf'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'RF',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['rf'])
                ],
              )
            : Container(),
        hema['welfelix'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Wel felix',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['welfelix'])
                ],
              )
            : Container(),
        hema['widal'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Widal',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['widal'])
                ],
              )
            : Container(),
      ],
    );
  }

  Widget _endocrinologyList(ix) {
    var hema = ix[0]['endocrinology'];
    print("object $hema");
    return Column(
      children: [
        hema['erythropoietin'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Erythropoietin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['erythropoietin'])
                ],
              )
            : Container(),
        hema['estradiol'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Estradiol',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['estradiol'])
                ],
              )
            : Container(),
        hema['fsh'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'FSH',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['fsh'])
                ],
              )
            : Container(),
        hema['growthhormone'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Growth Hormone',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['growthhormone'])
                ],
              )
            : Container(),
        hema['lh'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'LH',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['lh'])
                ],
              )
            : Container(),
        hema['progesterone'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Progesterone',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['progesterone'])
                ],
              )
            : Container(),
        hema['prolactin'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Prolactin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['prolactin'])
                ],
              )
            : Container(),
        hema['pth'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'PTH',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['pth'])
                ],
              )
            : Container(),
        hema['serumcalcitonin'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Serum calcitonin',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['serumcalcitonin'])
                ],
              )
            : Container(),
        hema['serumcortisol'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Serum cortisol',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['serumcortisol'])
                ],
              )
            : Container(),
        hema['t3'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'T3',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['t3'])
                ],
              )
            : Container(),
        hema['t4'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      't4',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['t4'])
                ],
              )
            : Container(),
        hema['testosterone'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'Testosterone',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['testosterone'])
                ],
              )
            : Container(),
        hema['tsh'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'TSH',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['tsh'])
                ],
              )
            : Container(),
        hema['vitb12'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'VIT b12',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['vitb12'])
                ],
              )
            : Container(),
        hema['vitD'] != null
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 100.0),
                    child: Text(
                      'VIT D',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text('--'),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(hema['vitD'])
                ],
              )
            : Container(),
      ],
    );
  }
}
