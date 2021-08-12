import 'package:flutter/material.dart';
import 'package:hepies/widgets/header.dart';

class Points extends StatefulWidget {
  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Header(),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child:Container(
            padding: EdgeInsets.all(60.0),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.green, width: 2),
                borderRadius: BorderRadius.circular(150.0)),
            child: Text(
              '126Pts',
              style: TextStyle(color: Colors.green, fontSize:40.0),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text('But Air Time',
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontSize: 25.0,
              color: Colors.green
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1),
                  borderRadius: BorderRadius.circular(100.0)),
              child: Text('50 Birr',style: TextStyle(
                color:Colors.green,
                fontSize: 18.0
              ),),
            ),
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green, width: 1),
                  borderRadius: BorderRadius.circular(100.0)),
              child:Text('100 Birr',style: TextStyle(
                  color:Colors.green,
                  fontSize: 18.0
              ),),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Center(
          child: Text('Transfer to other professional',
            style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 25.0,
                color: Colors.green
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Phone number',style: TextStyle(
                fontSize: 25.0,
                color: Colors.green
            ),),
            Container(
              height: 40,
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number',
                    hintText: 'Phone Number'),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Amount',style: TextStyle(
                fontSize: 25.0,
                color: Colors.green
            ),),
            Container(
              height: 40,
              width: 200,
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                    hintText: 'Amount'),
              ),
            )
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Container(
              width: 100,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 2
                ),
                borderRadius: BorderRadius.circular(100.0)
              ),
              child: Center(
                child: Text('send',style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.green
                ),),
              ),
            ),
          ),
        )
      ],
    );
  }
}
