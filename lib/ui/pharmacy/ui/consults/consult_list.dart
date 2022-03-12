import 'dart:io';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/models/consult.dart';
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
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rich_text_view/rich_text_view.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

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
  String interestStatus = "hide";
  XFile file;
  List<dynamic> interests = [];
  List<dynamic> subList = [];

  int skip = 0;
  int searchSkip = 0;

  var name = '';
  void _setImage(XFile image) {
    setState(() {
      file = image;
    });

    // print("_formData_formData_formData${file}");
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
    var res = e['like'] != null
        ? e['like'].where((l) => l['user_id'] == widget.user_id).toList()
        : [];
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
                          PharmacyShareComment(e['id'], post, widget.user_id)));
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

  List<dynamic> listofConsults = [];
  bool isLoadingConsults = false;
  Future<List<dynamic>> consultPagination() async {
    setState(() {
      isLoadingConsults = true;
    });
    List<dynamic> consult =
        await Provider.of<ConsultProvider>(context, listen: false)
            .getConsultsbyPagination(5, skip);
    await Future.delayed(const Duration(seconds: 3), () {});

    setState(() {
      listofConsults.addAll(consult[0]);
      isLoadingConsults = false;
      skip = skip + 5;
    });
    // print("consult haile" + listofConsults.toString());
    return listofConsults;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();

    interestStatus = "hide";
  }

  @override
  Widget build(BuildContext context) {
    ConsultProvider consult = Provider.of<ConsultProvider>(context);
    Future<List<dynamic>> _myData =
        Provider.of<ConsultProvider>(context, listen: false).getConsults();

    // var appState = Provider.of<ConsultProvider>(context);

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
                                      setState(() {
                                        interestStatus = "show";
                                      });
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
                                    width: MediaQuery.of(context).size.width /
                                        1.63,
                                    child: Wrap(
                                      alignment: WrapAlignment.start,
                                      direction: Axis.horizontal,
                                      children:
                                          // MyHashtag
                                          interestStatus == "show"
                                              ? widget.interest
                                                  .map<Widget>((e) {
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
                                                          color: Colors
                                                              .blueAccent),
                                                    ),
                                                  );
                                                }).toList()
                                              : [],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        //Delete icon
                                        IconButton(
                                          onPressed: () {
                                            showAlertDialog(
                                                context, post['id']);
                                          },
                                          icon: Icon(
                                              Icons.delete_outline_rounded),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            ImageInputConsult(_setImage),
                                            consult.editStatus ==
                                                    ConsultStatus.Sharing
                                                ? loading
                                                : Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: OutlinedButton(
                                                      onPressed: () async {
                                                        try {
                                                          var photo = file !=
                                                                  null
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
                                                                    post[
                                                                        'image']);
                                                            if (res['status']) {
                                                              consult
                                                                  .getConsults();
                                                              showTopSnackBar(
                                                                context,
                                                                CustomSnackBar
                                                                    .success(
                                                                  message:
                                                                      "Your consult is updated succesfully",
                                                                ),
                                                              );
                                                              setState(() {
                                                                _topic.text =
                                                                    null;
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
                                                                  ModalRoute
                                                                      .withName(
                                                                          '/'));
                                                            }
                                                          } else {
                                                            showTopSnackBar(
                                                              context,
                                                              CustomSnackBar
                                                                  .error(
                                                                message:
                                                                    "Invalid Data! Make sure you have inserted image or text",
                                                              ),
                                                            );
                                                          }
                                                        } catch (e) {
                                                          // print("eeeee ${e}");
                                                          showTopSnackBar(
                                                            context,
                                                            CustomSnackBar
                                                                .error(
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
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ));
          });
    }

    var appstate = Provider.of<ConsultProvider>(context);
