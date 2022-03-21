import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:phone_number/phone_number.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

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

  var isValidPhoneN = false;
  var FinalPhoneNumber = "";

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
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Card(
                    shadowColor: Colors.green.shade600,
                    elevation: 5,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: height(context) * 0.1,
                        ),
                        FutureBuilder<dynamic>(
                            future:
                                Provider.of<UserProvider>(context).getProfile(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                        padding: EdgeInsets.all(30.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.green.shade700,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Text.rich(TextSpan(
                                          text: 'Loading..',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 40.0),
                                        ))),
                                  ),
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

                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: Container(
                                        padding: EdgeInsets.all(30.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.green.shade700,
                                                width: 1),
                                            borderRadius:
                                                BorderRadius.circular(20.0)),
                                        child: Text.rich(TextSpan(
                                            text: '${point ?? 0}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 40.0),
                                            children: [
                                              TextSpan(
                                                  text: '.Pts',
                                                  style:
                                                      TextStyle(fontSize: 14))
                                            ]))),
                                  ),
                                );
                              }
                            }),
                        SizedBox(
                          height: 20.0,
                        ),
                        Center(
                          child: Text(
                            "Buy Air Time",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: Colors.grey.shade800),
                          ),
                        ),
                        Divider(),
                        userProvider.pointFiftyStatus == ChangeStatus.Changing
                            ? loading
                            : Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () async {
                                          if (double.parse(points) > 500) {
                                            var res = await UserProvider()
                                                .buyCredit(50);
                                            // print("resresresres $res");
                                            if (res['status']) {
                                              var voucher = res['result'];
                                              launch(
                                                  "tel://*805*${voucher['code']}#");
                                            } else {
                                              showTopSnackBar(
                                                context,
                                                CustomSnackBar.error(
                                                  message:
                                                      "Service currently not available",
                                                ),
                                              );
                                            }
                                          } else {
                                            showTopSnackBar(
                                              context,
                                              CustomSnackBar.error(
                                                message:
                                                    "You need minimum 500Pts to buy airtime",
                                              ),
                                            );
                                          }
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xff07febb))),
                                        child: Text("50 Birr")),
                                    SizedBox(
                                      child: VerticalDivider(),
                                      height: 40,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          if (double.parse(points) > 1000) {
                                            var res = await UserProvider()
                                                .buyCredit(100);
                                            if (res['status']) {
                                              var voucher = res['result'];
                                              launch(
                                                  "tel://*805*${voucher['code']}#");
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
                                                    "You need minimum 500Pts to buy airtime",
                                              ),
                                            );
                                          }
                                        },
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Color(0xff07febb))),
                                        child: const Text("100 Birr")),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      'Donate points to other professional', //Milkessa: added to word 'points'
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18.0,
                          color: Colors.grey),
                    ),
                  ),
                  Divider(),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: IntlPhoneField(
                                countries: ["ET"],
                                onTap: () {},
                                initialCountryCode: 'ET',
                                showDropdownIcon: false,
                                // Milkessa: Fixed phone input field formatting
                                textAlign: TextAlign.start,
                                controller: phoneController,
                                keyboardType: TextInputType.phone,
                                onSaved: (value) {},
                                onChanged: (value) async {
                                  PhoneNumberUtil plugin = PhoneNumberUtil();
                                  RegionInfo region =
                                      RegionInfo(code: 'ET', prefix: 251);
                                  var phoneValue = '+251${value.number}';
                                  if (value.number.length == 9) {
                                    bool isValid = await plugin.validate(
                                        phoneValue, region.code);
                                    if (isValid) {
                                      setState(() {
                                        isValidPhoneN = true;
                                        FinalPhoneNumber = phoneValue;
                                      });
                                    }
                                  }
                                },
                                decoration: InputDecoration(
                                  labelText: 'Phone Number',
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 50,
                            child: TextFormField(
                              controller: pointsController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: "Amount",
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)
                                  //border: InputBorder.none
                                  ),
                            ),
                          ),
                          Divider(),
                          userProvider.pointStatus == ChangeStatus.Changing
                              ? CircularProgressIndicator()
                              : Container(
                                  padding: EdgeInsets.symmetric(horizontal: 30),
                                  width: MediaQuery.of(context).size.width,
                                  child: ElevatedButton(
                                      onPressed: () async {
                                        _formKey.currentState.save();
                                        if (_formKey.currentState.validate() &&
                                            double.parse(points) >
                                                double.parse(
                                                    pointsController.text)) {
                                          if (isValidPhoneN) {
                                            print("phone Number value" +
                                                FinalPhoneNumber);
                                            var res = await userProvider
                                                .transferPoint(
                                                    pointsController.text,
                                                    FinalPhoneNumber);
                                            if (res['status']) {
                                              showTopSnackBar(
                                                context,
                                                CustomSnackBar.success(
                                                  message:
                                                      "Successfully transferred points to ${pointsController.text}",
                                                ),
                                              );
                                            } else {
                                              if (res['statusCode'] == 404) {
                                                phoneController.text = "";
                                                pointsController.text = "";
                                                showTopSnackBar(
                                                  context,
                                                  CustomSnackBar.error(
                                                    message:
                                                        "User not available",
                                                  ),
                                                );
                                              }
                                            }
                                          } else {
                                            showTopSnackBar(
                                              context,
                                              CustomSnackBar.error(
                                                message:
                                                    "Invalide Phone Number ",
                                              ),
                                            );
                                          }
                                        } else if (double.parse(points) <
                                            double.parse(
                                                pointsController.text)) {
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message:
                                                  "Cant transfer the requested amount of points",
                                            ),
                                          );
                                        }
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all<Color>(
                                                  Color(0xff07febb))),
                                      child: Text(
                                        "Send",
                                      )),
                                ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
