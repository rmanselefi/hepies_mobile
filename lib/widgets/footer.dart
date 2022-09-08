
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hepius/constants.dart';
import 'package:hepius/ui/doctor/drugs/drugs.dart';
import 'package:hepius/ui/doctor/prescription/write_prescription.dart';
import 'package:hepius/ui/welcome.dart';

class Footer extends StatefulWidget {
  @override
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
                  size: width(context) * 0.065,
                ),
                onPressed: () async {
                  // await Provider.of<ConsultProvider>(context).switchSearch();

                  Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Welcome(
                                currenIndex: 0,
                              )));
                },
              ),
              AutoSizeText(
                '  Home',
                maxLines: 1,
                presetFontSizes: [13, 11, 9],
                style: TextStyle(fontSize: 11),
                textAlign: TextAlign.end,
              ),
            ],
          ),
          SizedBox(width: 3),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  file_signature,
                  color: Colors.black38,
                  size: width(context) * 0.065,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WritePrescription()));
                },
              ),
              AutoSizeText(
                'prescription',
                maxLines: 1,
                presetFontSizes: [13, 11, 9],
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
          SizedBox(width: 3),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  pills,
                  color: Colors.black38,
                  size: width(context) * 0.065,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Drugs()));
                },
              ),
              AutoSizeText(
                'Drugs',
                maxLines: 1,
                presetFontSizes: [13, 11, 9],
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ],
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
        