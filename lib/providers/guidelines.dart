import 'dart:convert';

import 'package:hepies/models/consult.dart';
import 'package:hepies/util/app_url.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class GuidelinesProvider with ChangeNotifier {
  List<dynamic> guidelines=[];
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

  get getDrug{
    return guidelines;
  }
}
