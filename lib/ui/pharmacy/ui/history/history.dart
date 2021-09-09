import 'package:flutter/material.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/ui/pharmacy/widgets/header.dart';

class PharmacyHistory extends StatefulWidget {

  @override
  _PharmacyHistoryState createState() => _PharmacyHistoryState();
}

class _PharmacyHistoryState extends State<PharmacyHistory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Column(
        children: [
          Header(),
          Expanded(child: ListView(
            children: [

            ],
          )),
          PharmacyFooter()
        ],
      ),
    ));
  }
}
