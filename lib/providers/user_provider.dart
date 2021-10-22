import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/util/app_url.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:http/http.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

enum ChangeStatus { NotChanged, Changed, Changing }

class UserProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  firebase_storage.UploadTask uploadTask;
  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  User _user = new User();
  ChangeStatus _changedStatus = ChangeStatus.NotChanged;
  ChangeStatus get changedStatus => _changedStatus;
  User get user => _user;

  void setUser(User user) {
    _user = user;
  }

  Future<Map<String, dynamic>> updateProfile(
      User user, File file, var old_profile) async {
    _loggedInStatus = Status.Authenticating;
    notifyListeners();
    _registeredInStatus = Status.Authenticating;
    notifyListeners();
    var profile;
    if (file != null) {
      await AuthProvider().uploadImage(file).then((res) {
        print('imageuriimageuriimageuri$res');
        if (res != null) {
          profile = res;
        }
      });
    } else {
      profile = old_profile;
    }
    var result;
    final Map<String, dynamic> registrationData = {
      'id': user.professionid,
      'name': user.name,
      'fathername': user.fathername,
      'phone': user.phone,
      'email': user.email,
      'profile': profile,
      'proffesion': user.profession,
      'speciality': user.speciality,
      'workplace': user.workplace,
      'profile': profile,
      'user': {
        'id': user.userId,
        'username': user.username,
      },
    };
    Response response = await put(
        Uri.parse(AppUrl.profile + '/${user.professionid}'),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("ResponseResponseResponse ${responseData}");

      _registeredInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': responseData};
    } else {
      _registeredInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> updatePassword(var password) async {
    _changedStatus = ChangeStatus.Changing;
    notifyListeners();

    var result;
    var user = await UserPreferences().getUser();
    var user_id = user.userId;
    var registrationData = {'password': password};
    Response response = await put(
        Uri.parse(AppUrl.change_password + '/$user_id'),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      // final Map<String, dynamic> responseData = json.decode(response.body);
      print("ResponseResponseResponse ${response.body}");

      _changedStatus = ChangeStatus.Changed;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': response.body};
    } else {
      _changedStatus = ChangeStatus.NotChanged;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> rewardPoint(var point) async {
    _changedStatus = ChangeStatus.Changing;
    notifyListeners();

    var result;
    var user = await UserPreferences().getUser();
    var user_id = user.professionid;
    var registrationData = {'points': point};
    Response response = await put(Uri.parse(AppUrl.reward + '/$user_id'),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      // final Map<String, dynamic> responseData = json.decode(response.body);
      print("ResponseResponseResponse ${response.body}");

      _changedStatus = ChangeStatus.Changed;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': response.body};
    } else {
      _changedStatus = ChangeStatus.NotChanged;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }
}
