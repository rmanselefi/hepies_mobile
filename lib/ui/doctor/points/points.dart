import 'package:flutter/material.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:provider/provider.dart';

class Points extends StatefulWidget {
  final points;
  Points({this.points});

  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  @override
  Widget build(BuildContext context) {
    var points = Provider.of<UserProvider>(context).points;
    print("object $points");
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder<dynamic>(
                      future: Provider.of<UserProvider>(context).getProfile(),
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
                          var res = snapshot.data;
                          var point = res['profession'][0]['points'];
                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(60.0),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.green, width: 2),
                                  borderRadius: BorderRadius.circular(150.0)),
                              child: Text(
                                '$point Pts',
                                style: TextStyle(
                                    color: Colors.green, fontSize: 40.0),
                              ),
                            ),
                          );
                        }
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'But Air Time',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 25.0,
                          color: Colors.green),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(100.0)),
                        child: Text(
                          '50 Birr',
                          style: TextStyle(color: Colors.green, fontSize: 18.0),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 1),
                            borderRadius: BorderRadius.circular(100.0)),
                        child: Text(
                          '100 Birr',
                          style: TextStyle(color: Colors.green, fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'Transfer to other professional',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 25.0,
                          color: Colors.green),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Phone number',
                        style: TextStyle(fontSize: 25.0, color: Colors.green),
                      ),
                      Container(
                        height: 40,
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone Number',
                              hintText: 'Phone Number'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Amount',
                        style: TextStyle(fontSize: 25.0, color: Colors.green),
                      ),
                      Container(
                        height: 40,
                        width: 200,
                        child: TextField(
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Amount',
                              hintText: 'Amount'),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.green, width: 2),
                            borderRadius: BorderRadius.circular(100.0)),
                        child: Center(
                          child: Text(
                            'send',
                            style:
                                TextStyle(fontSize: 18.0, color: Colors.green),
                          ),
                        ),
                      ),
                    ),
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
