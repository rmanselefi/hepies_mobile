import 'package:flutter/material.dart';
import 'package:hepies/models/consult.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/ui/doctor/consults/consult_list.dart';
import 'package:hepies/ui/doctor/medicalrecords/medical_records.dart';
import 'package:hepies/ui/doctor/prescription/write_prescription.dart';
import 'package:hepies/util/gradient_text.dart';
import 'package:hepies/widgets/header.dart';
import 'package:provider/provider.dart';

class PharmacyConsults extends StatefulWidget {
  @override
  _PharmacyConsultsState createState() => _PharmacyConsultsState();
}

class _PharmacyConsultsState extends State<PharmacyConsults> {
  @override
  Widget build(BuildContext context) {
    return ListView(
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
        FutureBuilder<List<dynamic>>(
            future: Provider.of<ConsultProvider>(context).getConsults(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.data == null) {
                  return Center(
                    child: Text('No data to show'),
                  );
                }

                print("objectobjectobject ${snapshot.data}");
                return ConsultList(snapshot.data);
              }
            })
      ],
    );
  }
}
