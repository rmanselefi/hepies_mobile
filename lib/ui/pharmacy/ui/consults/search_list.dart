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
import 'package:multiselect_formfield/multiselect_formfield.dart';

class RowButton extends StatefulWidget {
  RowButton(
      {Key key, this.e, this.post, this.userId, this.profile, this.duration})
      : super(key: key);

  var e;
  List<Widget> post;
  var userId;
  var profile;
  var duration;

  @override
  State<RowButton> createState() => _RowButtonState();
}

class _RowButtonState extends State<RowButton> {
  bool isLiked = false;
  int totalLikes = 0;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    var res = widget.e['like'] != null
        ? widget.e['like'].where((l) => l['user_id'] == widget.userId).toList()
        : [];
    res.length > 0 ? isLiked = true : isLiked = false;
    totalLikes = widget.e['like'].length;
    print("res ${res}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                                builder: (context) => PharmacyShareComment(
                                    widget.e['id'],
                                    [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: widget.profile != null
                                                ? () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            Image.network(
                                                          widget.profile,
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
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(40))),
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(40)),
                                                  child: widget.profile != null
                                                      ? Image.network(
                                                          widget.profile)
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
                                                widget.e['user'],
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
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Text('${widget.duration}',
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

                                      RichTextView(
                                        text: "${widget.e['topic'] ?? ' '}",
                                        maxLines: 3,
                                        align: TextAlign.center,
                                        onHashTagClicked: (hashtag) =>
                                            print('is $hashtag trending?'),
                                        onMentionClicked: (mention) =>
                                            print('$mention clicked'),
                                        onUrlClicked: (url) => launch(url),
                                        linkStyle:
                                            TextStyle(color: Colors.blue),
                                      ),
                                      // Text(
                                      //   _post[index].tags,
                                      //   style: TextStyle(color: blueColor),
                                      // ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      widget.e['image'] != null
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        Image.network(
                                                      widget.e['image'],
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: height(context) * 0.375,
                                                child: Image.network(
                                                  widget.e['image'],
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              height: 0.0,
                                              width: 0.0,
                                            ),
                                    ],
                                    widget.userId)));
                      },
                      icon: Icon(
                        Icons.thumb_up_sharp,
                        color: Colors.grey,
                        size: 15,
                      ),
                      label: Text(
                        "${totalLikes}",
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
                    widget.e['comment'] != null
                        ? widget.e['comment'].length.toString()
                        : "",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(" comments", style: TextStyle(color: Colors.grey))
                ],
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PharmacyShareComment(
                            widget.e['id'],
                            [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: widget.profile != null
                                        ? () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    Image.network(
                                                  widget.profile,
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
                                          child: widget.profile != null
                                              ? Image.network(widget.profile)
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
                                        widget.e['user'],
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
                                      Text('${widget.duration}',
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

                              RichTextView(
                                text: "${widget.e['topic'] ?? ' '}",
                                maxLines: 3,
                                align: TextAlign.center,
                                onHashTagClicked: (hashtag) =>
                                    print('is $hashtag trending?'),
                                onMentionClicked: (mention) =>
                                    print('$mention clicked'),
                                onUrlClicked: (url) => launch(url),
                                linkStyle: TextStyle(color: Colors.blue),
                              ),
                              // Text(
                              //   _post[index].tags,
                              //   style: TextStyle(color: blueColor),
                              // ),
                              SizedBox(
                                height: 10,
                              ),
                              widget.e['image'] != null
                                  ? GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Image.network(
                                              widget.e['image'],
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
                                          widget.e['image'],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 0.0,
                                      width: 0.0,
                                    ),
                            ],
                            widget.userId)));
              },
            )
          ],
        ),
        Divider(
          thickness: 0.50,
          color: Colors.black26,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<ConsultProvider>(
                  builder: (context, consultPProvider, child) {
                return BouncingWidget(
                  scaleFactor: 1.5,
                  onPressed: () async {
                    setState(() {
                      isLiked = !isLiked;
                    });

                    if (isLiked) {
                      print("like woriing");
                      var r = await Provider.of<ConsultProvider>(context,
                              listen: false)
                          .likeConsult(widget.e['id']);
                      print("r" + r.toString());
                      setState(() {
                        ++totalLikes;
                      });
                    } else {
                      print("unlike working");

                      var r = await Provider.of<ConsultProvider>(context,
                              listen: false)
                          .unlikeConsult(widget.e['id']);
                      print("r" + r.toString());
                      setState(() {
                        --totalLikes;
                      });
                    }
                  },
                  child: rowSingleButton(
                      color: isLiked? Colors.blueAccent : Colors.black,
                      name: "Like",
                      iconImage: isLiked
                          ? Icons.thumb_up_sharp
                          : Icons.thumb_up_outlined,
                      isHover: false),
                );
              }),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PharmacyShareComment(
                              widget.e['id'], widget.post, widget.userId)));
                },
                child: rowSingleButton(
                    color: Colors.black,
                    name: "Comment",
                    iconImage: Icons.comment,
                    isHover: false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class rowSingleButton extends StatelessWidget {
  rowSingleButton(
      {Key key, this.name, this.iconImage, this.color, this.isHover})
      : super(key: key);
  String name;
  dynamic iconImage;
  Color color;
  bool isHover;
  @override
  Widget build(BuildContext context) {
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
}

class SearchList extends StatefulWidget {
  final user_id;
  final interest;
  final queryWord;
  final parentScrollController;

  SearchList(
      this.user_id, this.interest, this.queryWord, this.parentScrollController);
  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
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

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator()],
  );

  List<dynamic> searchConsultsResult = [];
  bool isLoadingConsults = false;

  Future<List<dynamic>> searchConsults() async {
    setState(() {
      isLoadingConsults = true;
    });
    List<dynamic> consult =
        await Provider.of<ConsultProvider>(context, listen: false)
            .searchConsults(widget.queryWord, 5, searchSkip);
    await Future.delayed(const Duration(seconds: 3), () {});
    searchConsultsResult.addAll(consult[0]);
    setState(() {
      isLoadingConsults = false;
      searchSkip = searchSkip + 5;
    });
    return searchConsultsResult;
  }

  List interestList = [];
  List<dynamic> _myInterests = [];
  getInterests() async {
    List interests = await ConsultProvider().getInterests();

    setState(() {
      interests.forEach((element) {
        var property = {
          'display': "#${element['interest']}",
          'value': element['interest'],
        };
        interestList.add(property);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.minScrollExtent) {
        widget.parentScrollController.animateTo(
            widget.parentScrollController.position.minScrollExtent,
            duration: Duration(seconds: 1),
            curve: Curves.easeIn);
      }
    });
    searchConsults();
    getInterests();
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
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  'Edit your consult',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: IconButton(
                                  onPressed: () {
                                    showAlertDialog(context, post['id']);
                                  },
                                  icon: Icon(Icons.delete_outline_rounded),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            // Milkesa: Added mini image display next to consult text field
                            children: [
                              Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: EdgeInsets.all(3),
                                  child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: TextField(
                                        controller: _topic,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                          hintText: "Enter your Topic....",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black,
                                                  width: 1)),
                                        ),
                                        maxLines: 4,
                                      )),
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
                                  Expanded(
                                    child: Container(
                                      child: MultiSelectFormField(
                                        open: () {
                                          getInterests();
                                        },
                                        chipBackGroundColor: Colors.red,
                                        chipLabelStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        dialogTextStyle: TextStyle(
                                            fontWeight: FontWeight.bold),
                                        checkBoxActiveColor: Colors.red,
                                        checkBoxCheckColor: Colors.green,
                                        dialogShapeBorder:
                                            RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(8.0))),
                                        title: Text(
                                          "Add interests",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        dataSource: interestList,
                                        textField: 'display',
                                        valueField: 'value',
                                        okButtonLabel: 'OK',
                                        cancelButtonLabel: 'CANCEL',
                                        hintWidget:
                                            Text('Please choose one or more'),
                                        initialValue: _myInterests,
                                        onSaved: (value) {
                                          if (value == null) return;
                                          // print("_interests_interests_interests ${value.join(",")}");
                                          var hashtaglists = [];
                                          for (var item in value) {
                                            hashtaglists
                                                .add("#${item.toString()}");
                                          }
                                          setState(() {
                                            _myInterests = hashtaglists;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    //Delete icon

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
                                                                post['image'],
                                                                _myInterests
                                                                    .join(" ")
                                                                    .toString());
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
                                                              ModalRoute
                                                                  .withName(
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
                                                      // print("eeeee ${e}");
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
                            ],
                          )
                        ],
                      ),
                    ));
          });
    }

    var appstate = Provider.of<ConsultProvider>(context);
