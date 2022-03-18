import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hepies/providers/consult.dart';
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
    Widget customCard(int index) {
      return Container(
        height: 100,
        width: 200,
        child: ListTile(
          leading: Icon(Icons.person), // here you used image
          title: Text("title $index"),
          subtitle: Text("Subtitle $index"),
        ),
      );
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        //scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.home,
                    color: nav.selectedNav == NavSelection.home
                        ? Color(0xff0FF6A0)
                        : Colors.grey,
                    size: nav.selectedNav == NavSelection.home
                        ? width(context) * 0.0875
                        : width(context) * 0.0625,
                  ),
                  onPressed: () async {
                    nav.changeNavSelection(NavSelection.home);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomePharmacy()));
                  },
                ),
                AutoSizeText(
                  'Home',
                  maxLines: 1,
                  presetFontSizes: [13, 11, 9],
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
                        ? width(context) * 0.0875
                        : width(context) * 0.0625,
                  ),
                  onPressed: () {
                    nav.changeNavSelection(NavSelection.prescription);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ReadPrescription()));
                  },
                ),
                AutoSizeText(
                  'prescription',
                  maxLines: 1,
                  presetFontSizes: [13, 11, 9],
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
                        ? width(context) * 0.0875
                        : width(context) * 0.0625,
                  ),
                  onPressed: () {
                    nav.changeNavSelection(NavSelection.pharmacy);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyPharmacy()));
                  },
                ),
                AutoSizeText(
                  'My Pharmacy',
                  maxLines: 1,
                  presetFontSizes: [13, 11, 9],
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
                        ? width(context) * 0.0875
                        : width(context) * 0.0625,
                  ),
                  onPressed: () {
                    nav.changeNavSelection(NavSelection.history);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PharmacyHistory()));
                  },
                ),
                AutoSizeText(
                  'History',
                  maxLines: 1,
                  presetFontSizes: [13, 11, 9],
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
