import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/util/database_helper.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:provider/provider.dart';

class PrescriptionPaper extends StatefulWidget {
  final finaPrescription;
  final prescriptionType;
  PrescriptionPaper(this.finaPrescription, this.prescriptionType);

  @override
  _PrescriptionPaperState createState() => _PrescriptionPaperState();
}

class _PrescriptionPaperState extends State<PrescriptionPaper> {
  String status = 'add';
  int pesIndex = 0;
  @override
  Widget build(BuildContext context) {
    var finaPrescription = widget.finaPrescription;
    var presType = widget.prescriptionType;
    return Flexible(
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            color: Colors.grey[100]),
        child: ListView(
          children: finaPrescription.map<Widget>((pres) {
            return Row(
              children: [
                Expanded(
                  child: pres['type'] == "general"
                      ? Text(
                          '${finaPrescription.indexOf(pres) + 1}. ${pres['drug_name']} ${pres['strength']} '
                          '${pres['unit']} ${pres['route']} Every ${pres['frequency']} For ${pres['takein']}')
                      : Text(
                          '${finaPrescription.indexOf(pres) + 1}. ${pres['material_name']} ${pres['size']} ${pres['amount']}'),
                ),
                Expanded(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          print("object $pres");

                          Provider.of<PrescriptionProvider>(context,
                                  listen: false)
                              .setPrescriptionForm(
                                  pres, finaPrescription.indexOf(pres));
                        },
                        icon: Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          var index = pesIndex = finaPrescription.indexOf(pres);
                          setState(() {
                            finaPrescription.removeAt(index);
                          });
                        },
                        icon: Icon(Icons.cancel),
                        padding: EdgeInsets.all(0.0),
                        iconSize: 20.0,
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
