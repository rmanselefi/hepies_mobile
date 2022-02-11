import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/doctor/prescription/write_prescription.dart';
import 'package:hepies/util/database_helper.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class FavoritesPage extends StatefulWidget {
  final profession_id;
  FavoritesPage(this.profession_id);
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<FavoritesPage> {
  var favoriteController = new TextEditingController();
  void _openRenameForm(BuildContext context, Favorites favorite) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(16.0),
            content: new Row(
              children: <Widget>[
                new Expanded(
                  child: new TextFormField(
                    autofocus: true,
                    initialValue: favorite.name,
                    decoration: new InputDecoration(labelText: 'Rename'),
                    onChanged: (val) {
                      setState(() {
                        favorite.name = val;
                      });
                    },
                  ),
                )
              ],
            ),
            actions: <Widget>[
              new TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
              new TextButton(
                  child: const Text('Rename'),
                  onPressed: () async {
                    int res = await DatabaseHelper().updateFavorite(favorite);
                    if (res >= 1) {
                      setState(() {
                        DatabaseHelper().getFavoritesById(widget.profession_id);
                      });
                      Navigator.pop(context);
                      showTopSnackBar(
                        context,
                        CustomSnackBar.success(
                          message: "Favorite Renaming was successful",
                        ),
                      );
                    }
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var presProvider = Provider.of<PrescriptionProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: 50.0,
            ),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 500.0,
                          width: 400.0,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Color(0xff1FE533), width: 2.0)),
                          child: FutureBuilder<List<Favorites>>(
                              future: DatabaseHelper()
                                  .getFavoritesById(widget.profession_id),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else {
                                  if (snapshot.data == null ||
                                      snapshot.data.length == 0) {
                                    return Center(
                                      child: Text('No data to show'),
                                    );
                                  }
                                  var data = snapshot.data;
                                  final names = data.map((e) => e.name).toSet();
                                  data.retainWhere((x) => names.remove(x.name));
                                  return ListView.separated(
                                    itemCount: data.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) =>
                                            const Divider(),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return ListTile(
                                        title: GestureDetector(
                                          onTap: () async {
                                            List<dynamic> combinations =
                                                await DatabaseHelper()
                                                    .getFavoritesByName(
                                                        data[index].name);
                                            // for (var i = 0;
                                            //     i < combinations.length;
                                            //     i++) {}
                                            Provider.of<PrescriptionProvider>(
                                                    context,
                                                    listen: false)
                                                .resetStatus();
                                            presProvider
                                                .setFavoriteCombinations(
                                                    combinations);
                                            SchedulerBinding.instance
                                                .addPostFrameCallback((_) {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          WritePrescription(
                                                            from: "favorites",
                                                          )));
                                            });
                                          },
                                          child: Text(
                                            '${index + 1} ${data[index].name}',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 23.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        trailing: Container(
                                          width: 100.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                                child: Text('Rename'),
                                                onTap: () {
                                                  _openRenameForm(
                                                      context, data[index]);
                                                },
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      DatabaseHelper()
                                                          .deleteFavorite(
                                                              data[index].name);
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.cancel,
                                                    color: Colors.redAccent,
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              })),
                    ],
                  ),
                ],
              ),
            ),
            Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0))),
                child: Footer()),
          ],
        ),
      ),
    );
  }
}
