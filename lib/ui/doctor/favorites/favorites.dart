import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/doctor/prescription/write_prescription.dart';
import 'package:hepies/util/database_helper.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatefulWidget {
  final profession_id;
  FavoritesPage(this.profession_id);
  @override
  _FavoritesState createState() => _FavoritesState();
}

class _FavoritesState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    var presProvider = Provider.of<PrescriptionProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
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
                          height: 600.0,
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
                                      return GestureDetector(
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
                                          presProvider.setFavoriteCombinations(
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
                                        child: ListTile(
                                          title: Text(
                                            '${index + 1} ${data[index].name}',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                fontSize: 23.0,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          trailing: Container(
                                            width: 100.0,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Text('Rename'),
                                                IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        DatabaseHelper()
                                                            .deleteFavorite(
                                                                data[index]
                                                                    .name);
                                                      });
                                                    },
                                                    icon: Icon(
                                                      Icons.cancel,
                                                      color: Colors.redAccent,
                                                    ))
                                              ],
                                            ),
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
