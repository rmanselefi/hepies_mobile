import 'dart:convert';
import 'dart:io';

import 'package:hepies/models/consult.dart';
import 'package:hepies/models/drug.dart';
import 'package:hepies/models/patient.dart';
import 'package:hepies/models/prescription.dart';
import 'package:hepies/util/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  NotSent,
  Sent,
  Sending,
}

class PrescriptionProvider with ChangeNotifier {

  Status _sentStatus = Status.NotSent;
  Status get sentStatus => _sentStatus;

  Future<List<dynamic>> getPrescriptions() async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse(AppUrl.prescription));

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> writePrescription(List precriptionData) async {
    _sentStatus = Status.Sending;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var result;
    print("registrationData $precriptionData");
    Response response = await post(Uri.parse(AppUrl.write),
        body: json.encode(precriptionData),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      _sentStatus = Status.Sent;
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successful',
        'consult': responseData
      };
    } else {
      _sentStatus = Status.NotSent;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
}
