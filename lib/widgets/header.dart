import 'package:flutter/material.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/doctor/points/points.dart';
import 'package:hepies/ui/doctor/profile/edit_profile.dart';
import 'package:hepies/ui/welcome.dart';
import 'package:hepies/util/gradient_text.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:provider/provider.dart';

class Header extends StatefulWidget {
  Header();
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
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            IconButton(
                icon: Icon(
                  Icons.person,
                  size: 25.0,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                }),
            Text('$name'),
            Text(
              '($profession)',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
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
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Points(
                          points: points,
                        )));
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Flexible(
                child: Text('Overall 1567pts',
                    style: TextStyle(color: Colors.green)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
