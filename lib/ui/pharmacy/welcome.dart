import 'package:flutter/material.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/ui/doctor/consults/consults.dart';
import 'package:hepies/ui/doctor/consults/share_consult.dart';
import 'package:hepies/ui/doctor/drugs/drugs.dart';
import 'package:hepies/ui/doctor/points/points.dart';
import 'package:hepies/ui/pharmacy/ui/consults/share_consult.dart';
import 'package:provider/provider.dart';

class WelcomePharmacy extends StatefulWidget {
  final User user;
  final int currenIndex;
  WelcomePharmacy({this.user, this.currenIndex});
  @override
  _WelcomePharmacyState createState() => _WelcomePharmacyState();
}

class _WelcomePharmacyState extends State<WelcomePharmacy> {
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
      body: PharmacyShareConsult(),
    ));
  }
}
