import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Points extends StatefulWidget {
  final points;
  Points({this.points});

  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
// Milkessa: Changed all green colors to Color(0xff0FF6A0)

  var phoneController = new TextEditingController();
  var pointsController = new TextEditingController();
  final _formKey = new GlobalKey<FormState>();

  String _countryCode;
  var points;
  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("Processing your request")
    ],
  );
  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Header(),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: ListView(
                children: [
                  FutureBuilder<dynamic>(
                      future: Provider.of<UserProvider>(context).getProfile(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          if (snapshot.data == null) {
                            return Center(
                              child: Text('No data to show'),
                            );
                          }
                          var res = snapshot.data;
                          var point = res['profession'][0]['points'] ?? 0;
                          points = res['profession'][0]['points'];

                          return Center(
                            child: Container(
                              padding: EdgeInsets.all(60.0),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color(0xff0FF6A0), width: 2),
                                  borderRadius: BorderRadius.circular(150.0)),
                              child: Text(
                                '$point Pts',
                                style: TextStyle(
                                    color: Color(0xff0FF6A0), fontSize: 40.0),
                              ),
                            ),
                          );
                        }
                      }),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'But Air Time',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 25.0,
                          color: Color(0xff0FF6A0)),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  userProvider.pointFiftyStatus == ChangeStatus.Changing
                      ? loading
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                if (double.parse(points) > 50) {
                                  var res = await UserProvider().buyCredit(50);
                                  print("resresresres $res");
                                  if (res['status']) {
                                    var voucher = res['result'];
                                    launch("tel://*805*${voucher['code']}#");
                                  } else {
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                        message:
                                            "Something is wrong please contact system admin",
                                      ),
                                    );
                                  }
                                } else {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "You don't have enough points to buy 50 birr credit",
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff0FF6A0), width: 1),
                                    borderRadius: BorderRadius.circular(100.0)),
                                child: Text(
                                  '50 Birr',
                                  style: TextStyle(
                                      color: Color(0xff0FF6A0), fontSize: 18.0),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (double.parse(points) > 100) {
                                  var res = await UserProvider().buyCredit(100);
                                  if (res['status']) {
                                    var voucher = res['result'];
                                    launch("tel://*805*${voucher['code']}#");
                                  }
                                } else {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                          "You don't have enough points to buy 50 birr credit",
                                    ),
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(15.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color(0xff0FF6A0), width: 1),
                                    borderRadius: BorderRadius.circular(100.0)),
                                child: Text(
                                  '100 Birr',
                                  style: TextStyle(
                                      color: Color(0xff0FF6A0), fontSize: 18.0),
                                ),
                              ),
                            ),
                          ],
                        ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'Transfer points to other professional', //Milkessa: added to word 'points'
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontSize: 25.0,
                          color: Color(0xff0FF6A0)),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Phone number',
                              style: TextStyle(
                                  fontSize: 25.0, color: Color(0xff0FF6A0)),
                            ),
                            Container(
                                height: 40,
                                width: 200,
                                child: TextFormField(
                                    textAlign: TextAlign.start,
                                    controller: phoneController,
                                    maxLength: 10,
                                    decoration: InputDecoration(
                                        counterText: "",
                                        contentPadding: EdgeInsets.zero,
                                        prefixIcon: SizedBox(
                                          width: 35,
                                          child: CountryCodePicker(
                                            onChanged: (value) {
                                              setState(() {
                                                _countryCode = value.dialCode;
                                                _countryCode == null
                                                    ? _countryCode = "+251"
                                                    : _countryCode =
                                                        _countryCode;
                                              });
                                            },
                                            backgroundColor: Colors.white,
                                            initialSelection: 'ET',
                                            favorite: ['+251', 'ET'],
                                            showCountryOnly: false,
                                            showOnlyCountryWhenClosed: false,
                                            alignLeft: false,
                                            padding: EdgeInsets.all(0.0),
                                            showFlag: false,
                                          ),
                                        ),
                                        border: OutlineInputBorder(),
                                        hintText: '90000000')))
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Amount',
                              style: TextStyle(
                                  fontSize: 25.0, color: Color(0xff0FF6A0)),
                            ),
                            Container(
                              height: 40,
                              width: 200,
                              child: TextFormField(
                                controller: pointsController,
                                validator: (val) => val.isEmpty
                                    ? 'Point amount is required'
                                    : null,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Amount',
                                    hintText: 'Amount'),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        userProvider.pointStatus == ChangeStatus.Changing
                            ? CircularProgressIndicator()
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                  child: GestureDetector(
                                    onTap: () async {
                                      _formKey.currentState.save();
                                      if (_formKey.currentState.validate() &&
                                          double.parse(points) >
                                              double.parse(
                                                  pointsController.text)) {
                                        var res =
                                            await userProvider.transferPoint(
                                                pointsController.text,
                                                phoneController.text);
                                        if (res['status']) {
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.success(
                                              message:
                                                  "You have successfully transfered ${pointsController.text} point(s) to phone +251${phoneController.text}",
                                            ),
                                          );
                                        }
                                      } else if (double.parse(points) <
                                          double.parse(pointsController.text)) {
                                        showTopSnackBar(
                                          context,
                                          CustomSnackBar.error(
                                            message:
                                                "You dont have enough point to transfer",
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      width: 100,
                                      height: 40,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Color(0xff0FF6A0),
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(100.0)),
                                      child: Center(
                                        child: Text(
                                          'send',
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              color: Color(0xff0FF6A0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
                height: 50,
                width: double.maxFinite,
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20.0))),
                child: Footer()),
          ],
        ),
      ),
    );
  }
}
