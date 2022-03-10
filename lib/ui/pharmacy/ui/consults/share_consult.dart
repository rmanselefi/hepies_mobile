import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/ui/doctor/consults/consult_list.dart';
import 'package:hepies/ui/pharmacy/ui/consults/consult_list.dart';
import 'package:hepies/ui/pharmacy/ui/consults/search_list.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/util/image_consult.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../constants.dart';

class PharmacyShareConsult extends StatefulWidget {
  final user_id;
  PharmacyShareConsult(this.user_id);
  @override
  _PharmacyShareConsultState createState() => _PharmacyShareConsultState();
}

class _PharmacyShareConsultState extends State<PharmacyShareConsult> {
  final formKey = new GlobalKey<FormState>();
  var _topic = new TextEditingController();
  var _search = new TextEditingController();

  XFile file;

  String name = '';
  String interestStatus = "hide";
  bool isOnSearch = false;

  List<dynamic> interests = [];
  List<dynamic> subList = [];
  void _setImage(XFile image) {
    setState(() {
      file = image;
    });
  }

  void setInterests() {
    ConsultProvider().getInterests().then((value) {
      if (!mounted) return;
      setState(() {
        interests = value;
        subList = interests.sublist(0, 5);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInterests();
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator()],
  );
  @override
  Widget build(BuildContext context) {
    ConsultProvider consult = Provider.of<ConsultProvider>(context);

    List<dynamic> interest = interests
        .where((element) => element['interest'].toLowerCase().contains(name))
        .toList();
    return SafeArea(
      child: Column(
        children: [
          // Header(),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  height: MediaQuery.of(context).size.height / 15,
                  child: TextField(
                    onChanged: (text) {
                      setState(() {
                        isOnSearch = false;
                      });
                    },
                    controller: _search,
                    decoration: InputDecoration(
                      suffixIcon: GestureDetector(
                          onTap: () {
                            // await consult.notifySearch();
                            setState(() {
                              isOnSearch = true;
                            });
                            print(
                                "current search state" + isOnSearch.toString());

                            print("Working , searching");
                          },
                          child: Icon(Icons.search)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.black38, width: 1)),
                      hintText: "Search consults by interest ...",
                      labelStyle: TextStyle(color: Colors.black45),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Row(
                  // Milkesa: Added mini image display next to consult text field
                  children: [
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: HashTagTextField(
                          decoration: InputDecoration(
                              hintText: 'Share, consult, promote, inform..',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade50, width: 0.5))),
                          basicStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
                          decoratedStyle:
                              TextStyle(fontSize: 15, color: Colors.blue),
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
                                name = text.substring(2).toLowerCase();
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
                    file != null
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
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        interestStatus == "show"
                            ? Container(
                                width: width(context) * 0.7,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  direction: Axis.horizontal,
                                  children: interest.map<Widget>((e) {
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
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ImageInputConsult(_setImage),
                            consult.shareStatus == ConsultStatus.Sharing
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
                                            var res = await consult.share(
                                                _topic.text, photo);
                                            if (res['status']) {
                                              consult.getConsults();
                                              showTopSnackBar(
                                                context,
                                                CustomSnackBar.success(
                                                  message:
                                                      "Your consult is uploaded succesfully",
                                                ),
                                              );
                                              _topic.text = "";
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
                                      child: Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                          boxShadow: [buttonShadow],
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          'Consult',
                                          textScaleFactor: 0.775,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                isOnSearch
                    ? SearchList(
                        widget.user_id, interest, _search.text.toString())
                    : FutureBuilder<List<dynamic>>(
                        future: Provider.of<ConsultProvider>(context)
                            .getConsultsbyPagination(1, 0),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return SizedBox(
                              height: 700,
                              child: ListView(
                                children: List.generate(
                                    3,
                                    (index) => Column(
                                          children: [
                                            Shimmer.fromColors(
                                              baseColor: Colors.grey.shade300,
                                              highlightColor:
                                                  Colors.grey.shade100,
                                              child: Container(
                                                //     baseColor: Colors.grey[300],
                                                // highlightColor: Colors.grey[100],
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20),
                                                height: 220,
                                                width: double.infinity,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
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
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                                width: 60,
                                                                height: 5,
                                                                color: Colors
                                                                    .grey),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                                width: 60,
                                                                height: 5,
                                                                color: Colors
                                                                    .grey),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Container(
                                                                width: 60,
                                                                height: 5,
                                                                color: Colors
                                                                    .grey),
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
                                                    Container(
                                                        width: 40,
                                                        height: 5,
                                                        color: Colors.grey),
                                                    SizedBox(
                                                      height: 40,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Container(
                                                                width: 20,
                                                                height: 20,
                                                                color: Colors
                                                                    .grey),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                                width: 40,
                                                                height: 5,
                                                                color: Colors
                                                                    .grey),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                                width: 20,
                                                                height: 20,
                                                                color: Colors
                                                                    .grey),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                                width: 40,
                                                                height: 5,
                                                                color: Colors
                                                                    .grey),
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
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Icon(
                                                                Icons.thumb_up),
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Container(
                                                                width: 40,
                                                                height: 5,
                                                                color: Colors
                                                                    .grey),
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
                                                                    color: Colors
                                                                        .grey),
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

                            // Center(
                            //   child: CircularProgressIndicator(),
                            // );
                          } else {
                            if (snapshot.data == null) {
                              return Center(
                                child: Text('No data to show'),
                              );
                            }

                            return PharmacyConsultList(
                                widget.user_id, interest);
                          }
                        }),
              ],
            ),
          ),
          Center(child: PharmacyFooter()),
        ],
      ),
    );
  }
}
