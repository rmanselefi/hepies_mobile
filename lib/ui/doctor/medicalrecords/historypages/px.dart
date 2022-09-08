import 'package:flutter/material.dart';
import 'package:hepius/models/px.dart';

class PX extends StatefulWidget {
  final Function setPx;
  PX(this.setPx);
  @override
  _PXState createState() => _PXState();
}

class _PXState extends State<PX>  with AutomaticKeepAliveClientMixin {
  var px = new Physical();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      shrinkWrap: true,
      children: [
        Center(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Input Physical',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Vital Sign',
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'BP',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: 100,
              child: TextField(
                onChanged: (val) {
                  px.bp = val;
                  print("object ${px.bp}");
                  widget.setPx(px);
                },
              ),
            ),
            Text(
              '/',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: 50,
              child: TextField(),
            ),
            Text(
              'mmgh',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'PR',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: 200,
              child: TextField(
                onChanged: (val) {
                  px.pr = val;
                  print("object ${px.pr}");
                  widget.setPx(px);
                },
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            Text(
              '/min',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                'RR',
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: 200,
              child: TextField(
                onChanged: (val) {
                  px.rr = val;
                  print("object ${px.rr}");
                  widget.setPx(px);
                },
              ),
            ),
            Text(
              '/min',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "T°",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              width: 200,
              child: TextField(
                onChanged: (val) {
                  px.temp = val;
                  print("object ${px.temp}");
                  widget.setPx(px);
                },
              ),
            ),
            Text(
              'C',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                "General Appearance",
                style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 0.0, left: 10),
              width: 150,
              child: TextField(
                  onChanged: (val) {
                    px.general_apearance = val;
                    print("object ${px.general_apearance}");
                    widget.setPx(px);
                  },
                  decoration: InputDecoration(
                      hintText: 'General Appearance',
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black45, width: 2)))),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "HEENT",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0),
          child: TextField(
            onChanged: (val) {
              px.heent = val;
              print("object ${px.heent}");
              widget.setPx(px);
            },
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'HEENT',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "LGS",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0),
          child: TextField(
            onChanged: (val) {
              px.lgs = val;
              print("object ${px.lgs}");
              widget.setPx(px);
            },
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'LGS',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "RS",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0),
          child: TextField(
            onChanged: (val) {
              px.rs = val;
              print("object ${px.rs}");
              widget.setPx(px);
            },
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'RS',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "CVS",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0),
          child: TextField(
            onChanged: (val) {
              px.cvs = val;
              print("object ${px.cvs}");
              widget.setPx(px);
            },
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'CVS',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "Abd",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0),
          child: TextField(
            onChanged: (val) {
              px.abd = val;
              print("object ${px.abd}");
              widget.setPx(px);
            },
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'Abd',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "GUS",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0),
          child: TextField(
            onChanged: (val) {
              px.gus = val;
              print("object ${px.gus}");
              widget.setPx(px);
            },
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'GUS',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "MSK",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0),
          child: TextField(
            onChanged: (val) {
              px.msk = val;
              print("object ${px.msk}");
              widget.setPx(px);
            },
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'MSK',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "IntS",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0),
          child: TextField(
            onChanged: (val) {
              px.ints = val;
              print("object ${px.ints}");
              widget.setPx(px);
            },
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'IntS',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            "CNS",
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 10.0, right: 15.0),
          child: TextField(
            onChanged: (val) {
              px.cns = val;
              print("object ${px.cns}");
              widget.setPx(px);
            },
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'CNS',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45, width: 2))),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
