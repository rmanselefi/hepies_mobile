import 'dart:convert';
import 'dart:io';

import 'package:hepies/models/consult.dart';
import 'package:hepies/models/drug.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/models/patient.dart';
import 'package:hepies/models/prescription.dart';
import 'package:hepies/providers/patient_provider.dart';
import 'package:hepies/util/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PrescriptionStatus {
  NotSent,
  Sent,
  Sending,
}

enum ReadStatus {
  NotFetch,
  Fetch,
  Fetching,
}


class PrescriptionProvider with ChangeNotifier {
  PrescriptionStatus _sentStatus = PrescriptionStatus.NotSent;
  PrescriptionStatus get sentStatus => _sentStatus;
  ReadStatus _fetchStatus = ReadStatus.NotFetch;
  ReadStatus get readStatus => _fetchStatus;
  int _index = 0;
  int get prescriptionIndex => _index;
  String _status = 'add';
  String _actionStatus = 'populate';
  String get status => _status;
  String get actionStatus => _actionStatus;
  List<dynamic> _prescription = [];
  List<dynamic> get prescription => _prescription;
  List<dynamic> medical=[];

  Map<String, dynamic> _singlePrescription = {};
  Map<String, dynamic> get singlePrescription => _singlePrescription;

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
    _sentStatus = PrescriptionStatus.Sending;
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
      final bool responseData = json.decode(response.body);
      _sentStatus = PrescriptionStatus.Sent;
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successful',
        'consult': responseData
      };
    } else {
      _sentStatus = PrescriptionStatus.NotSent;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  void setPrescriptionForm(Map<String, dynamic> prescription, int index) {
    _singlePrescription = prescription;
    _actionStatus = "populate";
    _status = 'edit';
    _index = index;
    notifyListeners();
  }

  void resetStatus() {
    _actionStatus = "";
    _status = 'add';
    notifyListeners();
  }


  void setFavoriteCombinations(List<dynamic> prescriptions) {
    _prescription = prescriptions;
    notifyListeners();
  }


  Future<List<dynamic>> readPrescription(var code) async {
    _fetchStatus = ReadStatus.Fetching;
    notifyListeners();
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse("${AppUrl.readprescription}/$code"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      _fetchStatus = ReadStatus.Fetch;
      notifyListeners();
      medical = json.decode(response.body);
      print("consultconsultconsultconsultconsult ${medical.length}");
      // notifyListeners();
      return medical;
    } else {
      _fetchStatus = ReadStatus.NotFetch;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    // return json.decode(response.body);
  }

  Future<Map<String, dynamic>> acceptPrescription(List id) async {
    _sentStatus = PrescriptionStatus.Sending;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var result;
    print("registrationData $id");
    Response response = await post(Uri.parse(AppUrl.accept),
        body: json.encode(id),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final bool responseData = json.decode(response.body);
      _sentStatus = PrescriptionStatus.Sent;
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successful',
        'consult': responseData
      };
    } else {
      _sentStatus = PrescriptionStatus.NotSent;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }


}
