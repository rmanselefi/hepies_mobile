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

import '../../../constants.dart';

class PharmacyFooter extends StatefulWidget {
  @override
  _PharmacyFooterState createState() => _PharmacyFooterState();
}

class _PharmacyFooterState extends State<PharmacyFooter> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              child: Container(
                width: width(context) * 0.30,
                padding: EdgeInsets.all(7.5),
                child: Center(child: Text('Home', textScaleFactor: 1.05)),
                decoration: BoxDecoration(
                  color: Color(0xff0FF6A0),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => WelcomePharmacy()));
              },
            ),
//          MaterialButton(
//            color: Color(0xff0FF6A0),
//            minWidth: 50.0,
//            elevation: 0.0,
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(12), // <-- Radius
//            ),
//            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => WelcomePharmacy()));
//            },
//            child: Text('Home'),
//          ),
            SizedBox(
              width: 5.0,
            ),
            GestureDetector(
              child: Container(
                width: width(context) * 0.30,
                padding: EdgeInsets.all(7.5),
                child: Center(child: Text('Prescription', textScaleFactor: 1.05)),
                decoration: BoxDecoration(
                  color: Color(0xff0FF6A0),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ReadPrescription()));
              },
            ),
//          MaterialButton(
//            minWidth: 50.0,
//            elevation: 0.0,
//            color: Color(0xff0FF6A0),
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(12), // <-- Radius
//            ),
//            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => ReadPrescription()));
//            },
//            child: Text('Read Prescription'),
//          ),
            SizedBox(
              width: 5.0,
            ),
            GestureDetector(
              child: Container(
                width: width(context) * 0.30,
                padding: EdgeInsets.all(7.5),
                child: Center(child: Text('My Pharmacy', textScaleFactor: 1.05)),
                decoration: BoxDecoration(
                  color: Color(0xff0FF6A0),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPharmacy()));
              },
            ),
//          MaterialButton(
//            minWidth: 50.0,
//            elevation: 0.0,
//            color: Color(0xff0FF6A0),
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(12), // <-- Radius
//            ),
//            onPressed: () {
//              Navigator.push(
//                  context, MaterialPageRoute(builder: (context) => MyPharmacy()));
//            },
//            child: Text('My Pharmacy'),
//          ),
            SizedBox(
              width: 5.0,
            ),
            GestureDetector(
              child: Container(
                width: width(context) * 0.30,
                padding: EdgeInsets.all(7.5),
                child: Center(child: Text('History', textScaleFactor: 1.05)),
                decoration: BoxDecoration(
                  color: Color(0xff0FF6A0),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PharmacyHistory()));
              },
            ),
//          MaterialButton(
//            minWidth: 50.0,
//            elevation: 0.0,
//            color: Color(0xff0FF6A0),
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(12), // <-- Radius
//            ),
//            onPressed: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => PharmacyHistory()));
//            },
//            child: Text('History'),
//          )
          ],
        ),
      ),
    );
  }
}

