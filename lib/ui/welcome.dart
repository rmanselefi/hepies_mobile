import 'package:flutter/material.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/ui/consults/consults.dart';
import 'package:hepies/ui/consults/share_consult.dart';
import 'package:hepies/ui/drugs/drugs.dart';
import 'package:hepies/ui/points/points.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  final User user;
  final int currenIndex;
  Welcome({this.user, this.currenIndex});
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<DrugProvider>(context).getDrugs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: ShareConsult(),
    ));
  }
}
