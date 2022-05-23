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
        new DateFormat.yMd().add_jm().format(DateTime.parse(date));
    print("p" + patient.toString());
    print("all p" + prescription.toString());
    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
      height: MediaQuery.of(context).size.width / 3,
      child: Table(
        border: TableBorder(
            horizontalInside: BorderSide(
                width: 0, color: Colors.blue, style: BorderStyle.solid)),
        columnWidths: {
          0: FixedColumnWidth(MediaQuery.of(context).size.width / 7),
          1: FixedColumnWidth(MediaQuery.of(context).size.width / 2.2),
          3: FixedColumnWidth(MediaQuery.of(context).size.width / 8),
          4: FixedColumnWidth(MediaQuery.of(context).size.width / 8)
        },
        children: [
          TableRow(children: [
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "Name",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "${patient['name']} ${patient['fathername'] ?? 'empty'}",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text("Weight",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "${patient['weight'] ?? 'empty'}Kg",
              ),
            )
          ]),
          TableRow(children: [
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "Age",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "${patient['age'] ?? 'empty'}",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text("Sex",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "${patient['sex'] ?? 'empty'}",
              ),
            )
          ]),
          TableRow(children: [
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "Remark",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "${remark == "" || remark == null ? 'empty' : remark}",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text("DX",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "${widget.diagnosis ?? 'empty'}",
              ),
            )
          ]),
          TableRow(children: [
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "Date",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "${formattedDate ?? 'empty'}",
                style: TextStyle(color: Colors.black87),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text("MRN",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
            ),
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "${patient['mrn'] ?? 'empty'}",
              ),
            )
          ]),
        ],
      ),
    );
  }
}
