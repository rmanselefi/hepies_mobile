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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Color(0xff0FF6A0)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.home_outlined,
                    color: Colors.black,
                    size: 16,
                  ),
                  Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              onPressed: () {
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
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Color(0xff0FF6A0)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.format_list_numbered_outlined,
                    color: Colors.black,
                    size: 16,
                  ),
                  Text(
                    'Prescription',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ReadPrescription()));
              },
            ),
            SizedBox(
              width: 5.0,
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Color(0xff0FF6A0)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.local_pharmacy_outlined,
                    color: Colors.black,
                    size: 16,
                  ),
                  Text(
                    'My Pharmacy',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyPharmacy()));
              },
            ),
            SizedBox(
              width: 5.0,
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateColor.resolveWith(
                    (states) => Color(0xff0FF6A0)),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.history_outlined,
                    color: Colors.black,
                    size: 16,
                  ),
                  Text(
                    'History',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PharmacyHistory()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
