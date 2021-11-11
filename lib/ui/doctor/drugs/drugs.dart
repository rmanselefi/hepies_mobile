import 'package:flutter/material.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/ui/doctor/drugs/drug_detail.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:provider/provider.dart';

class Drugs extends StatefulWidget {
  @override
  _DrugsState createState() => _DrugsState();
}

class _DrugsState extends State<Drugs> {
  String drugName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      child: TextField(
                        onChanged: (val) {
                          var drugs =
                              Provider.of<DrugProvider>(context, listen: false)
                                  .drugs;
                          var drug = setState(() {
                            drugName = val;
                          });
                        },
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            prefixIcon: Icon(Icons.search),
                            filled: true,
                            hintStyle: TextStyle(color: Colors.grey[800]),
                            hintText: "Search",
                            fillColor: Colors.white70),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  FutureBuilder<List<dynamic>>(
                      future: Provider.of<DrugProvider>(context).getDrugs(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data == null) {
                            return Center(
                              child: Text('No data to show'),
                            );
                          }

                          print("objectobjectobject ${snapshot.data}");
                          List<dynamic> drugs = snapshot.data
                              .where((element) => element['name'].startsWith(
                                  drugName)) // Milkessa: 'contains' was changed to 'startsWith'
                              .toList();
                          return Container(
                            height: 2 * MediaQuery.of(context).size.height / 3,
                            child: ListView(
                              shrinkWrap: true,
                              children: drugs.map<Widget>((e) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                DrugDetail(e)));
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        e['name'] != null ? e['name'] : '',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            decoration:
                                                TextDecoration.underline),
                                      )),
                                );
                              }).toList(),
                            ),
                          );
                        }
                      }),
                ],
              ),
            ),
            Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0))),
                child: Footer())
          ],
        ),
      ),
    );
  }
}
