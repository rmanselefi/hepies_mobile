import 'dart:convert';

import 'package:hepius/models/consult.dart';
import 'package:hepius/util/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

enum Status {
  NotFetch,
  Fetch,
  Fetching,
}

class PatientProvider with ChangeNotifier {
  Status _fetchStatus = Status.NotFetch;
  Status get fetchStatus => _fetchStatus;
  List<dynamic> medical = [];
  var patient = null;
  Future<List<dynamic>> getMedicalRecord(var phone) async {
    _fetchStatus = Status.Fetching;
    notifyListeners();
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse("${AppUrl.medicalrecord}/$phone"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      _fetchStatus = Status.Fetch;
      notifyListeners();
      medical = json.decode(response.body);
      // print("recordrecord ${medical.length}");
      // notifyListeners();
      return medical;
    } else {
      _fetchStatus = Status.NotFetch;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return json.decode(response.body);
  }

  Future<dynamic> getPatient(var phone) async {
    _fetchStatus = Status.Fetching;
    notifyListeners();
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse("${AppUrl.patient}/$phone"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      _fetchStatus = Status.Fetch;
      notifyListeners();
      patient = json.decode(response.body);
      // print("recordrecord ${patient}");
      // notifyListeners();
      return patient;
    } else {
      _fetchStatus = Status.NotFetch;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return json.decode(response.body);
  }

  Future<dynamic> getPatientById(var id) async {
    _fetchStatus = Status.Fetching;
    notifyListeners();
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse("${AppUrl.patienturl}/$id"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      _fetchStatus = Status.Fetch;
      notifyListeners();
      patient = json.decode(response.body);
      // print("recordrecord ${patient}");
      // notifyListeners();
      return patient;
    } else {
      _fetchStatus = Status.NotFetch;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return json.decode(response.body);
  }

  get getDrug {
    notifyListeners();
    return medical;
  }
}
