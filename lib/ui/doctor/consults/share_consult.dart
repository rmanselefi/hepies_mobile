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
import 'package:hepies/util/helpers.dart';

class ShareConsult extends StatefulWidget {
  final user_id;
  ShareConsult(this.user_id);
  @override
  _ShareConsultState createState() => _ShareConsultState();
}

class _ShareConsultState extends State<ShareConsult> {
  ScrollController _parentScrollController = ScrollController();
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
            
            Expanded(
                child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
              controller: _parentScrollController,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
                        hintText: "Search consults  ...",
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
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                      height: MediaQuery.of(context).size.height / 16,
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
                          widget.user_id,
                          interest,
                          capitalize(_search.text.toString()),
                          _parentScrollController)
                      : PharmacyConsultList(
                          widget.user_id, interest, _parentScrollController)
                ],
              ),
            )),
            Footer(),
          ],
        ),
      ),
    );
  }
}
