import 'package:flutter/material.dart';
import 'package:hepies/models/dx.dart';

class DX extends StatefulWidget {
  final Function setDx;
  DX(this.setDx);
  @override
  _DXState createState() => _DXState();
}

class _DXState extends State<DX>  with AutomaticKeepAliveClientMixin {
  var dx = new Diagnosis();
  List<dynamic> diags = ["", "", "", "", ""];
  void setDiagnosis(val, id) {
    diags[id] = val;
    setState(() {
      diags = diags;
    });
    print("object ${diags}");
    dx.diagnosis_list = diags;
    widget.setDx(dx);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Input Assessment',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Form(
          child: Column(
            children: [
              Column(
                children: diags.map<Widget>((e) {
                  var index = diags.indexOf(e);
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 15.0),
                        child: TextFormField(
                          onSaved: (val) => setDiagnosis(val, index),
                          onChanged: (val) => setDiagnosis(val, index),
                          maxLines: 1,
                          decoration: InputDecoration(
                              hintText: '',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black45, width: 2))),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
              // SizedBox(
              //   height: 20.0,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child: Text(
              //     "2",
              //     style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(left: 10.0, right: 15.0),
              //   child: TextFormField(
              //     onSaved: (val) {
              //       setDiagnosis(val);
              //     },
              //     maxLines: 1,
              //     decoration: InputDecoration(
              //         hintText: '',
              //         border: OutlineInputBorder(
              //             borderSide:
              //                 BorderSide(color: Colors.black45, width: 2))),
              //   ),
              // ),
              // SizedBox(
              //   height: 20.0,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child: Text(
              //     "3",
              //     style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(left: 10.0, right: 15.0),
              //   child: TextFormField(
              //     onSaved: (val) {
              //       setDiagnosis(val);
              //     },
              //     maxLines: 1,
              //     decoration: InputDecoration(
              //         hintText: '',
              //         border: OutlineInputBorder(
              //             borderSide:
              //                 BorderSide(color: Colors.black45, width: 2))),
              //   ),
              // ),
              // SizedBox(
              //   height: 20.0,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child: Text(
              //     "4",
              //     style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              //   ),
              // ),
              // Padding(
              //   padding: EdgeInsets.only(left: 10.0, right: 15.0),
              //   child: TextFormField(
              //     onSaved: (val) {
              //       setDiagnosis(val);
              //     },
              //     maxLines: 1,
              //     decoration: InputDecoration(
              //         hintText: '',
              //         border: OutlineInputBorder(
              //             borderSide:
              //                 BorderSide(color: Colors.black45, width: 2))),
              //   ),
              // ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
