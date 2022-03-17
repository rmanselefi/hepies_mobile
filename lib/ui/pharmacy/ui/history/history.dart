import 'package:flutter/material.dart';
import 'package:hepies/providers/pharmacy_provider.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/ui/pharmacy/widgets/header.dart';
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
              padding: const EdgeInsets.all(15.0),
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
                        padding: EdgeInsets.only(left: 5.0),
                      ),
                      Text(
                        'Patient Name',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Date',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
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
                              children: snapshot.data.map<Widget>((e) {
                                var date = new DateFormat.yMMMd()
                                    .format(DateTime.parse(e['readDate']));
                                var name = e['patient']['name'] +
                                    " " +
                                    e['patient']['fathername'];
                                return Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        e['drug_name'],
                                        style: TextStyle(
                                          fontSize: 15.0,
                                        ),
                                      ),
                                      width: 150,
                                    ),
                                    Text(
                                      name,
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                    Text(
                                      '$date',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList());
                        }
                      }),
                ],
              ),
            )),
            Center(child: PharmacyFooter())
          ],
        ),
      )),
    );
  }
}
