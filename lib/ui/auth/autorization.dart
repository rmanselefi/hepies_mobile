import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:linkify_text/linkify_text.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthorizationPage extends StatelessWidget {
  final String profession, name, fatherName;
  const AuthorizationPage({this.profession, this.name, this.fatherName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Congratulations! $profession $name $fatherName',
                textScaleFactor: 1.1,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  'You have successfully registered on Hepius! We are now authenticating your submitted information. This process may take up to 36hrs to complete.',
                  textScaleFactor: 1.1,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15.0)),
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
      ),
    );
  }
}
