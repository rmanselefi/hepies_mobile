import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_linear_datepicker/flutter_datepicker.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/auth/login.dart';
import 'package:hepies/ui/welcome.dart';
import 'package:hepies/util/image.dart';
import 'package:hepies/util/validators.dart';
import 'package:hepies/util/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = new GlobalKey<FormState>();
  bool rememberMe = false;
  TapGestureRecognizer _tapRecognizer;
  String _selectedDate = '';
  String _range = '';

  var passwordController = new TextEditingController();
  List interestList = [];

  @override
  void initState() {
    super.initState();
    _tapRecognizer = TapGestureRecognizer()..onTap = _handlePress;
    getInterests();
  }

  @override
  void dispose() {
    _tapRecognizer.dispose();
    super.dispose();
  }

  void _handlePress() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
        child: Container(
          width: width(context) * 0.8,
          height: height(context) * 0.4,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 10),
              Text(
                'Terms & Conditions',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Text(
                  'The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. The quick brown fox jumps over the lazy dog. ',
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Center(
                      child: Container(
                        width: width(context) * 0.2375,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Color(0xff07febb),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                rememberMe = true;
                              });
                              Navigator.pop(context);
                            },
                            child: Center(
                              child: Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'Agree',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  getInterests() async {
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
  }

  String _username,
      _password,
      _confirmPassword,
      _name,
      _fathername,
      _phone,
      _interest;
  XFile file;
  var _professionController;
  var _sexController;

  List<dynamic> _myInterests = [];
  void _setImage(XFile image) {
    setState(() {
      file = image;
    });
    print("_formData_formData_formData${file}");
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final nameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter your name" : null,
      onSaved: (value) => _name = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );

    final fatherNameField = TextFormField(
      autofocus: false,
      validator: (value) =>
          value.isEmpty ? "Please enter your father name" : null,
      onSaved: (value) => _fathername = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );

    final phoneField = TextFormField(
      autofocus: false,
      maxLength: 9,
      keyboardType: TextInputType.number,
      validator: (value) =>
          value.isEmpty ? "Please enter your phone number" : null,
      onSaved: (value) => _phone = '+251' + value,
      decoration: buildInputDecoration("Confirm password", Icons.contact_phone),
    );

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

    final dateField = LinearDatePicker(
        startDate: "1900/01/01", //yyyy/mm/dd
        endDate: "2019/01/01",
        initialDate: "1980/01/01",
        dateChangeListener: (String selectedDate) {
          _selectedDate = selectedDate;
          print(_selectedDate);
        },
        showDay: true, //false -> only select year & month
        labelStyle: TextStyle(
          fontSize: 17.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        selectedRowStyle: TextStyle(
          fontSize: 16.0,
          color: Colors.deepOrange,
        ),
        unselectedRowStyle: TextStyle(
          fontSize: 15.0,
          color: Colors.blueGrey,
        ),
        yearText: "Year",
        monthText: "Month",
        dayText: "Day",
        showLabels: true, // to show column captions, eg. year, month, etc.
        columnWidth: width(context) * 0.25,
        showMonthName: true,
        isJalaali: false // false -> Gregorian
        );

    final sexField = DropdownButtonFormField(
      value: _sexController,
      items: ["Male", "Female"]
          .map((label) => DropdownMenuItem(
                child: Text(label.toString()),
                value: label,
              ))
          .toList(),
      hint: Text('Choose Sex'),
      onChanged: (value) {
        setState(() {
          _sexController = value;
        });
      },
    );

    final interestField = new MultiSelectFormField(
      chipBackGroundColor: Colors.red,
      chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
      checkBoxActiveColor: Colors.red,
      checkBoxCheckColor: Colors.green,
      dialogShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      title: Text(
        "Select Your interests",
        style: TextStyle(fontSize: 16),
      ),
      dataSource: interestList,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      hintWidget: Text('Please choose one or more'),
      initialValue: _myInterests,
      onSaved: (value) {
        if (value == null) return;
        // print("_interests_interests_interests ${value.join(",")}");

        setState(() {
          _myInterests = value;
        });
      },
    );

    final usernameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter your username" : null,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("Confirm password", Icons.person),
    );

    final passwordField = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) =>
          value != passwordController.text ? "Passwords don't match!" : null,
      onSaved: (value) => _confirmPassword = value,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Registering ... Please wait")
      ],
    );

    var doRegister = () {
      var interests = _myInterests.join(",");
      final form = formKey.currentState;
      if (form.validate() && file != null) {
        form.save();
        auth
            .register(
                _name,
                _fathername,
                _username,
                _phone,
                _password,
                _professionController,
                _sexController,
                _selectedDate,
                interests,
                File(file.path))
            .then((response) {
          if (response['status']) {
            showTopSnackBar(
              context,
              CustomSnackBar.success(
                message: "Registration Successful. Please login",
              ),
            );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => Login()),
              ModalRoute.withName('/'),
            );
          } else {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: response['message'],
              ),
            );
          }
        });
      } else {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: "Please Complete the form properly",
          ),
        );
      }
    };

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(40.0),
          child: ListView(
            children: [
              Text(
                'Hepies',
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
              ),
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 15.0),
                    label("Name"),
                    SizedBox(height: 5.0),
                    nameField,
                    SizedBox(height: 15.0),
                    label("Father name"),
                    SizedBox(height: 10.0),
                    fatherNameField,
                    SizedBox(height: 15.0),
                    label("Phone number"),
                    SizedBox(height: 10.0),
                    phoneField,
                    SizedBox(height: 15.0),
                    label("Profession"),
                    SizedBox(height: 5.0),
                    professionField,
                    SizedBox(height: 5.0),
                    label("Sex"),
                    SizedBox(height: 5.0),
                    sexField,
                    SizedBox(height: 5.0),
                    label("Date of Birth"),
                    SizedBox(height: 5.0),
                    dateField,
                    SizedBox(height: 15.0),
                    label("Select your interests"),
                    SizedBox(height: 5.0),
                    interestField,
                    SizedBox(height: 15.0),
                    label("Upload your medical license"),
                    SizedBox(height: 5.0),
                    ImageInput(_setImage),
                    SizedBox(height: 15.0),
                    label("Username"),
                    SizedBox(height: 5.0),
                    usernameField,
                    SizedBox(height: 15.0),
                    label("Password"),
                    SizedBox(height: 10.0),
                    passwordField,
                    SizedBox(height: 15.0),
                    label("Confirm Password"),
                    SizedBox(height: 10.0),
                    confirmPassword,
                    //'By signing up, you agree to our Terms Conditions and Privacy Policy'
                    CheckboxListTile(
                      title: RichText(
                        textAlign: TextAlign.start,
                        maxLines: 2,
                        text: TextSpan(
                          text: 'By signing up, you agree to our ',
                          style: TextStyle(fontSize: 14, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Terms Conditions and Privacy Policy',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.blue),
                              recognizer: _tapRecognizer,
                              mouseCursor: SystemMouseCursors.precise,
                            ),
                          ],
                        ),
                      ),
                      value: rememberMe,
                      onChanged: (newValue) {
                        setState(() {
                          rememberMe = newValue;
                        });
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    SizedBox(height: 20.0),
                    auth.loggedInStatus == Status.Authenticating
                        ? loading
                        : longButtons("Register", !rememberMe, doRegister),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
