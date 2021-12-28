import 'dart:convert';
import 'dart:io';

import 'package:hepies/models/consult.dart';
import 'package:hepies/models/drug.dart';
import 'package:hepies/models/favorites.dart';
import 'package:hepies/models/patient.dart';
import 'package:hepies/models/prescription.dart';
import 'package:hepies/providers/patient_provider.dart';
import 'package:hepies/providers/user_provider.dart';
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
  bool isFavourite = false;
  int get prescriptionIndex => _index;
  String _status = 'add';
  String _actionStatus = 'populate';
  String get status => _status;
  String get actionStatus => _actionStatus;
  List<dynamic> _prescription = [];
  List<dynamic> get prescription => _prescription;
  List<dynamic> medical = [];

  Map<String, dynamic> _singlePrescription = {};
  Map<String, dynamic> get singlePrescription => _singlePrescription;
  void changeFavStatus(bool favStatus) {
    isFavourite = favStatus;
    notifyListeners();
  }

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

  Future<Map<String, dynamic>> writePrescription(
      List precriptionData, List patientData) async {
    _sentStatus = PrescriptionStatus.Sending;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var sendData = {'patient': patientData, 'prescription': precriptionData};
    var result;
    print("registrationData $sendData");
    Response response = await post(Uri.parse(AppUrl.write),
        body: json.encode(sendData),
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

  void whenSent() {
    _actionStatus = "";
    _status = 'sent';
    notifyListeners();
  }

  void setFavoriteCombinations(List<dynamic> prescriptions) {
    _prescription = prescriptions;
    notifyListeners();
  }

  Future<dynamic> readPrescription(String code) async {
    _fetchStatus = ReadStatus.Fetching;
    notifyListeners();
    String pattern = r'(^(?:[+251]9)?[0-9]{10,12}$)';
    // String pattern = r'^(?:\+?88|0088)?01[13-9]\d{8}$';
    RegExp regExp = new RegExp(pattern);
    bool isPhone = code.length > 8;

    print("isPhoneisPhone $isPhone");
    var url = isPhone ? AppUrl.readprescriptionPhone : AppUrl.readprescription;
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse("$url/$code"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      _fetchStatus = ReadStatus.Fetch;
      notifyListeners();
      medical = json.decode(response.body);
      print("consultconsultconsultconsultconsult ${medical.length}");
      // notifyListeners();
      result = {'status': true, 'isPhone': isPhone, 'data': medical};
    } else {
      _fetchStatus = ReadStatus.NotFetch;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
    // return json.decode(response.body);
  }

  Future<Map<String, dynamic>> acceptPrescription(List id, List pres_id) async {
    _sentStatus = PrescriptionStatus.Sending;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    List<dynamic> output =
        pres_id.where((element) => !id.contains(element)).toList();
    var result;
    print("registrationData $output");

    Response response = await post(Uri.parse(AppUrl.accept),
        body: json.encode(output),
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
