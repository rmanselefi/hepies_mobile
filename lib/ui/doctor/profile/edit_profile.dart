import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/auth/login.dart';
import 'package:hepies/util/image_profile.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:hepies/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
// import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with SingleTickerProviderStateMixin {
  final formKey = new GlobalKey<FormState>();
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  XFile file;

  void _setImage(XFile image) {
    file = image;
    print("_formData_formData_formData${file}");
  }

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _fatherNameController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _phoneController = new TextEditingController();
  TextEditingController _specialityController = new TextEditingController();
  TextEditingController _workplaceController = new TextEditingController();
  TextEditingController _dobController = new TextEditingController();

  List interestList = [];

  String profile = '';
  List<dynamic> interest;
  int userId = 0;
  int professionid = 0;
  String profession = '';
  String username = '';
  String grandfathername = '';
  var _professionController;
  var _sexController;
  String points = '';
  String license = '';
  String _profession = 'Medical Doctor';
  var loadingProfile;
  List<dynamic> _interests = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
    getUserInterest();
    getInterests();
  }

  getUserInterest() async {
    print("working");
    var user = await UserProvider().getProfile();
    var interestss = user['profession'][0]['interests'] != null
        ? user['profession'][0]['interests'].split(",")
        : [];
    setState(() {
      _interests = interestss;
    });
    print("interset" + _interests.toString());
  }

  getUser() async {
    print("working user");
    Future.delayed(Duration(seconds: 5));
    setState(() {
      loadingProfile = true;
    });
    var user = await UserProvider().getProfile();
    // print("object ${user}");
    var inters = user['profession'][0]['interests'] != null
        ? user['profession'][0]['interests'].split(",")
        : [];

    setState(() {
      List interew = [];
      inters.forEach((element) {
        var property = {
          'display': "#$element",
          'value': element,
        };
        interew.add(property);
      });
      interest = interew;
      _emailController.text = user['profession'][0]['email'];
      _phoneController.text =
          user['profession'][0]['phone'].toString().substring(4);
      _specialityController.text = user['profession'][0]['speciality'];
      _workplaceController.text = user['profession'][0]['workplace'];
      profile = user['profession'][0]['profile'];
      userId = user['id'];
      professionid = user['profession'][0]['id'];
      loadingProfile = false;
    });
  }

  getInterests() async {
    print("i working");
    Future.delayed(Duration(seconds: 5));
    List interests = await ConsultProvider().getInterests();

    setState(() {
      interests.forEach((element) {
        var property = {
          'display': "#${element['interest']}",
          'value': element['interest'],
        };
        interestList.add(property);
      });
    });

    // print(interestList);
    // print("somethig");
  }

  String _selectedDate = '';
  String _dateCount = '';
  String _range = '';
  String _rangeCount = '';

  @override
  Widget build(BuildContext context) {
    UserProvider auth = Provider.of<UserProvider>(context);
    final professionField = DropdownButtonFormField(
      value: _professionController,
      items: ["Medical Doctor", "Pharmacist", "Nurse", "Health Officer"]
          .map((label) => DropdownMenuItem(
                child: Text(label.toString()),
                value: label,
              ))
          .toList(),
      hint: Text('Choose Profession'),
      onChanged: (value) {
        setState(() {
          _professionController = value;
        });
      },
    );
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Updating your profile ... Please wait")
      ],
    );
    return Scaffold(
      body: ListView(
        children: [
          Container(
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  new Container(
                    height: 300.0,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 20.0),
                            child: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: IconButton(
                                    alignment: Alignment.centerLeft,
                                    icon: new Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.black,
                                      size: 22.0,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 25.0),
                                    child: Text('PROFILE',
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20.0,
                                            fontFamily: 'sans-serif-light',
                                            color: Colors.black)),
                                  ),
                                ), // Milkessa: Logout button deleted
                              ],
                            )),
                        Expanded(
                          child: Container(
                              height: 100.0,
                              child: ImageInputProfile(_setImage, profile)),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          loadingProfile ? loadingPro : Container(),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Professional Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email ID',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Email ID"),
                                    ),
                                  ),
                                ],
                              )),
                          SizedBox(height: 15.0),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Interests',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                      child: interestList.length > 0
                                          ? MultiSelectFormField(
                                              chipBackGroundColor: Colors.red,
                                              chipLabelStyle: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              dialogTextStyle: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                              checkBoxActiveColor: Colors.red,
                                              checkBoxCheckColor: Colors.green,
                                              dialogShapeBorder:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.0))),
                                              title: Text(
                                                "Select Your interests",
                                                style: TextStyle(fontSize: 16),
                                              ),
                                              dataSource:
                                                  interestList.length > 0
                                                      ? interestList
                                                      : [],
                                              textField: 'display',
                                              valueField: 'value',
                                              okButtonLabel: 'OK',
                                              cancelButtonLabel: 'CANCEL',
                                              hintWidget: Text(
                                                  'Please choose one or more'),
                                              initialValue:
                                                  _interests.length > 0
                                                      ? _interests
                                                      : [],
                                              onSaved: (value) {
                                                if (value == null) return;
                                                // print("_interests_interests_interests ${value.join(",")}");

                                                setState(() {
                                                  _interests = value;
                                                });
                                              },
                                            )
                                          : Container()),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Speciality',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: new Text(
                                        'Workplace',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Flexible(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
                                      child: new TextField(
                                        controller: _specialityController,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Speciality"),
                                      ),
                                    ),
                                    flex: 2,
                                  ),
                                  Flexible(
                                    child: new TextField(
                                      controller: _workplaceController,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Work Place"),
                                    ),
                                    flex: 2,
                                  ),
                                ],
                              )),
                          auth.registeredInStatus == Status.Authenticating
                              ? loading
                              : _getActionButtons(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  var loadingPro = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("Loading Profile ... Please wait")
    ],
  );

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Save"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: () async {
                  var finalInterest = _interests.join(",");
                  print("interestsinterestsinterests $finalInterest");
                  User user = new User(
                      userId: userId,
                      username: username,
                      professionid: professionid,
                      profession: _professionController,
                      name: _nameController.text,
                      fathername: _fatherNameController.text,
                      grandfathername: grandfathername,
                      workplace: _workplaceController.text,
                      speciality: _specialityController.text,
                      email: _emailController.text,
                      phone: '+251' + _phoneController.text,
                      points: points,
                      interests: finalInterest,
                      license: license,
                      sex: _sexController,
                      dob: _selectedDate);
                  var res = await Provider.of<UserProvider>(context,
                          listen: false)
                      .updateProfile(
                          user, file != null ? File(file.path) : null, profile);
                  if (res['status']) {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.success(
                        message: 'Your profile is updated',
                      ),
                    );
                  } else {
                    showTopSnackBar(
                      context,
                      CustomSnackBar.error(
                        message: "Unable to update your profile",
                      ),
                    );
                  }
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(
                child: new Text("Cancel"),
                textColor: Colors.white,
                color: Colors.red,
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    _status = true;
                    FocusScope.of(context).requestFocus(new FocusNode());
                  });
                },
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(20.0)),
              )),
            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  label(String title) => Padding(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 2.0),
        child: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      );
}
