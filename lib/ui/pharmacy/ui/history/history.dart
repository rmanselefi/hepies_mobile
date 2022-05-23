import 'package:flutter/material.dart';
import 'package:hepies/providers/pharmacy_provider.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PharmacyHistory extends StatefulWidget {
  @override
  _PharmacyHistoryState createState() => _PharmacyHistoryState();
}

class _PharmacyHistoryState extends State<PharmacyHistory> {
  @override
  Widget build(BuildContext context) {
    var pharmacyProvider =
        Provider.of<PharmacyProvider>(context, listen: false);
    UserProvider nav = Provider.of<UserProvider>(context);

    return WillPopScope(
      onWillPop: () {
        nav.changeNavSelection(NavSelection.home);
        Navigator.pop(context);
        return;
      },
      child: SafeArea(
          child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: ListView(
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Drug Name',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Patient Name',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    FutureBuilder(
                        future: pharmacyProvider.getMyPharmacyHistory(),
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
                            return ListView(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                children: snapshot.data.reversed.map<Widget>((e) {
                                  var date = new DateFormat.yMMMd().add_Hm()
                                      .format(DateTime.parse(e['readDate']));
                                  var name = e['patient']['name'] +
                                      " " +
                                      e['patient']['fathername'];
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          margin: EdgeInsets.only(left: 20),
                                          child: Text(
                                            e['drug_name'],
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 20),

                                          height: 30,
                                          child: Text(
                                            name,
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          margin: EdgeInsets.only(left: 20),

                                          child: Text(
                                            '$date',
                                            style: TextStyle(
                                              fontSize: 15.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }).toList());
                          }
                        }),
                  ],
                ),
              ),
            ),
            Center(child: PharmacyFooter())
          ],
        ),
      )),
    );
  }
}
