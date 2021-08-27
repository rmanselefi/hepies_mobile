import 'dart:convert';

import 'package:hepies/models/consult.dart';
import 'package:hepies/util/app_url.dart';
import 'package:provider/provider.dart';
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
  List<dynamic> medical=[];
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
      print("consultconsultconsultconsultconsult ${medical.length}");
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

  get getDrug{
    notifyListeners();
    return medical;
  }
}
