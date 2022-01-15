import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          // MaterialButton(
          //   color: Color(0xff0FF6A0),
          //   elevation: 0.0,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12), // <-- Radius
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //             builder: (context) => Welcome(
          //                   currenIndex: 0,
          //                 )));
          //   },
          //   child: Text(
          //     'Home',
          //   ),
          // ),
          // SizedBox(
          //   width: 5.0,
          // ),
          // MaterialButton(
          //   minWidth: 50.0,
          //   elevation: 0.0,
          //   color: Color(0xff0FF6A0),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12), // <-- Radius
          //   ),
          //   onPressed: () {
          //     Navigator.push(context,
          //         MaterialPageRoute(builder: (context) => WritePrescription()));
          //   },
          //   child: Text(
          //     'Prescription',
          //   ),
          // ),
          // SizedBox(
          //   width: 5.0,
          // ),
          // // MaterialButton(
          // //   minWidth: 50.0,
          // //   elevation: 0.0,
          // //   color: Color(0xff0FF6A0),
          // //   shape: RoundedRectangleBorder(
          // //     borderRadius: BorderRadius.circular(12), // <-- Radius
          // //   ),
          // //   onPressed: () {
          // //     Navigator.push(
          // //         context, MaterialPageRoute(builder: (context) => MedicalRecord()));
          // //   },
          // //   child: Text('Medical Records'),
          // // ),
          // MaterialButton(
          //   minWidth: 50.0,
          //   elevation: 0.0,
          //   color: Color(0xff0FF6A0),
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(12), // <-- Radius
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //         context, MaterialPageRoute(builder: (context) => Drugs()));
          //   },
          //   child: Text(
          //     'Drugs',
          //   ),
          // ),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Color(0xff0FF6A0)),
            ),
            child: Icon(
              Icons.home_outlined,
              color: Colors.black,
              size: width(context) * 0.1,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Welcome(
                            currenIndex: 0,
                          )));
            },
          ),
          SizedBox(width: 10),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Color(0xff0FF6A0)),
            ),
            child: Icon(
              IconData(0xe800, fontFamily: 'MyFlutterApp', fontPackage: null),
              color: Colors.black,
              size: width(context) * 0.1,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WritePrescription()));
            },
          ),
          SizedBox(width: 10),
          OutlinedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateColor.resolveWith((states) => Color(0xff0FF6A0)),
            ),
            child: Icon(
              Icons.medical_services_outlined,
              color: Colors.black,
              size: width(context) * 0.1,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Drugs()));
            },
          ),
        ],
      ),
    );
  }
}
