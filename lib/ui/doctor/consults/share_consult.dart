import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/ui/doctor/consults/consult_list.dart';
import 'package:hepies/ui/doctor/consults/post_consult.dart';
import 'package:hepies/ui/pharmacy/ui/consults/consult_list.dart';
import 'package:hepies/ui/pharmacy/ui/consults/search_list.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/util/image_consult.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ShareConsult extends StatefulWidget {
  final user_id;
  ShareConsult(this.user_id);
  @override
  _ShareConsultState createState() => _ShareConsultState();
}

class _ShareConsultState extends State<ShareConsult> {
  var _search = new TextEditingController();
  bool isOnSearch = false;
  // XFile file;
  List<dynamic> interests = [];
  List<dynamic> subList = [];

  var name = '';

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

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
        return;
      },
      child: SafeArea(
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
                    height: MediaQuery.of(context).size.height / 18,
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
                              print("current search state" +
                                  isOnSearch.toString());

                              print("Working , searching ${_search.text}");
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
                  Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        readOnly: true,
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (_) => PostConsult()));
                        },
                        decoration: InputDecoration(
                          hintText: "Share your consults....",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                        ),
                      )),
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
                                                        CrossAxisAlignment
                                                            .start,
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
                                                              Icon(Icons
                                                                  .thumb_up),
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
                                                                    Icons
                                                                        .comment,
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
            Footer(),
          ],
        ),
      ),
    );
  }
}
