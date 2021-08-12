import 'package:flutter/material.dart';
import 'package:hepies/ui/medicalrecords/personal_info.dart';
import 'package:hepies/widgets/header.dart';
import 'package:intl/intl.dart';

class ResultDetail extends StatefulWidget {
  final patient;
  final createdAt;
  ResultDetail(this.patient,this.createdAt);
  @override
  _ResultDetailState createState() => _ResultDetailState();
}

class _ResultDetailState extends State<ResultDetail> {
  @override
  Widget build(BuildContext context) {



    var date = DateFormat.yMMMd()
        .format(DateTime.parse(widget.createdAt));
    var hour = DateFormat.jm()
        .format(DateTime.parse(widget.createdAt));
    return Scaffold(
      body: ListView(
        children: [
          Header(),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    PersonalInfo(widget.patient),
                    MaterialButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                      },
                      child: Text('Back'),
                      color: Color(0xff07febb),
                      textColor: Colors.black,
                    )
                  ],
                ),
                Center(
                  child: Container(
                    child: Text('$date                           $hour',style: TextStyle(
                      color: Colors.greenAccent,
                        decoration: TextDecoration.underline,
                        fontSize: 23.0
                    ),),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('HX',style: TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 25.0
                      ),),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('PX',style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 25.0
                      ),),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('IX',style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 25.0
                      ),),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('DX',style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 25.0
                      ),),
                    )
                  ],
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text('RX',style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 25.0
                      ),),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
