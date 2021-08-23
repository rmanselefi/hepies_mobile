import 'package:flutter/material.dart';
import 'package:hepies/ui/prescription/forms/prescribe_form.dart';

class NarcoticPrescription extends StatefulWidget {
  final Function setPrescription;
  NarcoticPrescription({this.setPrescription});

  @override
  _NarcoticPrescriptionState createState() => _NarcoticPrescriptionState();
}

class _NarcoticPrescriptionState extends State<NarcoticPrescription> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrescribeForm(widget.setPrescription, 'narcotic', Color(0xffF211C5));
  }
}
