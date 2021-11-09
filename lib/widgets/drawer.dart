import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/ui/auth/change_password.dart';
import 'package:hepies/ui/auth/login.dart';
import 'package:provider/provider.dart';

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
          AppBar(
            automaticallyImplyLeading: false,
            title: Text("WorkenehApp"),
            backgroundColor: Color(0xff0FF683).withOpacity(0.9),
          ),
          Container(
            height: 10.0,
            color: Color(0xff0FF683).withOpacity(0.9),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.inbox,
                      color: Color(0xff00FFDC).withOpacity(0.9)),
                  title: Text(
                    'Contact Us',
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
                  leading: Icon(Icons.privacy_tip,
                      color: Color(0xff00FFDC).withOpacity(0.9)),
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
                Divider(
                  color: Color(0xff00FFDC).withOpacity(0.9),
                ),
                ListTile(
                  leading: Icon(Icons.person,
                      color: Color(0xff00FFDC).withOpacity(0.9)),
                  title: Text('Change Password',
                      style: TextStyle(color: Colors.black45)),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));
                  },
                ),
                Divider(
                  color: Color(0xff00FFDC).withOpacity(0.9),
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Color(0xff0FF683).withOpacity(0.9),
                  ),
                  title: Text('Logout', style: TextStyle(color: Colors.black45)),
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
