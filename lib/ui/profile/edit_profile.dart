import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/auth/login.dart';
import 'package:hepies/util/image_profile.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:hepies/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';

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

  String profile = '';
  String interest = '';
  int userId = 0;
  int professionid = 0;
  String profession = '';
  String username = '';
  String grandfathername = '';
  var _professionController;
  String points = '';
  String license = '';
  String _profession = 'Medical Doctor';
  List<dynamic> _interests = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  getUser() async {
    var user = await UserPreferences().getUser();
    print("object ${user.username}");
    _nameController.text = user.name;
    _fatherNameController.text = user.fathername;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _specialityController.text = user.speciality;
    _workplaceController.text = user.workplace;
    profile = user.profile;
    interest = user.interests;
    userId = user.userId;
    profession = user.profession;
    username = user.username;
    grandfathername = user.grandfathername;
    points = user.points;
    license = user.license;
    professionid = user.professionid;
  }

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
    var _interests;

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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                IconButton(
                                  icon: new Icon(
                                    Icons.arrow_back_ios,
                                    color: Colors.black,
                                    size: 22.0,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 25.0),
                                  child: new Text('PROFILE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          fontFamily: 'sans-serif-light',
                                          color: Colors.black)),
                                ),
                                IconButton(
                                    icon: Icon(Icons.logout),
                                    onPressed: () async {
                                      await Provider.of<AuthProvider>(context,
                                              listen: false)
                                          .logout();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Login()),
                                          (route) => false);
                                    })
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
                                        'Personal Information',
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
                                        'Name',
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
                                    child: new TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name",
                                      ),
                                      controller: _nameController,
                                      validator: (val) =>
                                          val.isEmpty ? 'Name is required' : '',
                                    ),
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
                                        'Father Name',
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
                                    child: new TextFormField(
                                      validator: (val) => val.isEmpty
                                          ? 'Father Name is required'
                                          : '',
                                      controller: _fatherNameController,
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Father Name",
                                      ),
                                    ),
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
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          SizedBox(height: 15.0),
                          label("Profession"),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 25.0, right: 25.0, top: 2.0),
                            child: professionField,
                          ),
                          SizedBox(height: 15.0),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: _phoneController,
                                      decoration: const InputDecoration(
                                          hintText: "Enter Mobile Number"),
                                    ),
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
                                      child: new MultiSelectFormField(
                                    autovalidate: false,
                                    chipBackGroundColor: Colors.red,
                                    chipLabelStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    dialogTextStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    checkBoxActiveColor: Colors.red,
                                    checkBoxCheckColor: Colors.green,
                                    dialogShapeBorder: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0))),
                                    title: Text(
                                      "Select Your interests",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    dataSource: [
                                      {
                                        "display": "#Dermatology",
                                        "value": "Dermatology",
                                      },
                                      {
                                        "display": "#ENT",
                                        "value": "ENT",
                                      },
                                      {
                                        "display": "#Gastroenterology",
                                        "value": "Gastroenterology",
                                      },
                                      {
                                        "display": "#General",
                                        "value": "General",
                                      },
                                      {
                                        "display": "#Gynecology",
                                        "value": "Gynecology",
                                      },
                                      {
                                        "display": "#InfectiousDisease",
                                        "value": "InfectiousDisease",
                                      },
                                    ],
                                    textField: 'display',
                                    valueField: 'value',
                                    okButtonLabel: 'OK',
                                    cancelButtonLabel: 'CANCEL',
                                    hintWidget:
                                        Text('Please choose one or more'),
                                    initialValue: _interests,
                                    onSaved: (value) {
                                      if (value == null) return;
                                      print("object ${value.join(",")}");
                                      setState(() {
                                        _interests = value;
                                      });
                                    },
                                  )),
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

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text(" Authenticating ... Please wait")
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
                  var interests = _interests.join(",");
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
                      phone: _phoneController.text,
                      points: points,
                      interests: interests,
                      license: license);
                  var res =
                      await Provider.of<UserProvider>(context, listen: false)
                          .updateProfile(
                              user, file != null ? File(file.path) : null,profile);
                  if (res['status']) {
                    Flushbar(
                      title: 'Sent',
                      message: 'Your profile is updated',
                      duration: Duration(seconds: 10),
                    ).show(context);
                  } else {
                    Flushbar(
                      title: 'Error',
                      message: 'Unable to update your profile',
                      duration: Duration(seconds: 10),
                    ).show(context);
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
