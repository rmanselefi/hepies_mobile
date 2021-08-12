import 'package:flutter/material.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/drug_provider.dart';
import 'package:hepies/ui/consults/consults.dart';
import 'package:hepies/ui/consults/share_consult.dart';
import 'package:hepies/ui/drugs/drugs.dart';
import 'package:hepies/ui/points/points.dart';
import 'package:provider/provider.dart';

class Welcome extends StatefulWidget {
  final User user;
  final int currenIndex;
  Welcome({this.user, this.currenIndex});
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    Consults(),
    Drugs(),
    Points(),
    ShareConsult()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _selectedIndex = widget.currenIndex != null ? widget.currenIndex : 0;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Provider.of<DrugProvider>(context).getDrugs();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Colors.green.shade400),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_pharmacy_outlined,
                    color: Colors.green.shade400),
                label: 'Drugs',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.format_indent_increase,
                    color: Colors.green.shade400),
                label: 'Points',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.phone_in_talk, color: Colors.green.shade400),
                label: 'Consult',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.green[800],
            onTap: _onItemTapped,
          ),
          body: _widgetOptions.elementAt(_selectedIndex)),
    );
  }
}
