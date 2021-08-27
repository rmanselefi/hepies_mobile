import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
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
  var favoriteController = new TextEditingController();
  String status = 'add';
  int pesIndex = 0;
  @override
  Widget build(BuildContext context) {
    var finaPrescription = widget.finaPrescription;
    var presType = widget.prescriptionType;
    return Container(
      height: 230.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]),
          color: Colors.lightBlueAccent[100]),
      child: Column(
        children: [
          Row(
            children: [
              finaPrescription.length != 0
                  ? MaterialButton(
                      color: Colors.green[400],
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('AlertDialog Title'),
                            content: TextFormField(
                              controller: favoriteController,
                              decoration:
                                  InputDecoration(hintText: 'Group name'),
                            ),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  var user = await UserPreferences().getUser();

                                  finaPrescription.forEach((element) async {
                                    Favorites favorites = new Favorites(
                                        drug_name: element['drug_name'],
                                        name: favoriteController.text,
                                        profession_id: user.professionid,
                                        route: element['route'],
                                        strength: element['strength'],
                                        unit: element['unit'],
                                        type: element['type'],
                                        frequency: element['frequency'],
                                        takein: element['takein']);

                                    var db = new DatabaseHelper();
                                    var res = await db.saveFavorites(favorites);
                                  });
                                  Navigator.pop(context, 'OK');
                                  Flushbar(
                                    title: 'Saved',
                                    message:
                                        'Your prescriptions are saved to favorites successfully',
                                    duration: Duration(seconds: 10),
                                  ).show(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Text('Add to favorites'),
                    )
                  : Container()
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          Expanded(
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
                              '${finaPrescription.indexOf(pres) + 1}. ${pres['material_name']} ${pres['size']}'),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              print("object $pres");
                              setState(() {
                                status = 'edit';
                                pesIndex = finaPrescription.indexOf(pres);
                              });
                              Provider.of<PrescriptionProvider>(context,
                                      listen: false)
                                  .setPrescriptionForm(pres);
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              var index =
                                  pesIndex = finaPrescription.indexOf(pres);
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
        ],
      ),
    );
  }
}
