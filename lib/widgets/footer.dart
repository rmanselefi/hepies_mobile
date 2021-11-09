import 'package:flutter/material.dart';
import 'package:hepies/ui/doctor/drugs/drugs.dart';
import 'package:hepies/ui/doctor/medicalrecords/medical_records.dart';
import 'package:hepies/ui/doctor/prescription/write_prescription.dart';
import 'package:hepies/ui/welcome.dart';

class Footer extends StatefulWidget {

  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        MaterialButton(

          color: Color(0xff0FF6A0),
          minWidth: 50.0,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Welcome(currenIndex: 0,)));
          },
          child: Text('Home'),
        ),
        SizedBox(
          width: 5.0,
        ),
        MaterialButton(
          minWidth: 50.0,
          elevation: 0.0,
          color: Color(0xff0FF6A0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => WritePrescription()));
          },
          child: Text('Write Prescription'),
        ),
        SizedBox(
          width: 5.0,
        ),
        // MaterialButton(
        //   minWidth: 50.0,
        //   elevation: 0.0,
        //   color: Color(0xff0FF6A0),
        //   shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(12), // <-- Radius
        //   ),
        //   onPressed: () {
        //     Navigator.push(
        //         context, MaterialPageRoute(builder: (context) => MedicalRecord()));
        //   },
        //   child: Text('Medical Records'),
        // ),
        SizedBox(
          width: 5.0,
        ),
        MaterialButton(
          minWidth: 50.0,
          elevation: 0.0,
          color: Color(0xff0FF6A0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // <-- Radius
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Drugs()));
          },
          child: Text('Drugs'),
        )
      ],
    );
  }
}
