import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart ' as timeago;

class PharmacyCommentList extends StatefulWidget {
  final List consults;
  PharmacyCommentList(this.consults);
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

  List<Widget> buildCommentSection() {
    List<Widget> comments = [];
    widget.consults.forEach((e) {
      DateTime time = DateTime.parse(e['createdAt']);
      var duration = timeago.format(time);
      print("timeago ${timeago.format(time).substring(0, 4)}");
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
              Icon(
                Icons.person,
                size: 50,
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
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.favorite_border))
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
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Column(
        children: buildCommentSection(),
      ),
    );
  }
}
