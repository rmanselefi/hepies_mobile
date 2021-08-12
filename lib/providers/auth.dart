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
    print("ResponseResponseResponse ${ response.statusCode}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);


      User authUser = User.fromJson(responseData);
      print("authUserauthUserauthUser ${authUser.username}");
      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
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
      String profession,interests,
      File file) async {
    var license;
    if (file != null) {
      await uploadBackImage(file).then((res) {
        print('imageuriimageuriimageuri$res');
        if (res != null) {
          license = res;
        }
      });
    }
    var result;
    var role = profession == 'Medical Doctor' ? 2 : 3;
    final Map<String, dynamic> registrationData = {
      'name': name,
      'fathername': fathername,
      'phone': phone,
      'license': license,
      'interests':interests,
      'user': {'username': username, 'password': password, 'role': role},
    };
    Response response = await post(Uri.parse(AppUrl.register),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("ResponseResponseResponse ${responseData}");

      User authUser = User.fromJson(responseData);

      UserPreferences().saveUser(authUser);

      _loggedInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
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

  Future<String> uploadBackImage(File back, {String path}) async {
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
        await uploadBackImage(file).then((res) {
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
