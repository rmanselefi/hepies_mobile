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
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    home_circled,
                    color: Colors.black38,
                    size: width(context) * 0.075,
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
                Text(
                  '  Home',
                  style: TextStyle(fontSize: 13),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
            SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    file_signature,
                    color: Colors.black38,
                    size: width(context) * 0.075,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WritePrescription()));
                  },
                ),
                Text('prescription', style: TextStyle(fontSize: 13)),
              ],
            ),
            SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    pills,
                    color: Colors.black38,
                    size: width(context) * 0.075,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Drugs()));
                  },
                ),
                Text('Drugs', style: TextStyle(fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



// GestureDetector(
//             child: Container(
//               width: width(context) * 0.20,
//               padding: EdgeInsets.all(7.5),
//               child: Center(child: Text('Home', textScaleFactor: 1.05)),
//               decoration: BoxDecoration(
//                 color: Color(0xff0FF6A0),
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => Welcome(
//                             currenIndex: 0,
//                           )));
//             },
//           ),
//           SizedBox(width: 10),
//           GestureDetector(
//             child: Container(
//               width: width(context) * 0.30,
//               padding: EdgeInsets.all(7.5),
//               child: Center(child: Text('Prescription', textScaleFactor: 1.05)),
//               decoration: BoxDecoration(
//                 color: Color(0xff0FF6A0),
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => WritePrescription()));
//             },
//           ),
//           SizedBox(width: 10),
//           GestureDetector(
//             child: Container(
//               width: width(context) * 0.20,
//               padding: EdgeInsets.all(7.5),
//               child: Center(child: Text('Drugs', textScaleFactor: 1.05)),
//               decoration: BoxDecoration(
//                 color: Color(0xff0FF6A0),
//                 shape: BoxShape.rectangle,
//                 borderRadius: BorderRadius.circular(5),
//               ),
//             ),
//             onTap: () {
//               Navigator.push(
//                   context, MaterialPageRoute(builder: (context) => Drugs()));
//             },
//           ),
        