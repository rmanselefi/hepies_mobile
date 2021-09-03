import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConsultList extends StatefulWidget {
  final consults;
  ConsultList(this.consults);
  @override
  _ConsultListState createState() => _ConsultListState();
}

class _ConsultListState extends State<ConsultList> {
  @override
  Widget build(BuildContext context) {
    var consults = widget.consults;
    return Container(
      height: 2 * MediaQuery.of(context).size.height / 3,
      child: Column(
          children: consults.map<Widget>((e) {
            var date = DateFormat.yMMMd()
                .format(DateTime.parse(e['createdAt']));
            var hour = DateFormat.jm()
                .format(DateTime.parse(e['createdAt']));
            return Expanded(
              child: Card(
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Row(
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
                              e['topic'],
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
                        ],
                      ),
                    ],
                  ),
                ),
                margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
              ),
            );
          }).toList()),
    );
  }
}
