class AppUrl {
  static const String liveBaseURL = "https://hepies.herokuapp.com/api";
  static const String localBaseURL = "http://10.0.2.2:4000/api/v1";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/auth/login";
  static const String register = baseURL + "/users/register";
  static const String profile = baseURL + "/users/profile/update";
  static const String consults = baseURL + "/consulting";
  static const String prescription = baseURL + "/prescription";
  static const String write = baseURL + "/prescription/write";
  static const String accept = baseURL + "/prescription/accept";
  static const String pharmacy = baseURL + "/pharmacy";
  static const String drugs = baseURL + "/drugs";
  static const String guidelines = baseURL + "/guidelines";
  static const String medicalrecord = baseURL + "/patient/medicalrecord";
  static const String mypharmacy = baseURL + "/pharmacy";

  static const String readprescription = baseURL + "/prescription/code";

  static const String forgotPassword = baseURL + "/forgot-password";
}