import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:flutter/material.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/util/app_url.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:http/http.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  firebase_storage.UploadTask uploadTask;
  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String username, String password) async {
    var result;

    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password
    };

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    Response response = await post(
      Uri.parse(AppUrl.login),
      body: json.encode(loginData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      User authUser = User.fromJson(responseData);
      UserPreferences().saveUser(authUser);
      var role = responseData['role']['name'];
      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Successful',
        'role': role,
        'user': authUser
      };
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> register(
      String name,
      String fathername,
      String username,
      String phone,
      String password,
      String profession,
      String sex,
      String dob,
      interests,
      File file) async {
    _loggedInStatus = Status.Authenticating;
    notifyListeners();
    var license;
    if (file != null) {
      await uploadImage(file).then((res) {
        print('imageuriimageuriimageuri$res');
        if (res != null) {
          license = res;
        }
      });
    }
    var result;
    var role = 2;
    if (profession == 'Pharmacist') {
      role = 3;
    }
    if (profession == 'Nurse') {
      role = 5;
    }
    if (profession == 'Health Officer') {
      role = 4;
    }
    final Map<String, dynamic> registrationData = {
      'name': name,
      'fathername': fathername,
      'phone': phone,
      'license': license,
      'interests': interests,
      'proffesion': profession,
      'dob': dob,
      'sex': sex,
      'user': {'username': username, 'password': password, 'role': role},
    };
    Response response = await post(Uri.parse(AppUrl.register),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});
    print("responseresponseresponse ${json.decode(response.body)}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("ResponseResponseResponse ${responseData}");

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': responseData};
    } else {
      _loggedInStatus = Status.NotLoggedIn;
      notifyListeners();
      var res = json.decode(response.body);
      var message = '';
      if (res['message'] == 'username') {
        message = 'Username already exists';
      }
      if (res['message'] == 'email') {
        message = 'Email already exists';
      }
      if (res['message'] == 'phone') {
        message = 'Phone already exists';
      }
      result = {
        'status': false,
        'message': message
      };
    }
    return result;
  }

  static Future<FutureOr> onValue(Response response) async {
    var result;
    final Map<String, dynamic> responseData = json.decode(response.body);

    print(response.statusCode);
    if (response.statusCode == 200) {
      var userData = responseData['data'];

      User authUser = User.fromJson(userData);

      UserPreferences().saveUser(authUser);
      result = {
        'status': true,
        'message': 'Successfully registered',
        'data': authUser
      };
    } else {
//      if (response.statusCode == 401) Get.toNamed("/login");
      result = {
        'status': false,
        'message': 'Registration failed',
        'data': responseData
      };
    }

    return result;
  }

  Future<String> uploadImage(File back, {String path}) async {
    // final mimetypeData = lookupMimeType(image.path).split('/');
    firebase_storage.FirebaseStorage storage =
        firebase_storage.FirebaseStorage.instance;
    String fileName = basename(back.path);
    firebase_storage.Reference storageReference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child("background_images/$fileName");

    uploadTask = storageReference.putFile(back);

// Cancel your subscription when done.
    firebase_storage.TaskSnapshot snapshot = await uploadTask;
    var imageUrl = await snapshot.ref.getDownloadURL();
    notifyListeners();
    return imageUrl;
  }

  Future<bool> updateShopBack(String id, File file) async {
    var backImage = '';
    try {
      if (file != null) {
        await uploadImage(file).then((res) {
          print('imageuriimageuriimageuri$res');
          if (res != null) {
            backImage = res;
          }
        });

        return true;
      }
      return false;
    } catch (err) {
      print("errorerrorerrorerrorerrorerror $err");
      return false;
    }
  }

  Future logout() async {
    UserPreferences().removeUser();
  }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
