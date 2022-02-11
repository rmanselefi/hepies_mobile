import 'dart:io';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/pharmacy/ui/consults/comment/share_comment.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:hepies/ui/welcome.dart';
import 'package:hepies/util/image_consult.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:linkify_text/linkify_text.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rich_text_view/rich_text_view.dart';

class PharmacyConsultList extends StatefulWidget {
  final user_id;
  final interest;

  PharmacyConsultList(this.user_id, this.interest);
  @override
  _PharmacyConsultListState createState() => _PharmacyConsultListState();
}

class _PharmacyConsultListState extends State<PharmacyConsultList> {
  ScrollController _scrollController;
  var _topic = new TextEditingController();
  XFile file;
  List<dynamic> interests = [];
  List<dynamic> subList = [];

  var name = '';
  void _setImage(XFile image) {
    setState(() {
      file = image;
    });

    print("_formData_formData_formData${file}");
  }

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
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator()],
  );

  Widget _rowButton(var e, List<Widget> post) {
    var res = e['like'].where((l) => l['user_id'] == widget.user_id).toList();
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          res.length > 0
              ? BouncingWidget(
                  scaleFactor: 1.5,
                  onPressed: () async {
                    var res = await Provider.of<ConsultProvider>(context,
                            listen: false)
                        .unlikeConsult(e['id']);
                    if (res['status']) {
                      setState(() {
                        Provider.of<ConsultProvider>(context, listen: false)
                            .getLikeByConsultIdForUser(e['id']);
                      });
                    }
                  },
                  child: rowSingleButton(
                      color: Colors.blueAccent,
                      name: "Like",
                      iconImage: Icons.thumb_up_sharp,
                      isHover: false),
                )
              : BouncingWidget(
                  scaleFactor: 1.5,
                  onPressed: () async {
                    var res = await Provider.of<ConsultProvider>(context,
                            listen: false)
                        .likeConsult(e['id']);
                    if (res['status']) {
                      setState(() {
                        Provider.of<ConsultProvider>(context, listen: false)
                            .getLikeByConsultIdForUser(e['id']);
                      });
                    }
                  },
                  child: rowSingleButton(
                      color: Colors.black,
                      name: "Like",
                      iconImage: Icons.thumb_up_outlined,
                      isHover: false),
                ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PharmacyShareComment(e['id'], post)));
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

  // Widget _listPostWidget() {
  //   return MediaQuery.removePadding(
  //     context: context,
  //     removeTop: true,
  //     child: ListView.builder(
  //       controller: _scrollController,
  //       shrinkWrap: true,
  //       itemCount: widget.consults.length,
  //       itemBuilder: (BuildContext context, int index) {
  //         var e = widget.consults[index];
  //
  //         DateTime time = DateTime.parse(e['createdAt']);
  //         var duration = timeago.format(time);
  //         return Container(
  //           padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
  //           margin: EdgeInsets.only(bottom: 0.0, top: 8),
  //           decoration: BoxDecoration(
  //               color: Colors.white,
  //               border: Border(
  //                   top: BorderSide(color: Colors.black54, width: 0.50),
  //                   bottom: BorderSide(color: Colors.black54, width: 0.50))),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 children: [
  //                   Container(
  //                     width: 40,
  //                     height: 40,
  //                     decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.all(Radius.circular(40))),
  //                     child: ClipRRect(
  //                         borderRadius: BorderRadius.all(Radius.circular(40)),
  //                         child: Icon(
  //                           Icons.person,
  //                           size: 40,
  //                         )),
  //                   ),
  //                   SizedBox(
  //                     width: 4,
  //                   ),
  //                   Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         e['user'],
  //                         style: TextStyle(
  //                             fontSize: 18, fontWeight: FontWeight.bold),
  //                       ),
  //                       Container(
  //                         width: 100,
  //                         child: Text(
  //                           "Doctor",
  //                           style:
  //                               TextStyle(fontSize: 12, color: Colors.black54),
  //                           overflow: TextOverflow.ellipsis,
  //                         ),
  //                       ),
  //                       Text('$duration',
  //                           style:
  //                               TextStyle(fontSize: 12, color: Colors.black54))
  //                     ],
  //                   ),
  //                   SizedBox(
  //                     width: 94,
  //                   ),
  //                   e['author'] != null && e['author']['id'] == widget.user_id
  //                       ? IconButton(
  //                           onPressed: () {
  //                             showAlertDialog(context, e['id']);
  //                           },
  //                           icon: Icon(Icons.cancel))
  //                       : Container(),
  //                   e['author'] != null && e['author']['id'] == widget.user_id
  //                       ? IconButton(onPressed: () {}, icon: Icon(Icons.edit))
  //                       : Container(),
  //                 ],
  //               ),
  //               SizedBox(
  //                 height: 5,
  //               ),
  //               // Text(
  //               //   widget.consults[index]['topic'],
  //               //   style: TextStyle(fontSize: 14),
  //               // ),
  //               HashTagText(
  //                 text: "${widget.consults[index]['topic'] ?? ' '}",
  //                 basicStyle: TextStyle(fontSize: 14, color: Colors.black),
  //                 decoratedStyle:
  //                     TextStyle(fontSize: 14, color: Colors.blueAccent),
  //                 textAlign: TextAlign.start,
  //                 onTap: (text) {
  //                   print(text);
  //                 },
  //               ),
  //               // Text(
  //               //   _post[index].tags,
  //               //   style: TextStyle(color: blueColor),
  //               // ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               e['image'] != null
  //                   ? Container(
  //                       width: MediaQuery.of(context).size.width,
  //                       child: Image.network(
  //                         e['image'],
  //                         fit: BoxFit.contain,
  //                       ),
  //                     )
  //                   : Container(
  //                       height: 0.0,
  //                       width: 0.0,
  //                     ),
  //               SizedBox(
  //                 height: 10,
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Container(
  //                     child: Row(
  //                       children: [
  //                         FutureBuilder<dynamic>(
  //                             future: Provider.of<ConsultProvider>(context,
  //                                     listen: false)
  //                                 .getLikeByConsultIdForUser(e['id']),
  //                             builder: (context, snapshot) {
  //                               if (!snapshot.hasData) {
  //                                 return Center(
  //                                   child: CircularProgressIndicator(),
  //                                 );
  //                               } else {
  //                                 if (snapshot.data == null) {
  //                                   return Center(
  //                                     child: Text('No data to show'),
  //                                   );
  //                                 }
  //                                 return TextButton.icon(
  //                                     onPressed: () async {
  //                                       Navigator.push(
  //                                           context,
  //                                           MaterialPageRoute(
  //                                               builder: (context) =>
  //                                                   PharmacyShareComment(
  //                                                       e['id'])));
  //                                     },
  //                                     icon: Icon(
  //                                       Icons.thumb_up_sharp,
  //                                       color: Colors.grey,
  //                                       size: 15,
  //                                     ),
  //                                     label: Text(
  //                                       "${snapshot.data['likes'].toString()} likes",
  //                                       style: TextStyle(color: Colors.grey),
  //                                     ));
  //                               }
  //                             }),
  //
  //                         // Container(
  //                         //     width: 25,
  //                         //     height: 25,
  //                         //     child: Icon(Icons.favorite)),
  //
  //                         SizedBox(
  //                           width: 5,
  //                         ),
  //                         // Text(
  //                         //   _post[index].likes,
  //                         //   style: TextStyle(fontSize: 14),
  //                         // )
  //                       ],
  //                     ),
  //                   ),
  //                   FutureBuilder<int>(
  //                       future:
  //                           Provider.of<ConsultProvider>(context, listen: false)
  //                               .getCommentsByConsultId(e['id']),
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
  //                           return Row(
  //                             children: [
  //                               Text(
  //                                 snapshot.data.toString(),
  //                                 style: TextStyle(color: Colors.grey),
  //                               ),
  //                               Text(" comments",
  //                                   style: TextStyle(color: Colors.grey))
  //                             ],
  //                           );
  //                         }
  //                       })
  //                 ],
  //               ),
  //               Divider(
  //                 thickness: 0.50,
  //                 color: Colors.black26,
  //               ),
  //               _rowButton(e),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    ConsultProvider consult = Provider.of<ConsultProvider>(context);
    Future<dynamic> _myData =
        Provider.of<ConsultProvider>(context, listen: false).getConsults();
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    showAlertDialog(BuildContext context, var id) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("No"),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = TextButton(
        child: Text("Yes"),
        onPressed: () async {
          var res = await ConsultProvider().deleteConsult(id);
          if (res['status']) {
            setState(() {
              _myData = Provider.of<ConsultProvider>(context, listen: false)
                  .getConsults();

              Navigator.of(context).pop();
              showTopSnackBar(
                context,
                CustomSnackBar.success(
                  message: "Your consult is successfully deleted",
                ),
              );
            });
          }
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("AlertDialog"),
        content: Text("Are you sure you want to remove these consult?"),
        actions: [
          cancelButton,
          consult.shareStatus == ConsultStatus.Sharing
              ? CircularProgressIndicator()
              : continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    showEdit(BuildContext context, var post) {
      showModalBottomSheet(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
                builder: (context, setState) => Container(
                      color: Colors.white,
                      height: 500.0,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 5),
                          Text(
                            'Edit your consult',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 5),
                          Divider(),
                          Row(
                            // Milkesa: Added mini image display next to consult text field
                            children: [
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: HashTagTextField(
                                    decoration: InputDecoration(
                                        hintText:
                                            'Share, consult, promote, inform..',
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade50,
                                                width: 0.5))),
                                    basicStyle: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    decoratedStyle: TextStyle(
                                        fontSize: 15, color: Colors.blue),
                                    keyboardType: TextInputType.multiline,
                                    controller: _topic,

                                    /// Called when detection (word starts with #, or # and @) is being typed
                                    onDetectionTyped: (text) {
                                      if (text.length > 1) {
                                        text.substring(2);
                                        print("text ${text.substring(2)}");
                                        setState(() {
                                          name =
                                              text.substring(2).toLowerCase();
                                        });
                                      }

                                      print("texttexttexttexttext $text");
                                    },

                                    /// Called when detection is fully typed
                                    onDetectionFinished: () {
                                      print("detection finished");
                                    },
                                    maxLines: 4,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: file != null
                                    ? Container(
                                        width: width(context) * 0.25,
                                        margin: EdgeInsets.all(5),
                                        child: Stack(
                                          children: [
                                            Image.file(File(file.path),
                                                fit: BoxFit.contain),
                                            IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  file = null;
                                                });
                                              },
                                              icon: Icon(Icons.cancel_outlined,
                                                  color: Colors.blue),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container(width: 0),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 250,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      direction: Axis.horizontal,
                                      children:
                                          widget.interest.map<Widget>((e) {
                                        return GestureDetector(
                                          onTap: () {
                                            if (name == "") {
                                              setState(() {
                                                _topic.text =
                                                    "${_topic.text} #${e['interest']}";
                                              });
                                            }
                                          },
                                          child: Text(
                                            "#${e['interest']} ",
                                            style: TextStyle(
                                                color: Colors.blueAccent),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ImageInputConsult(_setImage),
                                      consult.editStatus ==
                                              ConsultStatus.Sharing
                                          ? loading
                                          : Align(
                                              alignment: Alignment.topRight,
                                              child: OutlinedButton(
                                                onPressed: () async {
                                                  try {
                                                    var photo = file != null
                                                        ? File(file.path)
                                                        : null;
                                                    if (_topic.text !=
                                                            "" || //Milkessa: added posting capability with either text or image
                                                        file != null) {
                                                      var res = await consult
                                                          .updateConsult(
                                                              post['id'],
                                                              _topic.text,
                                                              photo,
                                                              post['image']);
                                                      if (res['status']) {
                                                        consult.getConsults();
                                                        showTopSnackBar(
                                                          context,
                                                          CustomSnackBar
                                                              .success(
                                                            message:
                                                                "Your consult is updated succesfully",
                                                          ),
                                                        );
                                                        setState(() {
                                                          _topic.text = null;
                                                          file = null;
                                                        });
                                                        Navigator.pushAndRemoveUntil(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => userProvider.role == 'doctor' ||
                                                                        userProvider.role ==
                                                                            'healthofficer' ||
                                                                        userProvider.role ==
                                                                            'nurse'
                                                                    ? Welcome()
                                                                    : WelcomePharmacy()),
                                                            ModalRoute.withName(
                                                                '/'));
                                                      }
                                                    } else {
                                                      showTopSnackBar(
                                                        context,
                                                        CustomSnackBar.error(
                                                          message:
                                                              "Invalid Data! Make sure you have inserted image or text",
                                                        ),
                                                      );
                                                    }
                                                  } catch (e) {
                                                    print("eeeee ${e}");
                                                    showTopSnackBar(
                                                      context,
                                                      CustomSnackBar.error(
                                                        message:
                                                            "Unable to share your consult",
                                                      ),
                                                    );
                                                  }
                                                },
                                                child: Text('Edit'),
                                              )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
          });
    }

    return FutureBuilder<List<dynamic>>(
        future: _myData,
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
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  var e = snapshot.data[index];
                  var profile = e['author']['profession'][0]['profile'];

                  DateTime time = DateTime.parse(e['createdAt']);
                  var duration = timeago.format(time);
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                    margin: EdgeInsets.only(bottom: 0.0, top: 8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            top: BorderSide(color: Colors.black54, width: 0.50),
                            bottom: BorderSide(
                                color: Colors.black54, width: 0.50))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: profile != null
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Image.network(
                                                profile,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        child: profile != null
                                            ? Image.network(profile)
                                            : Icon(
                                                Icons.person,
                                                size: 40,
                                              )),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e['user'],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      child: Text(
                                        "Doctor",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text('$duration',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54))
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: width(context) * 0.05,
                                ),
                                e['author'] != null &&
                                        e['author']['id'] == widget.user_id
                                    ? IconButton(
                                        onPressed: () {
                                          showAlertDialog(context, e['id']);
                                        },
                                        icon:
                                            Icon(Icons.delete_outline_rounded),
                                      )
                                    : Container(),
                                e['author'] != null &&
                                        e['author']['id'] == widget.user_id
                                    ? IconButton(
                                        onPressed: () {
                                          _topic.text = e['topic'] ?? '';
                                          showEdit(context, e);
                                        },
                                        icon: Icon(Icons.more_vert_outlined))
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        // Text(
                        //   widget.consults[index]['topic'],
                        //   style: TextStyle(fontSize: 14),
                        // ),
                        // HashTagText(
                        //   text: "${snapshot.data[index]['topic'] ?? ' '}",
                        //   basicStyle:
                        //       TextStyle(fontSize: 14, color: Colors.black),
                        //   decoratedStyle:
                        //       TextStyle(fontSize: 14, color: Colors.blueAccent),
                        //   textAlign: TextAlign.start,
                        //   onTap: (text) {
                        //     print(text);
                        //   },
                        // ),
                        // LinkifyText(
                        //   "${snapshot.data[index]['topic'] ?? ' '}",
                        //   isLinkNavigationEnable: true,
                        //   linkColor: Colors.blueAccent,
                        //   fontColor: Colors.black,
                        // ),

                        RichTextView(
                          text: "${snapshot.data[index]['topic'] ?? ' '}",
                          maxLines: 3,
                          align: TextAlign.center,
                          onHashTagClicked: (hashtag) =>
                              print('is $hashtag trending?'),
                          onMentionClicked: (mention) =>
                              print('$mention clicked'),
                          onUrlClicked: (url) => launch(url),
                          linkStyle: TextStyle(color: Colors.blue),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        e['image'] != null
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Image.network(
                                        e['image'],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: height(context) * 0.375,
                                  child: Image.network(
                                    e['image'],
                                    fit: BoxFit.contain,
                                  ),
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
                                  TextButton.icon(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        PharmacyShareComment(
                                                            e['id'],
                                                            [
                                                              Row(
                                                                children: [
                                                                  GestureDetector(
                                                                    onTap: profile !=
                                                                            null
                                                                        ? () {
                                                                            Navigator.push(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => Image.network(
                                                                                  profile,
                                                                                  fit: BoxFit.contain,
                                                                                ),
                                                                              ),
                                                                            );
                                                                          }
                                                                        : null,
                                                                    child:
                                                                        Container(
                                                                      width: 40,
                                                                      height:
                                                                          40,
                                                                      decoration:
                                                                          BoxDecoration(
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
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        e['user'],
                                                                        style:
                                                                            TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                        ),
                                                                      ),
                                                                      Container(
                                                                        width:
                                                                            100,
                                                                        child:
                                                                            Text(
                                                                          "Doctor",
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.black54),
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                          '$duration',
                                                                          style: TextStyle(
                                                                              fontSize: 12,
                                                                              color: Colors.black54))
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 5,
                                                              ),
                                                              // Text(
                                                              //   widget.consults[index]['topic'],
                                                              //   style: TextStyle(fontSize: 14),
                                                              // ),
//                          HashTagText(
//                            text: "${snapshot.data[index]['topic'] ?? ' '}",
//                            basicStyle:
//                                TextStyle(fontSize: 14, color: Colors.black),
//                            decoratedStyle: TextStyle(
//                                fontSize: 14, color: Colors.blueAccent),
//                            textAlign: TextAlign.start,
//                            onTap: (text) {
//                              print(text);
//                            },
//                          ),
                                                              RichTextView(
                                                                text:
                                                                    "${snapshot.data[index]['topic'] ?? ' '}",
                                                                maxLines: 3,
                                                                align: TextAlign
                                                                    .center,
                                                                onHashTagClicked:
                                                                    (hashtag) =>
                                                                        print(
                                                                            'is $hashtag trending?'),
                                                                onMentionClicked:
                                                                    (mention) =>
                                                                        print(
                                                                            '$mention clicked'),
                                                                onUrlClicked:
                                                                    (url) =>
                                                                        launch(
                                                                            url),
                                                                linkStyle: TextStyle(
                                                                    color: Colors
                                                                        .blue),
                                                              ),
                                                              // Text(
                                                              //   _post[index].tags,
                                                              //   style: TextStyle(color: blueColor),
                                                              // ),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              e['image'] != null
                                                                  ? GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        Navigator
                                                                            .push(
                                                                          context,
                                                                          MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                Image.network(
                                                                              e['image'],
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        width: MediaQuery.of(context)
                                                                            .size
                                                                            .width,
                                                                        height: height(context) *
                                                                            0.375,
                                                                        child: Image
                                                                            .network(
                                                                          e['image'],
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      height:
                                                                          0.0,
                                                                      width:
                                                                          0.0,
                                                                    ),
                                                            ])));
                                      },
                                      icon: Icon(
                                        Icons.thumb_up_sharp,
                                        color: Colors.grey,
                                        size: 15,
                                      ),
                                      label: Text(
                                        "${e['like'].length} likes",
                                        style: TextStyle(color: Colors.grey),
                                      )),

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
                            GestureDetector(
                              child: Row(
                                children: [
                                  Text(
                                    e['comment'].length.toString(),
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  Text(" comments",
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PharmacyShareComment(e['id'], [
                                              Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: profile != null
                                                        ? () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Image
                                                                            .network(
                                                                  profile,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        : null,
                                                    child: Container(
                                                      width: 40,
                                                      height: 40,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          40))),
                                                      child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          40)),
                                                          child: profile != null
                                                              ? Image.network(
                                                                  profile)
                                                              : Icon(
                                                                  Icons.person,
                                                                  size: 40,
                                                                )),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        e['user'],
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 100,
                                                        child: Text(
                                                          "Doctor",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black54),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      Text('$duration',
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black54))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              // Text(
                                              //   widget.consults[index]['topic'],
                                              //   style: TextStyle(fontSize: 14),
                                              // ),
//                          HashTagText(
//                            text: "${snapshot.data[index]['topic'] ?? ' '}",
//                            basicStyle:
//                                TextStyle(fontSize: 14, color: Colors.black),
//                            decoratedStyle: TextStyle(
//                                fontSize: 14, color: Colors.blueAccent),
//                            textAlign: TextAlign.start,
//                            onTap: (text) {
//                              print(text);
//                            },
//                          ),
                                              RichTextView(
                                                text:
                                                    "${snapshot.data[index]['topic'] ?? ' '}",
                                                maxLines: 3,
                                                align: TextAlign.center,
                                                onHashTagClicked: (hashtag) =>
                                                    print(
                                                        'is $hashtag trending?'),
                                                onMentionClicked: (mention) =>
                                                    print('$mention clicked'),
                                                onUrlClicked: (url) =>
                                                    launch(url),
                                                linkStyle: TextStyle(
                                                    color: Colors.blue),
                                              ),
                                              // Text(
                                              //   _post[index].tags,
                                              //   style: TextStyle(color: blueColor),
                                              // ),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              e['image'] != null
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder: (context) =>
                                                                Image.network(
                                                              e['image'],
                                                              fit: BoxFit
                                                                  .contain,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        height:
                                                            height(context) *
                                                                0.375,
                                                        child: Image.network(
                                                          e['image'],
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 0.0,
                                                      width: 0.0,
                                                    ),
                                            ])));
                              },
                            )
                          ],
                        ),
                        Divider(
                          thickness: 0.50,
                          color: Colors.black26,
                        ),
                        _rowButton(
                          e,
                          [
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: profile != null
                                      ? () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  Image.network(
                                                profile,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          );
                                        }
                                      : null,
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40)),
                                        child: profile != null
                                            ? Image.network(profile)
                                            : Icon(
                                                Icons.person,
                                                size: 40,
                                              )),
                                  ),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      e['user'],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    Container(
                                      width: 100,
                                      child: Text(
                                        "Doctor",
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text('$duration',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.black54))
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            // Text(
                            //   widget.consults[index]['topic'],
                            //   style: TextStyle(fontSize: 14),
                            // ),
//                          HashTagText(
//                            text: "${snapshot.data[index]['topic'] ?? ' '}",
//                            basicStyle:
//                                TextStyle(fontSize: 14, color: Colors.black),
//                            decoratedStyle: TextStyle(
//                                fontSize: 14, color: Colors.blueAccent),
//                            textAlign: TextAlign.start,
//                            onTap: (text) {
//                              print(text);
//                            },
//                          ),
                            LinkifyText(
                              "${snapshot.data[index]['topic'] ?? ' '}",
                              isLinkNavigationEnable: true,
                              linkColor: Colors.blueAccent,
                              fontColor: Colors.black,
                            ),
                            // RichTextView(
                            //   text: "${snapshot.data[index]['topic'] ?? ' '}",
                            //   maxLines: 3,
                            //   align: TextAlign.center,
                            //   onEmailClicked: (email) => launch(email),
                            //   onHashTagClicked: (hashtag) =>
                            //       print('is $hashtag trending?'),
                            //   onUrlClicked: (url) => launch(url),
                            //   linkStyle: TextStyle(color: Colors.blue),
                            // ),
                            // Text(
                            //   _post[index].tags,
                            //   style: TextStyle(color: blueColor),
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            e['image'] != null
                                ? GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Image.network(
                                            e['image'],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: height(context) * 0.375,
                                      child: Image.network(
                                        e['image'],
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 0.0,
                                    width: 0.0,
                                  ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        });
  }
}