// Pagination
    return FutureBuilder<List<dynamic>>(
        future: consultPagination(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return ShimmerEffect();
          } else {
            if (snapshot.data == null) {
              if (appstate.isonSearching) {
                return Center(
                  child: Text("Searching....."),
                );
              }
              return Center(
                child: Text('No data to show'),
              );
            }
            return MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: LazyLoadScrollView(
                // isLoading: isLoadingConsults,
                onEndOfPage: () => consultPagination(),
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var e = snapshot.data[index];
                    var profile = e['author'] != null
                        ? e['author']['profession'][0]['profile']
                        : "";
                    bool _validURL = profile != "" && profile != null
                        ? Uri.parse(profile).isAbsolute
                        : false;
                    DateTime time = DateTime.parse(e['createdAt']);
                    var duration = timeago.format(time);

                    if (index == snapshot.data.length - 1) {
                      return Padding(
                          padding: EdgeInsets.all(8), child: ShimmerEffect());
                    }

                    return Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      margin: EdgeInsets.only(bottom: 0.0, top: 8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: Colors.black54, width: 0.50),
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
                                          child: profile != null && _validURL
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
                                        CrossAxisAlignment.start,
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
                          RichTextView(
                            text:
                                "${snapshot.data[index]['interests']} ${snapshot.data[index]['topic'] ?? ' '}",
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
                                                  builder: (context) =>
                                                      PharmacyShareComment(
                                                          e['id'],
                                                          [
                                                            Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      profile !=
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
                                                                    height: 40,
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.all(Radius.circular(40))),
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
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black54),
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                        '$duration',
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                12,
                                                                            color:
                                                                                Colors.black54))
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 5,
                                                            ),

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
                                                                    onTap: () {
                                                                      Navigator
                                                                          .push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Image.network(
                                                                            e['image'],
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height: height(
                                                                              context) *
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
                                                                    height: 0.0,
                                                                    width: 0.0,
                                                                  ),
                                                          ],
                                                          widget.user_id)));
                                        },
                                        icon: Icon(
                                          Icons.thumb_up_sharp,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                        label: Text(
                                          "${e['like'] != null ? e['like'].length : ''} likes",
                                          style: TextStyle(color: Colors.grey),
                                        )),
                                    SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                child: Row(
                                  children: [
                                    Text(
                                      e['comment'] != null
                                          ? e['comment'].length.toString()
                                          : "",
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
                                              PharmacyShareComment(
                                                  e['id'],
                                                  [
                                                    Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: profile != null
                                                              ? () {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Image.network(
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
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            40))),
                                                            child: ClipRRect(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            40)),
                                                                child: profile !=
                                                                        null
                                                                    ? Image.network(
                                                                        profile)
                                                                    : Icon(
                                                                        Icons
                                                                            .person,
                                                                        size:
                                                                            40,
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
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black54),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                              ),
                                                            ),
                                                            Text('$duration',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .black54))
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),

                                                    RichTextView(
                                                      text:
                                                          "${snapshot.data[index]['topic'] ?? ' '}",
                                                      maxLines: 3,
                                                      align: TextAlign.center,
                                                      onHashTagClicked:
                                                          (hashtag) => print(
                                                              'is $hashtag trending?'),
                                                      onMentionClicked:
                                                          (mention) => print(
                                                              '$mention clicked'),
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
                                                                  builder:
                                                                      (context) =>
                                                                          Image
                                                                              .network(
                                                                    e['image'],
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              height: height(
                                                                      context) *
                                                                  0.375,
                                                              child:
                                                                  Image.network(
                                                                e['image'],
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            height: 0.0,
                                                            width: 0.0,
                                                          ),
                                                  ],
                                                  widget.user_id)));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              LinkifyText(
                                "${snapshot.data[index]['topic'] ?? ' '}",
                                isLinkNavigationEnable: true,
                                linkColor: Colors.blueAccent,
                                fontColor: Colors.black,
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
                                        width:
                                            MediaQuery.of(context).size.width,
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
              ),
            );
          }
        });
  }
}

// Shimmer Effect

class ShimmerEffect extends StatelessWidget {
  const ShimmerEffect({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 700,
      child: ListView(
        children: List.generate(
            3,
            (index) => Column(
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        //     baseColor: Colors.grey[300],
                        // highlightColor: Colors.grey[100],
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        height: 220,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        width: 60,
                                        height: 5,
                                        color: Colors.grey),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: 60,
                                        height: 5,
                                        color: Colors.grey),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                        width: 60,
                                        height: 5,
                                        color: Colors.grey),
                                    // Text("Full Name"),
                                    // Text("role"),
                                    // Text("16 hours ago")
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(width: 40, height: 5, color: Colors.grey),
                            SizedBox(
                              height: 40,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.grey),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        width: 40,
                                        height: 5,
                                        color: Colors.grey),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                        width: 20,
                                        height: 20,
                                        color: Colors.grey),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        width: 40,
                                        height: 5,
                                        color: Colors.grey),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Divider(thickness: 5),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.thumb_up),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Container(
                                        width: 40,
                                        height: 5,
                                        color: Colors.grey),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.comment,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Container(
                                            width: 40,
                                            height: 5,
                                            color: Colors.grey),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10)
                  ],
                )),
      ),
    );
  }
}
