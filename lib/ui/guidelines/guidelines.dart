import 'package:flutter/material.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/guidelines.dart';
import 'package:hepies/widgets/header.dart';
import 'package:provider/provider.dart';

class Guidelines extends StatefulWidget {
  @override
  _GuidelinesState createState() => _GuidelinesState();
}

class _GuidelinesState extends State<Guidelines> {
  String drugName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Header(),
          SizedBox(
            height: 30.0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              child: TextField(
                onChanged: (val) {
                  var drugs =
                      Provider.of<GuidelinesProvider>(context, listen: false)
                          .guidelines;
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
              future: Provider.of<GuidelinesProvider>(context).getGuidelines(),
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

                  print("guidelinesguidelines ${snapshot.data}");
                  List<dynamic> drugs = snapshot.data
                      .where((element) => element['name'].contains(drugName))
                      .toList();
                  return Container(
                    height: 2 * MediaQuery.of(context).size.height / 3,
                    child: ListView(
                      shrinkWrap: true,
                      children: drugs.map<Widget>((e) {
                        return Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Provider.of<GuidelinesProvider>(context)
                                    .downloadFile(e['url']);
                              },
                              child: GestureDetector(
                                onTap: () {},
                                child: Container(
                                    width: 370,
                                    padding:
                                        EdgeInsets.only(left: 10.0, top: 10.0),
                                    child: Text(
                                      e['name'] != null ? e['name'] : '',
                                      style: TextStyle(
                                          fontSize: 20.0,
                                          decoration: TextDecoration.underline),
                                    )),
                              ),
                            ),
                            IconButton(
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(),
                                onPressed: () {},
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.redAccent,
                                ))
                          ],
                        );
                      }).toList(),
                    ),
                  );
                }
              })
        ],
      ),
    );
  }
}
