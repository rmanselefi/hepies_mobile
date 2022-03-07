import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalInfoCode extends StatefulWidget {
  final patient;
  final diagnosis;
  PersonalInfoCode({this.patient, this.diagnosis});
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfoCode> {
  @override
  Widget build(BuildContext context) {
    var prescription = widget.patient;

    var patient = prescription['patient'];
    var remark = prescription['prescription']['remark'];
    var date = prescription['prescription']['createdAt'];
    var formattedDate =
        new DateFormat("mm-dd-yyyy hh:mm a").format(DateTime.parse(date));
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Name -- ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${patient['name']} ${patient['fathername'] ?? 'empty'}',
                style: TextStyle(fontSize: 18.0),
              )
            ],
          ),
          Row(
            children: [
              Text(
                'Age -- ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${patient['age'] ?? 'empty'}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Sex -- ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${patient['sex'] ?? 'empty'}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Weight -- ' ?? 'empty',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${patient['weight'] ?? 'empty'}Kg',
                style: TextStyle(fontSize: 18.0),
              )
            ],
          ),
          Row(
            children: [
              Text(
                'MRN -- ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${patient['address'] ?? 'empty'}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Dx -- ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${widget.diagnosis ?? 'empty'}',
                style: TextStyle(fontSize: 18.0),
              )
            ],
          ),
          Row(
            children: [
              Text(
                'Remark -- ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '${remark == "" || remark == null ? 'empty' : remark}',
                style: TextStyle(fontSize: 18.0),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                'Date -- ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Text(
                  '${formattedDate ?? 'empty'}',
                  style: TextStyle(fontSize: 18.0),
                ),
              )
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }
}