// Pagination

    return searchConsultsResult.length == 0
        ? ShimmerEffect()
        : MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: LazyLoadScrollView(
              isLoading: isLoadingConsults,
              onEndOfPage: () => searchConsults(),
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: searchConsultsResult.length,
                physics: ClampingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  var e = searchConsultsResult[index];
                  var profile = e['author'] != null
                      ? e['author']['profession'][0]['profile']
                      : "";
                  bool _validURL = profile != "" && profile != null
                      ? Uri.parse(profile).isAbsolute
                      : false;
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
                              "${searchConsultsResult[index]['interests'] != null ? searchConsultsResult[index]['interests'] : ""}",
                          maxLines: 3,
                          align: TextAlign.center,
                          onHashTagClicked: (hashtag) =>
                              print('is $hashtag trending?'),
                          onMentionClicked: (mention) =>
                              print('$mention clicked'),
                          onUrlClicked: (url) => launch(url),
                          linkStyle: TextStyle(color: Colors.blue),
                        ),
                        RichTextView(
                          text:
                              "${searchConsultsResult[index]['topic'] != null ? searchConsultsResult[index]['topic'] : ""}",
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
                       
                                                 RowButton(
                            e: e,
                            post: [
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
                                "${ searchConsultsResult[index]['topic'] ?? ' '}",
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
                            userId: widget.user_id,
                            profile: profile,
                            duration: duration,
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
