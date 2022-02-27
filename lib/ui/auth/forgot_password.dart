import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/ui/auth/newPassword.dart';
import 'package:hepies/util/widgets.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final emailField = TextFormField(
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        validator: (value) => value.isEmpty ? "Please enter email" : null,
        onSaved: (value) => email = value,
        decoration: InputDecoration(
          prefixIcon:
              Icon(Icons.person, color: Color.fromRGBO(50, 62, 72, 1.0)),
          hintText: "Email",
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        ));

    var doEmail = () {
      final form = formKey.currentState;

      if (form.validate()) {
        form.save();

        final Future<Map<String, dynamic>> successfulMessage =
            auth.forgotPassword(email);

        successfulMessage.then((response) {
          print("object $response");
          if (response['status']) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => NewPassword()));
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
                label("Email"),
                SizedBox(height: 5.0),
                emailField,
                SizedBox(height: 10,),
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons("Send Code", false, doEmail),
                SizedBox(height: 5.0),
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
