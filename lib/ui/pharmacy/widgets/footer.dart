import 'package:flutter/material.dart';
import 'package:hepies/ui/doctor/drugs/drugs.dart';
import 'package:hepies/ui/doctor/medicalrecords/medical_records.dart';
import 'package:hepies/ui/doctor/prescription/write_prescription.dart';
import 'package:hepies/ui/pharmacy/ui/consults/share_consult.dart';
import 'package:hepies/ui/pharmacy/ui/history/history.dart';
import 'package:hepies/ui/pharmacy/ui/mypharmacy/mypharmacy.dart';
import 'package:hepies/ui/pharmacy/ui/prescription/read_prescription.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:hepies/ui/welcome.dart';

class PharmacyFooter extends StatefulWidget {

  @override
  _PharmacyFooterState createState() => _PharmacyFooterState();
}

class _PharmacyFooterState extends State<PharmacyFooter> {
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
                context, MaterialPageRoute(builder: (context) => WelcomePharmacy()));
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
                context, MaterialPageRoute(builder: (context) => ReadPrescription()));
          },
          child: Text('Read Prescription'),
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
                context, MaterialPageRoute(builder: (context) => MyPharmacy()));
          },
          child: Text('My Pharmacy'),
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
                context, MaterialPageRoute(builder: (context) => PharmacyHistory()));
          },
          child: Text('History'),
        )
      ],
    );
  }
}
