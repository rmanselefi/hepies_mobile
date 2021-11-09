import 'dart:convert';
import 'dart:io';

import 'package:hepies/models/consult.dart';
import 'package:hepies/util/app_url.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuidelinesProvider with ChangeNotifier {
  List<dynamic> guidelines = [];
  Future<List<dynamic>> getGuidelines() async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse(AppUrl.guidelines));
    if (response.statusCode == 200 || response.statusCode == 201) {
      guidelines = json.decode(response.body);
      print("consultconsultconsultconsultconsult ${guidelines.length}");
      // notifyListeners();
      return guidelines;
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
      notifyListeners();
    }
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> updateStatus(String directory, int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var result;

    final Map<String, dynamic> registrationData = {
      'directory': directory,
    };
    print("registrationData $registrationData");
    Response response = await patch(Uri.parse("${AppUrl.guidelinestatus}/$id"),
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
    return guidelines;
  }
}
