class User {
  int userId;
  int professionid;
  String name;
  String fathername;
  String grandfathername;
  String email;
  String username;
  String profession;
  String phone;
  String token;
  String points;
  String profile;
  String interests;
  String workplace;
  String speciality;
  String license;
  String isFit;

  User(
      {this.userId,
      this.professionid,
      this.name,
      this.email,
      this.phone,
      this.profession,
      this.token,
      this.username,
      this.points,
      this.fathername,
      this.interests,
      this.profile,
      this.speciality,
      this.workplace,
      this.grandfathername,
      this.license,
        this.isFit
      });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      userId: responseData['id'],
      isFit: responseData['isFit'],
      name: responseData['profession'][0]['name'],
      professionid: responseData['profession'][0]['id'],
      email: responseData['profession'][0]['email'],
      phone: responseData['profession'][0]['phone'],
      profession: responseData['profession'][0]['proffesion'],
      token: responseData['token'],
      username: responseData['username'],
      points: responseData['profession'][0]['points'],
      profile: responseData['profession'][0]['profile'],
      workplace: responseData['profession'][0]['workplace'],
      speciality: responseData['profession'][0]['speciality'],
      interests: responseData['profession'][0]['interests'],
      fathername: responseData['profession'][0]['fathername'],
      grandfathername: responseData['profession'][0]['grandfathername'],
      license: responseData['profession'][0]['license'],
    );
  }
}
