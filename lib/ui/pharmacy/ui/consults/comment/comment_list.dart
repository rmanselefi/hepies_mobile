import 'package:flutter/material.dart';
import 'package:hepies/providers/consult.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class PharmacyCommentList extends StatefulWidget {
  final user_id;
  final consultId;
  PharmacyCommentList(this.user_id, this.consultId);
  @override
  _PharmacyConsultListState createState() => _PharmacyConsultListState();
}

class _PharmacyConsultListState extends State<PharmacyCommentList> {
  ScrollController _scrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  List<Widget> buildCommentSection(consults) {
    List<Widget> comments = [];
    consults.forEach((e) {
      print("widgetwidgetwidget ${e['like']}");
      var res = e['like'].where((l) => l['user_id'] == widget.user_id).toList();
      DateTime time = DateTime.parse(e['createdAt']);
      var profile = e['user']['profession'][0]['profile'];
      var duration = timeago.format(time);
      comments.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
          margin: EdgeInsets.only(bottom: 0.0, top: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 5.0,
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    child: profile != null
                        ? Image.network(profile)
                        : Icon(
                            Icons.person,
                            size: 40,
                          )),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color(0xffeeeee4)),
                  child: Column(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  "${e['author']} ",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(duration)
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: Text(
                              e['comment'],
                              style: TextStyle(
                                fontSize: 15.0,
                              ),
                            ),
                          ),
                          e['image'] != null
                              ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  child: Image.network(
                                    e['image'],
                                    fit: BoxFit.contain,
                                  ),
                                )
                              : Container(
                                  height: 0.0,
                                  width: 0.0,
                                ),
                        ],
                      ),
                      Divider(),
                      Row(
                        children: [
                          SizedBox(
                            width: 5.0,
                          ),
                          Row(
                            children: [
                              res.length > 0
                                  ? IconButton(
                                      onPressed: () async {
                                        var result = await ConsultProvider()
                                            .unlikeComment(e['id']);
                                        if (result['status']) {
                                          setState(() {
                                            Provider.of<ConsultProvider>(
                                                    context,listen: false)
                                                .getCommentByConsultId(
                                                    widget.consultId);
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      ))
                                  : IconButton(
                                      onPressed: () async {
                                        var result = await ConsultProvider()
                                            .likeComment(e['id']);
                                        if (result['status']) {
                                          setState(() {
                                            Provider.of<ConsultProvider>(
                                                    context,listen: false)
                                                .getCommentByConsultId(
                                                    widget.consultId);
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        Icons.favorite_border,
                                      ))
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        ),
      );
    });
    return comments;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
        future: Provider.of<ConsultProvider>(context)
            .getCommentByConsultId(widget.consultId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data == null || snapshot.data.length == 0) {
              return Center(
                child: Text('No comment under this consult'),
              );
            }

            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: Column(
                children: buildCommentSection(snapshot.data),
              ),
            );
          }
        });
  }
}
