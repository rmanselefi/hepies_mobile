import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/ui/auth/change_password.dart';
import 'package:hepies/ui/auth/login.dart';
import 'package:provider/provider.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerCustom extends StatefulWidget {
  DrawerCustom();

  @override
  _DrawerCustomState createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String imageMessage = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: height(context) * 0.25,
            padding: EdgeInsets.all(5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: width(context) * 0.15,
                  backgroundColor: Colors.grey,
                ),
                SizedBox(height: 5),
                Text(
                  '     User',
                  textScaleFactor: 1.1,
                ),
                Text('      www.qemer.com',
                    style: TextStyle(color: Colors.black45)),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.inbox, color: Color(0xff0FF6A0)),
                  title: Text(
                    'Contact Us',
                    style: TextStyle(color: Colors.black45),
                  ),
                  onTap: () async {
                    // Milkessa: Implemented intent to email with nice formatting
                    final mailtoLink = Mailto(
                      to: ['to@example.com'],
                      cc: ['cc1@example.com', 'cc2@example.com'],
                      subject: 'mailto example subject',
                      body: 'mailto example body',
                    );
                    await launch('$mailtoLink');
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ContactUs()),
                    // );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip, color: Color(0xff0FF6A0)),
                  title: Text(
                    'Privacy Policy and Terms and Conditions',
                    style: TextStyle(color: Colors.black45),
                  ),
                  onTap: () {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ContactUs()),
                    // );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Color(0xff0FF6A0)),
                  title: Text('Change Password',
                      style: TextStyle(color: Colors.black45)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Color(0xff0FF6A0),
                  ),
                  title:
                      Text('Logout', style: TextStyle(color: Colors.black45)),
                  onTap: () async {
                    await Provider.of<AuthProvider>(context, listen: false)
                        .logout();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
