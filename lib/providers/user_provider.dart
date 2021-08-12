import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/util/app_url.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:http/http.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class UserProvider with ChangeNotifier {
  Status _registeredInStatus = Status.NotRegistered;
  firebase_storage.UploadTask uploadTask;
  Status get registeredInStatus => _registeredInStatus;
  User _user = new User();

  User get user => _user;

  void setUser(User user) {
    _user = user;
  }

  Future<Map<String, dynamic>> updateProfile(User user, File file) async {
    var profile;
    if (file != null) {
      await AuthProvider().uploadBackImage(file).then((res) {
        print('imageuriimageuriimageuri$res');
        if (res != null) {
          profile = res;
        }
      });
    }
    var result;
    final Map<String, dynamic> registrationData = {
      'id': user.professionid,
      'name': user.name,
      'fathername': user.fathername,
      'phone': user.phone,
      'email': user.email,
      'profile': user.profile,
      'speciality': user.speciality,
      'workplace': user.workplace,
      'user': {
        'id': user.userId,
        'username': user.username,
      },
    };
    Response response = await put(Uri.parse(AppUrl.profile + '/${user.professionid}'),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print("ResponseResponseResponse ${responseData}");

      User authUser = User.fromJson(responseData);

      UserPreferences().saveUser(authUser);

      _registeredInStatus = Status.LoggedIn;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': authUser};
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
}
