import 'package:flutter/material.dart';
import 'package:hepius/constants.dart';
import 'package:hepius/providers/user_provider.dart';
import 'package:hepius/ui/doctor/points/points.dart';
import 'package:hepius/ui/welcome.dart';
import 'package:hepius/util/gradient_text.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  var name;
  var profession;
  var points;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserProvider().getProfile().then((user) {
      setState(() {
        name = user['profession'][0]['name'];
        profession = user['profession'][0]['proffesion'];
        points = user['profession'][0]['points'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(width: width(context) * 0.2),
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Welcome(
                          currenIndex: 0,
                        )));
          },
          child: GradientText(
            'Hepius',
            gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.blue,
            ]),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Points(
                            points: points,
                          )));
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.green, width: 2),
                      borderRadius: BorderRadius.circular(35.0)),
                  child: Text(
                    '${points ?? 0} Pts',
                    style: TextStyle(color: Colors.green, fontSize: 18.0),
                  ),
                ),
                Text('Overall 1567pts', style: TextStyle(color: Colors.green))
              ],
            ),
          ),
        )
      ],
    );
  }
}
