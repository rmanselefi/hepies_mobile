import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PharmacyCommentList extends StatefulWidget {
  final consults;
  PharmacyCommentList(this.consults);
  @override
  _PharmacyConsultListState createState() => _PharmacyConsultListState();
}

class _PharmacyConsultListState extends State<PharmacyCommentList> {
  @override
  Widget build(BuildContext context) {
    var consults = widget.consults;
    return Column(
        children: consults.map<Widget>((e) {
          var date = DateFormat.yMMMd()
              .format(DateTime.parse(e['createdAt']));
          var hour = DateFormat.jm()
              .format(DateTime.parse(e['createdAt']));
          return Card(
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      e['image'] != null
                          ? Container(
                        width: 130,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(e['image']),
                              fit: BoxFit.fill
                          ),
                        ),
                      )
                          : Container(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              'News',
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              e['comment'],
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Text(
                              'Medscape brief ${date} ${hour}',
                              style:
                              TextStyle(fontSize: 15.0, color: Colors.grey),
                            ),
                          ),
                          Divider(
                            height: 5.0,
                            color: Colors.black26,
                          ),
                          SizedBox(
                            height: 20.0,
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Divider(),
                  Row(
                    children: [
                      SizedBox(
                        width: 5.0,
                      ),
                      Row(
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border))
                        ],
                      ),
                    ],
                  )

                ],
              ),
            ),
            margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
          );
        }).toList());
  }
}
