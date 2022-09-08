import 'package:flutter/material.dart';
import 'package:hepius/ui/doctor/consults/consults.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DASHBOARD PAGE"),
        elevation: 0.1,
      ),
      body: Column(
        children: [
         Consults()
        ],
      ),
    );
  }
}