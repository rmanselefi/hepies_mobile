import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/user_provider.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
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
                    // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                                        ))
                                        // Text(
                                        //   '${point ?? 0} Pts',
                                        //   style: TextStyle(
                                        //       color: Colors.black38,
                                        //       fontSize: 40.0),
                                        // ),
                                        ),
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
                                            ]))
                                        // Text(
                                        //   '${point ?? 0} Pts',
                                        //   style: TextStyle(
                                        //       color: Colors.black38,
                                        //       fontSize: 40.0),
                                        // ),
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
                            "Buy Air Time",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                                color: Colors.grey.shade800),
                          ),
                        ),
                        Divider(),

                        // Center(
                        //   child: Text(
                        //     'Buy Air Time',
                        //     style: TextStyle(
                        //         decoration: TextDecoration.underline,
                        //         fontSize: 25.0,
                        //         color: Color(0xff0FF6A0)),
                        //   ),
                        // ),

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
                                            print("resresresres $res");
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
                                                        Color>(
                                                    Colors.green.shade900)),
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
                                                        Color>(
                                                    Colors.green.shade900)),
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
                      'Transfer points to other professional', //Milkessa: added to word 'points'
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
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: InternationalPhoneNumberInput(
                              onSaved: (value) {
                                //_auth["phoneNumber"] = value.toString();
                              },
                              onInputChanged: (PhoneNumber number) {
                                phoneController.text = number.phoneNumber;
                              },
                              onInputValidated: (bool value) {},
                              selectorConfig: const SelectorConfig(
                                  selectorType:
                                      PhoneInputSelectorType.BOTTOM_SHEET,
                                  trailingSpace: false),
                              ignoreBlank: false,
                              autoValidateMode:
                                  AutovalidateMode.onUserInteraction,
                              selectorTextStyle:
                                  const TextStyle(color: Colors.black),
                              initialValue: PhoneNumber(isoCode: "ET"),
                              formatInput: true,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      signed: true, decimal: true),
                              inputBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              spaceBetweenSelectorAndTextField: 0,
                              inputDecoration: const InputDecoration(
                                  hintText: "Phone Number",
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                            ),
                          ),
                          // TextFormField(
                          //   controller: phoneController,
                          //   decoration: InputDecoration(
                          //     fillColor: Colors.white,
                          //     filled: true,
                          //     hintText: "Phone Number",
                          //     border: OutlineInputBorder(
                          //         borderSide: BorderSide.none),

                          //     //border: InputBorder.none
                          //   ),
                          // ),
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
                                          var res =
                                              await userProvider.transferPoint(
                                                  pointsController.text,
                                                  phoneController.text);
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
                                                  message: "User not available",
                                                ),
                                              );
                                            }
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
                                                  Colors.green.shade900)),
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
