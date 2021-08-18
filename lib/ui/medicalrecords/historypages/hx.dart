import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/models/hx.dart';

class HX extends StatefulWidget {
  final Function setHx;
  HX(this.setHx);

  @override
  _HXState createState() => _HXState();
}

class _HXState extends State<HX>  with AutomaticKeepAliveClientMixin {
  var hx=new History();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Input History',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 25.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'C/C',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0,right: 15.0),
          child: TextField(
            onChanged: (val){
              hx.cc = val;
              print("object ${hx.cc}");
              widget.setHx(hx);
            },
            maxLines: 6,
            decoration: InputDecoration(
                hintText: 'CC',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Text(
            'HPI',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 15.0,right: 15.0),
          child: TextField(
            onChanged: (val){
              hx.hpi = val;
              print("object ${hx.hpi}");
              widget.setHx(hx);
            },
            maxLines: 12,
            decoration: InputDecoration(
                hintText: 'HPI',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
