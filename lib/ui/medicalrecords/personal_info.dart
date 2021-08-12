import 'package:flutter/material.dart';

class PersonalInfo extends StatefulWidget {
  final patient;
  PersonalInfo(this.patient);
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    var patient = widget.patient;
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Name -- ',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              '${patient['name']} ${patient['fathername']}',
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
              '${patient['age']}',
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
              '${patient['sex']}',
              style: TextStyle(fontSize: 18.0),
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
