import 'package:flutter/material.dart';
import 'package:hepies/models/dx.dart';
import 'package:hepies/models/hx.dart';
import 'package:hepies/models/px.dart';
import 'package:hepies/ui/prescription/forms/prescribe_form.dart';

class GeneralPrescription extends StatefulWidget {
  final History history;
  final Diagnosis diagnosis;
  final Physical physical;
  final Function setPrescription;
  GeneralPrescription(
      {this.physical, this.diagnosis, this.history, this.setPrescription});

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
    return PrescribeForm(widget.setPrescription, 'general');
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
