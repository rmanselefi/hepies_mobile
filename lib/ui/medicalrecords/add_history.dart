import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hepies/models/dx.dart';
import 'package:hepies/models/hx.dart';
import 'package:hepies/models/investigation.dart';
import 'package:hepies/models/px.dart';
import 'package:hepies/ui/medicalrecords/historypages/dx.dart';
import 'package:hepies/ui/medicalrecords/historypages/hx.dart';
import 'package:hepies/ui/medicalrecords/historypages/ix.dart';
import 'package:hepies/ui/medicalrecords/historypages/px.dart';
import 'package:hepies/ui/prescription/prescription_types/general_prescription.dart';
import 'package:hepies/ui/prescription/write_prescription.dart';
import 'package:hepies/widgets/header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddHistory extends StatefulWidget {
  final pageNumber;
  final Function setHx;
  final Function setDx;
  final Function setPx;
  AddHistory({this.pageNumber,this.setHx,this.setPx,this.setDx});

  @override
  _AddHistoryState createState() => _AddHistoryState();
}

class _AddHistoryState extends State<AddHistory>
    with AutomaticKeepAliveClientMixin {
  var history = new History();
  var physical = new Physical();
  var diagnosis = new Diagnosis();
  var ix = new Investigation();
  int _selectedPage = 0;
  PageController _pageController;

  void _changePage(int pageNum) {
    setState(() {
      _selectedPage = pageNum;
      _pageController.animateToPage(
        pageNum,
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    });
  }

  @override
  void initState() {
    _pageController = PageController(
        initialPage: widget.pageNumber != null ? widget.pageNumber : 0);
    _selectedPage = widget.pageNumber != null ? widget.pageNumber : 0;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: 2 * MediaQuery.of(context).size.height / 3+180,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12.0,
                  ),
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 0.0),
                        child: IconButton(
                            icon: Icon(Icons.arrow_back),
                            onPressed: () {
                              Navigator.of(context).pop();
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        width: 300.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TabButton(
                              text: "HX",
                              pageNumber: 0,
                              selectedPage: _selectedPage,
                              onPressed: () {
                                _changePage(0);
                              },
                            ),
                            TabButton(
                              text: "PX",
                              pageNumber: 1,
                              selectedPage: _selectedPage,
                              onPressed: () {
                                _changePage(1);
                              },
                            ),
                            TabButton(
                              text: "IX",
                              pageNumber: 2,
                              selectedPage: _selectedPage,
                              onPressed: () {
                                _changePage(2);
                              },
                            ),
                            TabButton(
                              text: "DX",
                              pageNumber: 3,
                              selectedPage: _selectedPage,
                              onPressed: () {
                                _changePage(3);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                    onPageChanged: (int page) {
                      setState(() {
                        _selectedPage = page;
                      });
                    },
                    controller: _pageController,
                    children: [HX(widget.setHx), PX(widget.setPx), IX(), DX(widget.setDx)],
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () async {
              print("hxhxhx ${history.cc}  ${history.hpi}");
              print("pxpxpxpxpx ${physical.rs}  ${physical.heent}");
              print("dxdxdx ${diagnosis.diagnosis}");
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              var type = prefs.getString('type');
              Navigator.of(context).pop();
            },
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 100,
                height: 40,
                margin: EdgeInsets.only(right: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    color: Color(0xff07febb),
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10.0)),
                child: Center(
                    child: Text(
                  'Save',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TabButton extends StatelessWidget {
  final String text;
  final int selectedPage;
  final int pageNumber;
  final Function onPressed;
  TabButton({this.text, this.selectedPage, this.pageNumber, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: selectedPage == pageNumber ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(4.0),
        ),
        padding: EdgeInsets.symmetric(
          vertical: selectedPage == pageNumber ? 12.0 : 0,
          horizontal: selectedPage == pageNumber ? 20.0 : 0,
        ),
        // margin: EdgeInsets.symmetric(
        //   vertical: selectedPage == pageNumber ? 0 : 12.0,
        //   horizontal: selectedPage == pageNumber ? 0 : 20.0,
        // ),
        child: Text(
          text ?? "Tab Button",
          style: TextStyle(
            color: selectedPage == pageNumber ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
