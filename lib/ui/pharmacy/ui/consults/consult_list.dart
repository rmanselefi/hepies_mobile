import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/ui/pharmacy/ui/consults/comment/share_comment.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;

class PharmacyConsultList extends StatefulWidget {
  final consults;
  PharmacyConsultList(this.consults);
  @override
  _PharmacyConsultListState createState() => _PharmacyConsultListState();
}

class _PharmacyConsultListState extends State<PharmacyConsultList> {
  ScrollController _scrollController;

  Widget rowSingleButton(
      {String name, dynamic iconImage, Color color, bool isHover}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
      decoration: BoxDecoration(
          color: isHover ? Colors.black.withOpacity(.1) : Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(4))),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            child: Icon(
              iconImage,
              color: color,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _rowButton(var e) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FutureBuilder<dynamic>(
              future: Provider.of<ConsultProvider>(context, listen: false)
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
                  print("snapshot.data ${snapshot.data}");
                  return snapshot.data['length'] > 0
                      ? BouncingWidget(
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          onPressed: () async {
                            var res = await Provider.of<ConsultProvider>(
                                    context,
                                    listen: false)
                                .unlikeConsult(e['id']);
                            if (res['status']) {
                              setState(() {
                                Provider.of<ConsultProvider>(context,
                                        listen: false)
                                    .getLikeByConsultIdForUser(e['id']);
                              });
                            }
                          },
                          child: rowSingleButton(
                              color: Colors.redAccent,
                              name: "Like",
                              iconImage: Icons.thumb_up_sharp,
                              isHover: false),
                        )
                      : BouncingWidget(
                          duration: Duration(milliseconds: 100),
                          scaleFactor: 1.5,
                          onPressed: () async {
                            var res = await Provider.of<ConsultProvider>(
                                    context,
                                    listen: false)
                                .likeConsult(e['id']);
                            if (res['status']) {
                              setState(() {
                                Provider.of<ConsultProvider>(context,
                                        listen: false)
                                    .getLikeByConsultIdForUser(e['id']);
                              });
                            }
                          },
                          child: rowSingleButton(
                              color: Colors.black,
                              name: "Like",
                              iconImage: Icons.thumb_up_outlined,
                              isHover: false),
                        );
                }
              }),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PharmacyShareComment(e['id'])));
            },
            child: rowSingleButton(
                color: Colors.black,
                name: "Comment",
                iconImage: Icons.comment,
                isHover: false),
          ),
        ],
      ),
    );
  }

  Widget _listPostWidget() {
    return Expanded(
        child: MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.consults.length,
        itemBuilder: (BuildContext context, int index) {
          var e = widget.consults[index];
          var date = DateFormat.yMMMd().format(DateTime.parse(e['createdAt']));
          var hour = DateFormat.jm().format(DateTime.parse(e['createdAt']));
          DateTime time = DateTime.parse(e['createdAt']);
          var duration = timeago.format(time).substring(0, 4);
          print("timeago ${timeago.format(time).substring(0, 4)}");
          return Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
            margin: EdgeInsets.only(bottom: 0.0, top: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(color: Colors.black54, width: 0.50),
                    bottom: BorderSide(color: Colors.black54, width: 0.50))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(40))),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          child: Icon(
                            Icons.person,
                            size: 40,
                          )),
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.consults[index]['user'],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 1.24,
                          child: Text(
                            "Doctor",
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text('$duration',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black54))
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  widget.consults[index]['topic'],
                  style: TextStyle(fontSize: 14),
                ),
                // Text(
                //   _post[index].tags,
                //   style: TextStyle(color: blueColor),
                // ),
                SizedBox(
                  height: 10,
                ),
                widget.consults[index]['image'] != null
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          widget.consults[index]['image'],
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(
                        height: 0.0,
                        width: 0.0,
                      ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
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
                                  print("snapshot.data ${snapshot.data}");
                                  return TextButton.icon(
                                      onPressed: () async {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    PharmacyShareComment(
                                                        e['id'])));
                                      },
                                      icon: Icon(
                                        Icons.thumb_up_sharp,
                                        color: Colors.blueAccent,
                                        size: 15,
                                      ),
                                      label: Text(
                                          "${snapshot.data['likes'].toString()} likes"));
                                }
                              }),

                          // Container(
                          //     width: 25,
                          //     height: 25,
                          //     child: Icon(Icons.favorite)),

                          SizedBox(
                            width: 5,
                          ),
                          // Text(
                          //   _post[index].likes,
                          //   style: TextStyle(fontSize: 14),
                          // )
                        ],
                      ),
                    ),
                    FutureBuilder<int>(
                        future:
                            Provider.of<ConsultProvider>(context, listen: false)
                                .getCommentsByConsultId(e['id']),
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
                            return Row(
                              children: [
                                Text(snapshot.data.toString()),
                                Text(" comments")
                              ],
                            );
                            // return TextButton.icon(
                            //     onPressed: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) =>
                            //                   PharmacyShareComment(e['id'])));
                            //     },
                            //     label:
                            //     icon: Icon(Icons.comment));
                          }
                        })
                  ],
                ),
                Divider(
                  thickness: 0.50,
                  color: Colors.black26,
                ),
                _rowButton(e),
              ],
            ),
          );
        },
      ),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    var consults = widget.consults;
    return _listPostWidget();
    // return ListView.separated(
    //   shrinkWrap: true,
    //   itemCount: consults.length,
    //   separatorBuilder: (BuildContext context, int index) => const SizedBox(
    //     height: 10.0,
    //   ),
    //   itemBuilder: (BuildContext context, int index) {
    //     var e = consults[index];
    //     var date = DateFormat.yMMMd().format(DateTime.parse(e['createdAt']));
    //     var hour = DateFormat.jm().format(DateTime.parse(e['createdAt']));
    //     return Container(
    //       height: 300,
    //       padding: EdgeInsets.only(left: 10.0),
    //       decoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(15.0),
    //           border: Border.all(color: Colors.grey, width: 0.5)),
    //       child: Column(
    //         children: [
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               e['image'] != null
    //                   ? Expanded(
    //                       child: Container(
    //                         width: 130,
    //                         height: 130,
    //                         decoration: BoxDecoration(
    //                           image: DecorationImage(
    //                               image: NetworkImage(e['image']),
    //                               fit: BoxFit.fill),
    //                         ),
    //                       ),
    //                     )
    //                   : Container(),
    //               Expanded(
    //                 child: Container(
    //                   height: 200.0,
    //                   child: Column(
    //                     mainAxisAlignment: MainAxisAlignment.start,
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: [
    //                       Column(
    //                         children: [
    //                           Padding(
    //                             padding: const EdgeInsets.only(left: 5.0),
    //                             child: Text(
    //                               '${e['user']}',
    //                               style: TextStyle(
    //                                   fontSize: 18.0,
    //                                   fontWeight: FontWeight.bold),
    //                             ),
    //                           ),
    //                           Text(' ${date} ${hour}')
    //                         ],
    //                       ),
    //                       new Container(
    //                           width: MediaQuery.of(context).size.width - 40.0,
    //                           padding: EdgeInsets.only(left: 10.0),
    //                           child: Row(
    //                             children: <Widget>[
    //                               Expanded(
    //                                 child: ReadMoreText(
    //                                   e['topic'],
    //                                   trimLines: 2,
    //                                   colorClickableText: Colors.pink,
    //                                   trimMode: TrimMode.Line,
    //                                   trimCollapsedText: 'Show more',
    //                                   trimExpandedText: 'Show less',
    //                                   moreStyle: TextStyle(
    //                                       fontSize: 14,
    //                                       fontWeight: FontWeight.bold),
    //                                 ),
    //                               ),
    //                               // Expanded(
    //                               //   child: new Text(
    //                               //     e['topic'],
    //                               //     style: TextStyle(
    //                               //       fontSize: 18.0,
    //                               //     ),
    //                               //   ),
    //                               // ),
    //                               Container(
    //                                 width: 20.0,
    //                               )
    //                             ],
    //                           )),
    //                     ],
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //           SizedBox(
    //             height: 10.0,
    //           ),
    //           Divider(),
    //           Expanded(
    //             child: Container(
    //               height: 40.0,
    //               margin: EdgeInsets.only(top: 20.0),
    //               child: Row(
    //                 children: [
    //                   SizedBox(
    //                     width: 5.0,
    //                   ),
    //                   Row(
    //                     children: [
    //                       FutureBuilder<dynamic>(
    //                           future: Provider.of<ConsultProvider>(context,
    //                                   listen: false)
    //                               .getLikeByConsultIdForUser(e['id']),
    //                           builder: (context, snapshot) {
    //                             if (!snapshot.hasData) {
    //                               return Center(
    //                                 child: CircularProgressIndicator(),
    //                               );
    //                             } else {
    //                               if (snapshot.data == null) {
    //                                 return Center(
    //                                   child: Text('No data to show'),
    //                                 );
    //                               }
    //                               print("snapshot.data ${snapshot.data}");
    //                               return snapshot.data['length'] > 0
    //                                   ? TextButton.icon(
    //                                       onPressed: () async {
    //                                         var res = await Provider.of<
    //                                                     ConsultProvider>(
    //                                                 context,
    //                                                 listen: false)
    //                                             .unlikeConsult(e['id']);
    //                                         if (res['status']) {
    //                                           setState(() {
    //                                             Provider.of<ConsultProvider>(
    //                                                     context,
    //                                                     listen: false)
    //                                                 .getLikeByConsultIdForUser(
    //                                                     e['id']);
    //                                           });
    //                                         }
    //                                       },
    //                                       icon: Icon(
    //                                         Icons.favorite,
    //                                         color: Colors.red,
    //                                       ),
    //                                       label: Text(snapshot.data['likes']
    //                                           .toString()))
    //                                   : TextButton.icon(
    //                                       onPressed: () async {
    //                                         var res = await Provider.of<
    //                                                     ConsultProvider>(
    //                                                 context,
    //                                                 listen: false)
    //                                             .likeConsult(e['id']);
    //                                         if (res['status']) {
    //                                           setState(() {
    //                                             Provider.of<ConsultProvider>(
    //                                                     context,
    //                                                     listen: false)
    //                                                 .getLikeByConsultIdForUser(
    //                                                     e['id']);
    //                                           });
    //                                         }
    //                                       },
    //                                       icon: Icon(Icons.favorite_border),
    //                                       label: Text(snapshot.data['likes']
    //                                           .toString()));
    //                             }
    //                           })
    //                     ],
    //                   ),
    //                   FutureBuilder<int>(
    //                       future: Provider.of<ConsultProvider>(context,
    //                               listen: false)
    //                           .getCommentsByConsultId(e['id']),
    //                       builder: (context, snapshot) {
    //                         if (!snapshot.hasData) {
    //                           return Center(
    //                             child: CircularProgressIndicator(),
    //                           );
    //                         } else {
    //                           if (snapshot.data == null) {
    //                             return Center(
    //                               child: Text('No data to show'),
    //                             );
    //                           }
    //                           return TextButton.icon(
    //                               onPressed: () {
    //                                 Navigator.push(
    //                                     context,
    //                                     MaterialPageRoute(
    //                                         builder: (context) =>
    //                                             PharmacyShareComment(e['id'])));
    //                               },
    //                               label: snapshot.data > 0
    //                                   ? Text('${snapshot.data} Comments')
    //                                   : Text('Comments'),
    //                               icon: Icon(Icons.comment));
    //                         }
    //                       }),
    //                 ],
    //               ),
    //             ),
    //           )
    //         ],
    //       ),
    //     );
    //   },
    // );
  }
}
