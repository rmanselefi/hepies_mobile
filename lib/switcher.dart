import 'package:flutter/material.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:hepies/ui/welcome.dart';
import 'package:provider/provider.dart';

class Switcher extends StatefulWidget {
  final user;
  Switcher({this.user});
  @override
  _SwitcherState createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher> {
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    var role = widget.user.role;
    userProvider.role = role;
    return role == 'doctor' || role == 'healthofficer' || role == 'nurse'
        ? Welcome(
            user: widget.user,
          )
        : WelcomePharmacy(user: widget.user);
  }
}
