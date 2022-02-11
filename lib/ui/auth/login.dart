import 'package:flutter/material.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/ui/auth/sign_up.dart';
import 'package:hepies/ui/pharmacy/ui/consults/share_consult.dart';
import 'package:hepies/ui/pharmacy/welcome.dart';
import 'package:hepies/ui/welcome.dart';
import 'package:hepies/util/validators.dart';
import 'package:hepies/util/widgets.dart';

import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String _username, _password;
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    InputDecoration buildInputDecorationn(String hintText, IconData icon) {
      return InputDecoration(
        prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        suffixIcon: IconButton(
            icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
              });
            }),
      );
    }

    final usernameField = TextFormField(
        autofocus: false,
        validator: (value) => value.isEmpty ? "Please enter username" : null,
        onSaved: (value) => _username = value,
        decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.person, color: Color.fromRGBO(50, 62, 72, 1.0)),
          hintText: "Username",
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ));

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: _isObscure,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecorationn("Password", Icons.lock),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        TextButton(
          child: Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        TextButton(
          child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.w300)),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Register()));
          },
        ),
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
            auth.login(_username, _password);

        successfulMessage.then((response) {
          print("object $response");
          if (response['status']) {
            User user = response['user'];
            var role = response['role'];

            Provider.of<UserProvider>(context, listen: false).setUser(user);
            if (role == "doctor" ||
                role == "healthofficer" ||
                role == "nurse") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => Welcome(
                          user: user,
                        )),
                ModalRoute.withName('/'),
              );
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => WelcomePharmacy()));
            }
          } else {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: response['message'].toString() ??
                    'Wrong username or password entered, try again!',
              ),
            );
          }
        });
      } else {
        print("form is invalid");
      }
    };

    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Text(
                  'Hepius',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                SizedBox(height: 15.0),
                label("Username"),
                SizedBox(height: 5.0),
                usernameField,
                SizedBox(height: 20.0),
                label("Password"),
                SizedBox(height: 5.0),
                passwordField,
                SizedBox(height: 20.0),
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons("Login", false, doLogin),
                SizedBox(height: 5.0),
                forgotLabel,
                SizedBox(
                  height: 300.0,
                ),
                Center(child: Text("Copyright @2021 Hepius Pvt.Ltd.Co"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
