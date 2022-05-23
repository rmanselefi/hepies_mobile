
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/doctor/points/points.dart';
import 'package:hepies/ui/pharmacy/ui/consults/share_consult.dart';
import 'package:hepies/util/gradient_text.dart';
import 'package:hepies/widgets/drawer.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';

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
  var profile;
  var points;
  var overallPoints;
  var f;
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
        profile = user['profession'][0]['profile'];
        overallPoints = user['profession'][0]['overall_points'];
      });
    });
    f = NumberFormat.decimalPattern("en_US");
  }

  Future<void> initLocalDrugList() async {
    await Hive.openBox('drugList');
    await Provider.of<DrugProvider>(context, listen: false).putDrugsLocal();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    initLocalDrugList();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
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
          flexibleSpace: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(child: SizedBox(width: width(context) * 0.225)),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WelcomePharmacy(
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
                ),
                Flexible(child: SizedBox(width: width(context) * 0.2)),
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
                          '${f.format(double.parse(points != null ? points : '0')) ?? 0} Pts',
                          style: TextStyle(color: Colors.green, fontSize: 18.0),
                        ),
                      ),
                      Text(
                          'Overall ${f.format(double.parse(overallPoints != null ? overallPoints : '0')) ?? ' - '}pts',
                          style: TextStyle(color: Colors.green, fontSize: 12.0))
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: <Widget>[],
        ),
      ),
      drawer: DrawerCustom(name, profession, profile),
      body: WillPopScope(
          onWillPop: () {
            return SystemNavigator.pop();
          },
          child: PharmacyShareConsult(user_id)),
    ));
  }
}
