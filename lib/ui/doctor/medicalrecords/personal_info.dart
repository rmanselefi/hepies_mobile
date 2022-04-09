import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PersonalInfo extends StatefulWidget {
  final patient;
  final diagnosis;
  PersonalInfo({this.patient, this.diagnosis});
  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    var patient = widget.patient;
    var remark = patient['prescription'][0]['remark'];
    var date = patient['prescription_item'][0]['createdAt'];
    var formattedDate =
        new DateFormat("mm-dd-yyyy hh:mm a").format(DateTime.parse(date));

    return Container(
      margin: EdgeInsets.all(5),
      padding: EdgeInsets.all(5),
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
              child: Expanded(
                child: Text(
                  "${patient['name']} ${patient['fathername'] ?? 'empty'}",
                  style: TextStyle(color: Colors.black87),
                ),
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
                "${patient['weight'] ?? ''}Kg",
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
              child: Expanded(
                child: Text(
                  "${patient['age'] ?? ''}",
                  style: TextStyle(color: Colors.black87),
                ),
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
                "${patient['sex'] ?? ''}",
              ),
            )
          ]),
          TableRow(children: [
            Container(
              padding: EdgeInsets.only(top: 6),
              child: Expanded(
                child: Text(
                  "Remark",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.only(top: 6),
              child: Expanded(
                child: Text(
                  "${remark == "" || remark == null ? 'empty' : remark}",
                  style: TextStyle(color: Colors.black87),
                ),
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
                "${widget.diagnosis ?? ''}",
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
              child: Expanded(
                child: Text(
                  "${formattedDate ?? ''}",
                  style: TextStyle(color: Colors.black87),
                ),
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
                "${patient['mrn'] ?? ''}",
              ),
            )
          ]),
        ],
      ),
    );
  }
}
