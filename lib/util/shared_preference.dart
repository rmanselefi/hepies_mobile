import 'package:hepies/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setInt("userId", user.userId != null ? user.userId : 0);
    prefs.setInt(
        "professionid", user.professionid != null ? user.professionid : 0);
    prefs.setString("isFit", user.isFit != null ? user.isFit : '');
    prefs.setString("role", user.role != null ? user.role : '');
    prefs.setString("name", user.name != null ? user.name : '');
    prefs.setString("username", user.username != null ? user.username : '');
    prefs.setString("email", user.email != null ? user.email : '');
    prefs.setString("phone", user.phone != null ? user.phone : '');
    prefs.setString(
        "profession", user.profession != null ? user.profession : '');
    prefs.setString("token", user.token != null ? user.token : '');
    prefs.setString("points", user.points != null ? user.points : "0");
    prefs.setString(
        "fathername", user.fathername != null ? user.fathername : '');
    prefs.setString("grandfathername",
        user.grandfathername != null ? user.grandfathername : '');
    prefs.setString("profile", user.profile != null ? user.profile : '');
    prefs.setString("workplace", user.workplace != null ? user.workplace : '');
    prefs.setString(
        "speciality", user.speciality != null ? user.speciality : '');
    prefs.setString("interests", user.interests != null ? user.interests : '');

    return true;
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int userId = prefs.getInt("userId");
    int professionid = prefs.getInt('professionid');
    String name = prefs.getString("name");
    String email = prefs.getString("email");
    String phone = prefs.getString("phone");
    String profession = prefs.getString("profession");
    String token = prefs.getString("token");
    String points = prefs.getString("points");
    String profile = prefs.getString("profile");
    String interests = prefs.getString("interests");
    String workplace = prefs.getString("workplace");
    String speciality = prefs.getString("speciality");
    String fathername = prefs.getString("fathername");
    String grandfathername = prefs.getString("grandfathername");
    String username = prefs.getString("username");
    String isFit = prefs.getString('isFit');
    String role=prefs.getString('role');
    return User(
        userId: userId,
        isFit: isFit,
        professionid: professionid,
        name: name,
        email: email,
        phone: phone,
        profession: profession,
        token: token,
        points: points,
        profile: profile,
        interests: interests,
        speciality: speciality,
        workplace: workplace,
        fathername: fathername,
        grandfathername: grandfathername,
        role: role,
        username: username);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    return token;
  }
}
