import 'package:flutter/material.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/util/database_helper.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class PsychoNarcoPaper extends StatefulWidget {
  final finaPrescription;
  PsychoNarcoPaper(this.finaPrescription);

  @override
  _PrescriptionPaperState createState() => _PrescriptionPaperState();
}

class _PrescriptionPaperState extends State<PsychoNarcoPaper> {
  var favoriteController = new TextEditingController();
  String status = 'add';
  int pesIndex = 0;
  @override
  Widget build(BuildContext context) {
    var finaPrescription = widget.finaPrescription;

    return Container(
      height: 230.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[200]), color: Colors.grey[100]),
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
                                        strength: element['strength']);

                                    var db = new DatabaseHelper();
                                    var res = await db.saveFavorites(favorites);
                                  });
                                  Navigator.pop(context, 'OK');

                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.success(
                                      message:
                                          "Your prescriptions are saved to favorites successfully",
                                    ),
                                  );
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: finaPrescription.map<Widget>((pres) {
              return Row(
                children: [
                  Expanded(
                    child: Text(
                        '${finaPrescription.indexOf(pres) + 1}. ${pres['drug_name']} ${pres['strength']} ${pres['unit']} ${pres['route']} Every ${pres['frequency']} For ${pres['takein']}'),
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
                                .setPrescriptionForm(
                                    pres, finaPrescription.indexOf(pres));
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
        ],
      ),
    );
  }
}
