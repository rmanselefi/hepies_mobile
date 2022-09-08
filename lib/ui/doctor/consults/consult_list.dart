import 'package:flutter/material.dart';
import 'package:hepius/providers/consult.dart';
import 'package:hepius/ui/doctor/consults/comment/share_comment.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    return Column(
        children: consults.map<Widget>((e) {
      var date = DateFormat.yMMMd().format(DateTime.parse(e['createdAt']));
      var hour = DateFormat.jm().format(DateTime.parse(e['createdAt']));
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
                      ? Expanded(
                          child: Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(e['image']),
                                  fit: BoxFit.fill),
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
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          e['topic'],
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          '${e['user']} ${date} ${hour}',
                          style: TextStyle(fontSize: 15.0, color: Colors.grey),
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
              Expanded(
                child: Row(
                  children: [
                    SizedBox(
                      width: 5.0,
                    ),
                    Row(
                      children: [
                        FutureBuilder<dynamic>(
                            future: Provider.of<ConsultProvider>(context,
                                    listen: false)
                                .getLikeByConsultIdForUser(e['id']),
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
                                return snapshot.data['length'] > 0
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          TextButton.icon(
                                              onPressed: () async {
                                                var res = await Provider.of<
                                                            ConsultProvider>(
                                                        context,
                                                        listen: false)
                                                    .unlikeConsult(e['id']);
                                                if (res['status']) {
                                                  setState(() {
                                                    Provider.of<ConsultProvider>(
                                                            context,
                                                            listen: false)
                                                        .getLikeByConsultIdForUser(
                                                            e['id']);
                                                  });
                                                }
                                              },
                                              icon: Icon(
                                                Icons.favorite,
                                                color: Colors.red,
                                              ),
                                              label: Text(snapshot.data['likes']
                                                  .toString())),
                                        ],
                                      )
                                    : TextButton.icon(
                                        onPressed: () async {
                                          var res = await Provider.of<
                                                      ConsultProvider>(context,
                                                  listen: false)
                                              .likeConsult(e['id']);
                                          if (res['status']) {
                                            setState(() {
                                              Provider.of<ConsultProvider>(
                                                      context,
                                                      listen: false)
                                                  .getLikeByConsultIdForUser(
                                                      e['id']);
                                            });
                                          }
                                        },
                                        icon: Icon(Icons.favorite_border),
                                        label: Text(
                                            snapshot.data['likes'].toString()));
                              }
                            })
                      ],
                    ),
                    TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShareComment(e['id'])));
                        },
                        label: e['comment'].length > 0
                            ? Text('${e['comment'].length} Comments')
                            : Text('Comments'),
                        icon: Icon(Icons.comment))
                  ],
                ),
              )
            ],
          ),
        ),
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
      );
    }).toList());
  }
}
