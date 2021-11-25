import 'dart:convert';
import 'dart:io';

import 'package:hepies/models/consult.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/util/app_url.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ConsultStatus { Shared, NotShared, Sharing }

class ConsultProvider with ChangeNotifier {
  ConsultStatus _shareStatus = ConsultStatus.NotShared;
  ConsultStatus get shareStatus => _shareStatus;

  ConsultStatus _editStatus = ConsultStatus.NotShared;
  ConsultStatus get editStatus => _editStatus;
  List<dynamic> _interests = [];
  List<dynamic> get interests => _interests;

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
    _shareStatus = ConsultStatus.Sharing;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var image;
    if (file != null) {
      await AuthProvider().uploadImage(file).then((res) {
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
    Response response = await post(Uri.parse(AppUrl.consults),
        body: json.encode(registrationData),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      _shareStatus = ConsultStatus.Shared;
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successful',
        'consult': responseData
      };
    } else {
      _shareStatus = ConsultStatus.NotShared;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> updateConsult(
      var id, String topic, File file, var imageUrl) async {
    _editStatus = ConsultStatus.Sharing;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var image;
    if (file != null) {
      await AuthProvider().uploadImage(file).then((res) {
        if (res != null) {
          image = res;
        }
      });
    } else {
      image = imageUrl;
    }
    var result;

    final Map<String, dynamic> registrationData = {
      'topic': topic,
      'image': image,
    };
    Response response = await put(Uri.parse('${AppUrl.consults}/$id'),
        body: json.encode(registrationData),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      _editStatus = ConsultStatus.Shared;
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successful',
        'consult': responseData
      };
    } else {
      _editStatus = ConsultStatus.NotShared;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<List<dynamic>> getCommentByConsultId(var id) async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse("${AppUrl.consults}/comment/$id"));

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

  Future<int> getCommentsByConsultId(var id) async {
    var result;
    List<Consult> consults = [];
    // getLikeByConsultIdForUser(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    Response response =
        await get(Uri.parse("${AppUrl.consults}/comments/$id"), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return json.decode(response.body);
  }

  Future<dynamic> getLikeByConsultIdForUser(var id) async {
    var result;
    List<Consult> consults = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    Response response =
        await post(Uri.parse("${AppUrl.consults}/like/find/$id"), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return json.decode(response.body);
  }

  Future<dynamic> getLikeByConsultId(var id) async {
    var result;
    List<Consult> consults = [];
    Response response = await get(Uri.parse("${AppUrl.consults}/likes/$id"));

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

  Future<Map<String, dynamic>> comment(
      String topic, File file, var consultid) async {
    _shareStatus = ConsultStatus.Sharing;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var image;
    if (file != null) {
      await AuthProvider().uploadImage(file).then((res) {
        if (res != null) {
          image = res;
        }
      });
    }
    var result;

    final Map<String, dynamic> registrationData = {
      'comment': topic,
      'image': image,
    };
    Response response = await post(
        Uri.parse("${AppUrl.consults}/comment/$consultid"),
        body: json.encode(registrationData),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      _shareStatus = ConsultStatus.Shared;
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successful',
        'consult': responseData
      };
    } else {
      _shareStatus = ConsultStatus.NotShared;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> likeConsult(var consultid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var result;
    Response response =
        await post(Uri.parse("${AppUrl.consults}/like/$consultid"), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      result = {
        'status': true,
        'message': 'Successful',
        'consult': responseData
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> unlikeConsult(var consultid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');

    var result;
    Response response =
        await post(Uri.parse("${AppUrl.consults}/unlike/$consultid"), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      result = {
        'status': true,
        'message': 'Successful',
      };
    } else {
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<List<dynamic>> getInterests() async {
    var result;

    Response response = await get(Uri.parse(AppUrl.interests));

    if (response.statusCode == 200 || response.statusCode == 201) {
      _interests = json.decode(response.body);
      notifyListeners();
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

  Future<Map<String, dynamic>> deleteConsult(var id) async {
    _shareStatus = ConsultStatus.Sharing;
    var result;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    Response response =
        await delete(Uri.parse("${AppUrl.consults}/$id"), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      _shareStatus = ConsultStatus.Shared;
      notifyListeners();
      result = {'status': true, 'message': 'success'};
    } else {
      _shareStatus = ConsultStatus.NotShared;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
}
