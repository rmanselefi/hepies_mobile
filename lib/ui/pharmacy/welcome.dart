import 'package:flutter/material.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/doctor/consults/consults.dart';
import 'package:hepies/ui/doctor/consults/share_consult.dart';
import 'package:hepies/ui/doctor/drugs/drugs.dart';
import 'package:hepies/ui/doctor/points/points.dart';
import 'package:hepies/ui/doctor/profile/edit_profile.dart';
import 'package:hepies/ui/pharmacy/ui/consults/share_consult.dart';
import 'package:hepies/util/gradient_text.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:hepies/widgets/drawer.dart';
import 'package:provider/provider.dart';

class WelcomePharmacy extends StatefulWidget {
  final User user;
  final int currenIndex;
  WelcomePharmacy({this.user, this.currenIndex});
  @override
  _WelcomePharmacyState createState() => _WelcomePharmacyState();
}

class _WelcomePharmacyState extends State<WelcomePharmacy> {
  var user_id;
  var name;
  var profession;
  var points;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserProvider().getProfile().then((user) {
      setState(() {
        user_id = user['id'];
        name = user['profession'][0]['name'];
        profession = user['profession'][0]['proffesion'];
        points = user['profession'][0]['points'];
      });
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<DrugProvider>(context).getDrugs();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

    return SafeArea(
        child: Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          titleSpacing: 0.0,
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Color(0xff0FF683),
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          flexibleSpace: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WelcomePharmacy(
                                  currenIndex: 0,
                                )));
                  },
                  child: GradientText(
                    'Hepius',
                    gradient: LinearGradient(colors: [
                      Colors.blue.shade400,
                      Colors.blue.shade900,
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
                    children: [
                      SizedBox(
                        height: 10.0,
                      ),
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
                      Text('Overall 1567pts',
                          style: TextStyle(color: Colors.green))
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[],
        ),
      ),
      drawer: DrawerCustom(name, profession),
      body: PharmacyShareConsult(user_id),
    ));
  }
}
