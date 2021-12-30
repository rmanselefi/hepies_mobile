import 'dart:convert';

import 'package:hepies/models/consult.dart';
import 'package:hepies/models/drug.dart';
import 'package:hepies/util/app_url.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DrugProvider with ChangeNotifier {
  List<dynamic> drugs = [];
  Future<List<dynamic>> getDrugs() async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse(AppUrl.drugs));

    if (response.statusCode == 200 || response.statusCode == 201) {
      drugs = json.decode(response.body);
      print("consultconsultconsultconsultconsult ${drugs}");
      // notifyListeners();
      return drugs.where((element) => element['type'] != 'instrument').toList();
    } else {
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return drugs;
  }

  Future<List<dynamic>> getDrugsByType(var type) async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse('${AppUrl.drugs}/$type'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      drugs = json.decode(response.body);
      print("consultconsultconsultconsultconsult ${drugs}");
      // notifyListeners();
      return drugs;
    } else {
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
    return drugs;
  }
}
