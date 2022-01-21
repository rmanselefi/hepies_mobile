import 'package:flutter/material.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/doctor/drugs/drugs.dart';
import 'package:hepies/ui/doctor/medicalrecords/medical_records.dart';
import 'package:hepies/ui/doctor/prescription/write_prescription.dart';
import 'package:hepies/ui/pharmacy/ui/consults/share_consult.dart';
import 'package:hepies/ui/pharmacy/ui/history/history.dart';
import 'package:hepies/ui/pharmacy/ui/mypharmacy/mypharmacy.dart';
import 'package:hepies/ui/pharmacy/ui/prescription/read_prescription.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:hepies/ui/welcome.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';

class PharmacyFooter extends StatefulWidget {
  @override
  _PharmacyFooterState createState() => _PharmacyFooterState();
}

class _PharmacyFooterState extends State<PharmacyFooter> {
  @override
  Widget build(BuildContext context) {
    UserProvider nav = Provider.of<UserProvider>(context);
    return Container(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    home_circled,
                    color: nav.selectedNav == NavSelection.home
                        ? Color(0xff0FF6A0)
                        : Colors.grey,
                    size: nav.selectedNav == NavSelection.home
                        ? width(context) * 0.1
                        : width(context) * 0.075,
                  ),
                  onPressed: () {
                    nav.changeNavSelection(NavSelection.home);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomePharmacy()));
                  },
                ),
                Text(
                  'Home',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontSize: 13,
                    color: nav.selectedNav == NavSelection.home
                        ? Color(0xff0FF6A0)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 5.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    file_signature,
                    color: nav.selectedNav == NavSelection.prescription
                        ? Color(0xff0FF6A0)
                        : Colors.grey,
                    size: nav.selectedNav == NavSelection.prescription
                        ? width(context) * 0.1
                        : width(context) * 0.075,
                  ),
                  onPressed: () {
                    nav.changeNavSelection(NavSelection.prescription);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReadPrescription()));
                  },
                ),
                Text(
                  'prescription',
                  style: TextStyle(
                    fontSize: 13,
                    color: nav.selectedNav == NavSelection.prescription
                        ? Color(0xff0FF6A0)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 5.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    pharmacy,
                    color: nav.selectedNav == NavSelection.pharmacy
                        ? Color(0xff0FF6A0)
                        : Colors.grey,
                    size: nav.selectedNav == NavSelection.pharmacy
                        ? width(context) * 0.1
                        : width(context) * 0.075,
                  ),
                  onPressed: () {
                    nav.changeNavSelection(NavSelection.pharmacy);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyPharmacy()));
                  },
                ),
                Text(
                  'My Pharmacy',
                  style: TextStyle(
                    fontSize: 13,
                    color: nav.selectedNav == NavSelection.pharmacy
                        ? Color(0xff0FF6A0)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 5.0,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    history,
                    color: nav.selectedNav == NavSelection.history
                        ? Color(0xff0FF6A0)
                        : Colors.grey,
                    size: nav.selectedNav == NavSelection.history
                        ? width(context) * 0.1
                        : width(context) * 0.075,
                  ),
                  onPressed: () {
                    nav.changeNavSelection(NavSelection.history);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PharmacyHistory()));
                  },
                ),
                Text(
                  'History',
                  style: TextStyle(
                    fontSize: 13,
                    color: nav.selectedNav == NavSelection.history
                        ? Color(0xff0FF6A0)
                        : Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum NavSelection { home, prescription, pharmacy, history }
