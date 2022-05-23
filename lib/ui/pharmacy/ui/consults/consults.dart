import 'package:flutter/material.dart';
import 'package:hepies/ui/doctor/medicalrecords/medical_records.dart';
import 'package:hepies/ui/doctor/prescription/write_prescription.dart';
import 'package:hepies/ui/pharmacy/ui/consults/consult_list.dart';
import 'package:hepies/widgets/header.dart';

class PharmacyConsults extends StatefulWidget {
  @override
  _PharmacyConsultsState createState() => _PharmacyConsultsState();
}

class _PharmacyConsultsState extends State<PharmacyConsults> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(),
        Divider(),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.green[400],
                    border: Border.all(color: Colors.black45, width: 1),
                    borderRadius: BorderRadius.circular(35.0)),
                child: Text(
                  'Write Prescription',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WritePrescription()),
                );
              },
            ),
            GestureDetector(
              child: Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: Colors.green[400],
                    border: Border.all(color: Colors.black45, width: 1),
                    borderRadius: BorderRadius.circular(35.0)),
                child: Text('See Medical Records',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MedicalRecord()),
                );
              },
            )
          ],
        ),
        SizedBox(
          height: 5.0,
        ),
        PharmacyConsultList(1, null, new ScrollController())
      ],
    );
  }
}
