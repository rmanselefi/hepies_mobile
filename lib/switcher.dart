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
    var role = widget.user.role;
    return role == 'doctor' || role == 'healthofficer' || role == 'nurse'
        ? Welcome(
            user: widget.user,
          )
        : WelcomePharmacy(user: widget.user);
  }
}
