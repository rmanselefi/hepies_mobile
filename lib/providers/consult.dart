import 'dart:convert';
import 'dart:io';

import 'package:hepies/models/consult.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/util/app_url.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConsultProvider with ChangeNotifier {
  Future<List<dynamic>> getConsults() async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse(AppUrl.consults));

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

  Future<Map<String, dynamic>> share(String topic, File file) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var image;
    if (file != null) {
      await AuthProvider().uploadImage(file).then((res) {
        print('imageuriimageuriimageuri$res');
        if (res != null) {
          image = res;
        }
      });
    }
    var result;

    final Map<String, dynamic> registrationData = {
      'topic': topic,
      'image': image,
    };
    print("registrationData $registrationData");
    Response response = await post(Uri.parse(AppUrl.consults),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("ResponseResponseResponse ${responseData}");
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successful',
        'consult': responseData
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
}
