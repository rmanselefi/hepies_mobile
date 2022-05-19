import 'dart:convert';
import 'dart:io';

import 'package:hepies/models/consult.dart';
import 'package:hepies/util/app_url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Status {
  NotFetch,
  Fetch,
  Fetching,
}

class PharmacyProvider with ChangeNotifier {
  Status _fetchStatus = Status.NotFetch;
  Status get fetchStatus => _fetchStatus;
  List<dynamic> medical = [];
  Future<List<dynamic>> getMedicalRecord(var code) async {
    _fetchStatus = Status.Fetching;
    notifyListeners();
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse("${AppUrl.medicalrecord}/$code"));

    if (response.statusCode == 200 || response.statusCode == 201) {
      _fetchStatus = Status.Fetch;
      notifyListeners();
      medical = json.decode(response.body);
      // print("consultconsultconsultconsultconsult ${medical.length}");
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

  Future<Map<String, dynamic>> addDrugToPharmacy(
      String drug_name, String drug_id, String price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String professionid = prefs.getInt('professionid').toString();
    // print("professionidprofessionid $professionid");
    String token = prefs.getString('token');
    print("post p" + professionid);
    var result;

    final Map<String, dynamic> registrationData = {
      'price': price,
      'drug_name': drug_name,
      'drug': drug_id,
      'profession': professionid
    };
    print("registrationData ==> My Pharmacy ======> $registrationData");
    Response response = await post(Uri.parse(AppUrl.pharmacy),
        body: json.encode(registrationData),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    print("drung" + response.body + response.statusCode.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      result = {
        'status': true,
        'message': 'Successful',
      };
    } else {
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<List<dynamic>> getMyPharmacy() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String professionid = prefs.getInt('professionid').toString();
    // print("professionidprofessionid $professionid");
    print(professionid);
    var result;
    List<Consult> consults = [];
    Response response =
        await get(Uri.parse("${AppUrl.mypharmacy}/$professionid"));
    print("response pharmaacy" + response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      medical = json.decode(response.body);
      // print("consultconsultconsultconsultconsult ${medical.length}");
      // notifyListeners();
      print("m" + medical.toString());
      return medical;
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return json.decode(response.body);
  }

  Future<List<dynamic>> getMyPharmacyHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    // print("object i got hereeeee");
    // print("professionidprofessionid $token");
    var result;

    Response response = await post(Uri.parse(AppUrl.history), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    // print("responseresponseresponse ${response.body}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      medical = json.decode(response.body);
      // print("consultconsultconsultconsultconsult ${medical.length}");
      // notifyListeners();
      return medical;
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> updateMyPharmacy(
      pharmacy_id, String drug_name, String drug_id, String price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String professionid = prefs.getInt('professionid').toString();
    // print("professionidprofessionid $professionid");
    String token = prefs.getString('token');

    var result;

    final Map<String, dynamic> registrationData = {
      'price': price,
      'drug_name': drug_name,
      'drug': drug_id,
      'profession': professionid
    };
    // print("registrationData $registrationData");
    Response response = await put(Uri.parse('${AppUrl.pharmacy}/$pharmacy_id'),
        body: json.encode(registrationData),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      result = {
        'status': true,
        'message': 'Successful',
      };
    } else {
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  get getDrug {
    notifyListeners();
    return medical;
  }
}
