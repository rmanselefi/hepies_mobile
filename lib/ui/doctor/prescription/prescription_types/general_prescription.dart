import 'package:flutter/material.dart';
import 'package:hepies/models/consult.dart';
import 'package:hepies/models/dx.dart';
import 'package:hepies/models/hx.dart';
import 'package:hepies/models/px.dart';
import 'package:hepies/ui/doctor/prescription/forms/prescribe_form.dart';

class GeneralPrescription extends StatefulWidget {
  final color;
  final Function setPrescription;
  GeneralPrescription({this.color, this.setPrescription});

  @override
  _GeneralPrescriptionState createState() => _GeneralPrescriptionState();
}

class _GeneralPrescriptionState extends State<GeneralPrescription>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // return PrescribeForm(widget.setPrescription, 'general',Colors.white);
    return Container();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
