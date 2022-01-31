import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:linkify_text/linkify_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AutorizationPage extends StatelessWidget {
  final String profession, name, fatherName;
  const AutorizationPage({this.profession, this.name, this.fatherName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Center(
        child: Column(
          children: [
            Text(
              'Congratulations! ${profession + name + fatherName}',
              textScaleFactor: 1.1,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'You have successfully registered on Hepius! We are now authenticating your submitted information. This process may take up to 36hrs to complete.',
            ),
            LinkifyText(
              'If you are not authorized within the specified time, Please contact us on contact@Hepius.co or CALL ',
              linkColor: Colors.blue,
            ),
            Row(
              children: [
                Text('CALL'),
                TextButton(
                  onPressed: () {
                    launch('+251965717111');
                  },
                  child: Text(' +251965717111 '),
                ),
                Text('for more. Thank You!'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
