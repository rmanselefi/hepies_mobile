import 'dart:convert';

import 'package:hepies/models/consult.dart';
import 'package:hepies/util/app_url.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class DrugProvider with ChangeNotifier {
  List<dynamic> drugs = [];
  List<dynamic> psychoDrugs = [];
  List<dynamic> narcoDrugs = [];
  List<dynamic> instruments = [];
  Future<List<dynamic>> getDrugs() async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse(AppUrl.generaldrugs));

    if (response.statusCode == 200 || response.statusCode == 201) {
      drugs = json.decode(response.body);
      // print("consultconsultconsultconsultconsult ${drugs}");
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

  Future<List<dynamic>> getDrugsLocal() async {
    Box hive = Hive.box('drugList');
    return await hive.get('drugs');
  }

  Future<void> putDrugsLocal() async {
    Box hive = Hive.box('drugList');
    hive.put('drugs', await getDrugs());
    // print('Local Database updated.');
  }

  Future<List<dynamic>> getPsychoDrugs() async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse(AppUrl.psychodrugs));

    if (response.statusCode == 200 || response.statusCode == 201) {
      psychoDrugs = json.decode(response.body);
      // print("consultconsultconsultconsultconsult ${psychoDrugs}");
      // notifyListeners();
      return psychoDrugs;
    } else {
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return psychoDrugs;
  }

  Future<List<dynamic>> getPsychoDrugsLocal() async {
    Box hive = Hive.box('psychoDrugList');
    return await hive.get('psychodrugs');
  }

  Future<void> putPsychoDrugsLocal() async {
    Box hive = Hive.box('psychoDrugList');
    hive.put('psychodrugs', await getPsychoDrugs());
    // print('Local Database updated.');
  }

  Future<List<dynamic>> getNarcoDrugs() async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse(AppUrl.narcoticsdrugs));

    if (response.statusCode == 200 || response.statusCode == 201) {
      narcoDrugs = json.decode(response.body);
      // print("consultconsultconsultconsultconsult ${narcoDrugs}");
      // notifyListeners();
      return narcoDrugs;
    } else {
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return narcoDrugs;
  }

  Future<List<dynamic>> getNarcoDrugsLocal() async {
    Box hive = Hive.box('narcoDrugList');
    return await hive.get('narcoodrugs');
  }

  Future<void> putNarcoDrugsLocal() async {
    Box hive = Hive.box('narcoDrugList');
    hive.put('narcoodrugs', await getNarcoDrugs());
    // print('Local Database updated.');
  }

  Future<List<dynamic>> getDrugsByType(var type) async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse('${AppUrl.drugs}/$type'));

    if (response.statusCode == 200 || response.statusCode == 201) {
      drugs = json.decode(response.body);
      // print("consultconsultconsultconsultconsult ${drugs}");
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

  Future<List<dynamic>> getInstruments() async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse(AppUrl.instrument));

    if (response.statusCode == 200 || response.statusCode == 201) {
      instruments = json.decode(response.body);
      // print("instrumentsinstrumentsinstrumentsinstruments ${instruments}");
      // notifyListeners();
      return instruments;
    } else {
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return instruments;
  }

  Future<List<dynamic>> getLocalInstruments() async {
    Box hive = Hive.box('instrumentList');
    return await hive.get('instruments');
  }

  Future<void> putLocalInstruments() async {
    Box hive = Hive.box('instrumentList');
    hive.put('instruments', await getDrugs());
    // print('Local Database updated.');
  }

  get getDrug {
    notifyListeners();
    return drugs;
  }
}
