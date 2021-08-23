import 'package:flutter/material.dart';
import 'package:hepies/ui/prescription/forms/prescribe_form.dart';

class InstrumentPrescription extends StatefulWidget {
  final Function setPrescription;
  InstrumentPrescription({this.setPrescription});
  @override
  _InstrumentPrescriptionState createState() => _InstrumentPrescriptionState();
}

class _InstrumentPrescriptionState extends State<InstrumentPrescription> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PrescribeForm(widget.setPrescription, 'instrument', Colors.blue);
  }
}
