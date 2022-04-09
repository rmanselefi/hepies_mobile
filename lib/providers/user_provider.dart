import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hepies/models/user.dart';
import 'package:hepies/providers/auth.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/util/app_url.dart';
import 'package:hepies/util/shared_preference.dart';
import 'package:http/http.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shared_preferences/shared_preferences.dart';

enum ChangeStatus { NotChanged, Changed, Changing }

class UserProvider with ChangeNotifier {
  String role;
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;
  firebase_storage.UploadTask uploadTask;
  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;
  User _user = new User();
  ChangeStatus _changedStatus = ChangeStatus.NotChanged;
  ChangeStatus get changedStatus => _changedStatus;

  ChangeStatus _pointStatus = ChangeStatus.NotChanged;
  ChangeStatus get pointStatus => _pointStatus;

  ChangeStatus _pointFiftyStatus = ChangeStatus.NotChanged;
  ChangeStatus get pointFiftyStatus => _pointFiftyStatus;
  User get user => _user;

  var points = "";

  void setUser(User user) {
    _user = user;
  }

  NavSelection selectedNav = NavSelection.home;

  changeNavSelection(NavSelection selection) {
    selectedNav = selection;
    notifyListeners();
  }

  Future<Map<String, dynamic>> updateProfile(
      User user, File file, var old_profile) async {
    // print("filefilefilefile $file");
    _loggedInStatus = Status.Authenticating;
    notifyListeners();
    _registeredInStatus = Status.Authenticating;
    notifyListeners();
    var profile;
    if (file != null) {
      await AuthProvider().uploadImage(file).then((res) {
        // print('imageuriimageuriimageuri$res');
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
      'phone': user.phone,
      'email': user.email,
      'profile': profile,
      'speciality': user.speciality,
      'workplace': user.workplace,
      'interests': user.interests,
    };
    Response response = await put(
        Uri.parse(AppUrl.profile + '/${user.professionid}'),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});
    print("response result " + response.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      var responseData = json.encode(response.body);

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

  Future<Map<String, dynamic>> updatePassword(
      var password, var oldPassword) async {
    _changedStatus = ChangeStatus.Changing;
    notifyListeners();

    var result;
    var user = await this.getProfile();
    // print("useruseruseruser $user");
    var user_id = user['id'];
    var username = user['username'];
    var registrationData = {
      'username': username,
      'password': password,
      'oldpassword': oldPassword
    };
    Response response = await put(
        Uri.parse(AppUrl.change_password + '/$user_id'),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      _changedStatus = ChangeStatus.Changed;
      notifyListeners();

      result = {'status': true, 'message': 'Successful', 'user': response.body};
    } else {
      _changedStatus = ChangeStatus.NotChanged;
      notifyListeners();
      result = {'status': false, 'message': response.statusCode};
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
      _changedStatus = ChangeStatus.Changed;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Your password is changed successfully'
      };
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

  Future<Map<String, dynamic>> transferPoint(var point, var phone) async {
    _pointStatus = ChangeStatus.Changing;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var result;
    var registrationData = {'points': point, 'phone': phone};
    Response response = await post(Uri.parse(AppUrl.transfer),
        body: json.encode(registrationData),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });
    print("point response " + response.body.toString());
    if (response.statusCode == 200 || response.statusCode == 201) {
      _pointStatus = ChangeStatus.Changed;
      notifyListeners();

      result = {
        'status': true,
        'statusCode': response.statusCode,
        'message': 'Successful',
        'user': response.body
      };
    } else {
      _pointStatus = ChangeStatus.NotChanged;
      notifyListeners();
      result = {
        'status': false,
        'statusCode': response.statusCode,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<Map<String, dynamic>> buyCredit(var amount) async {
    _pointFiftyStatus = ChangeStatus.Changing;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    var result;
    var registrationData = {'amount': amount};
    Response response = await post(Uri.parse(AppUrl.fill),
        body: json.encode(registrationData),
        headers: {
          'Content-Type': 'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token"
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      _pointFiftyStatus = ChangeStatus.Changed;
      notifyListeners();
      result = {
        'status': true,
        'message': 'Successful',
        'result': json.decode(response.body)
      };
    } else {
      _pointFiftyStatus = ChangeStatus.NotChanged;
      notifyListeners();
      result = {
        'status': false,
        'message': json.decode(response.body)['error']
      };
    }
    return result;
  }

  Future<dynamic> getProfile() async {
    var result;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token');
    Response response = await post(Uri.parse(AppUrl.getprofile), headers: {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token"
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = json.decode(response.body);
      // print("resultresultresult ===> $result");
      points = result['profession'][0]['points'];
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

  Future<Map<String, dynamic>> changePassword(
      var code, var email, var password) async {
    _changedStatus = ChangeStatus.Changing;
    notifyListeners();

    var result;
    var registrationData = {
      'email': email,
      'password': password,
      'verification_code': code
    };
    Response response = await post(Uri.parse(AppUrl.changePassword),
        body: json.encode(registrationData),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      _changedStatus = ChangeStatus.Changed;
      notifyListeners();

      result = {
        'status': true,
        'message': 'Your password is changed successfully'
      };
    } else {
      _changedStatus = ChangeStatus.NotChanged;
      notifyListeners();
      result = {'status': false, 'message': response.statusCode};
    }
    return result;
  }
}
