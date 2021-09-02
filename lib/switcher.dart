import 'package:flutter/material.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:hepies/ui/welcome.dart';

class Switcher extends StatefulWidget {
  final user;
  Switcher({this.user});
  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  Widget build(BuildContext context) {
    return widget.user.role == 'doctor'
        ? Welcome(
            user: widget.user,
          )
        : WelcomePharmacy();
  }
}
