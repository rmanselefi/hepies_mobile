import 'package:flutter/material.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';

class DrugDetail extends StatefulWidget {
  final drug;
  DrugDetail(this.drug);
  @override
  _DrugDetailState createState() => _DrugDetailState();
}

class _DrugDetailState extends State<DrugDetail> {
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
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                        'Drug Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('---'),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.drug['name'],
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.0),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text('---'),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.drug['about'] != null
                                ? widget.drug['about']
                                : '',
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )),
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
