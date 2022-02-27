class AppUrl {
  static const String liveBaseURL = "https://hepies.herokuapp.com/api";
  static const String localBaseURL = "http://10.0.2.2:4000/api/v1";

  static const String baseURL = liveBaseURL;
  static const String login = baseURL + "/auth/login";
  static const String sendCode = baseURL + "/passwordReset/send-code";

  static const String getprofile = baseURL + "/auth/me";
  static const String register = baseURL + "/users/register";
  static const String reward = baseURL + "/users/rewardpoint";
  static const String transfer = baseURL + "/users/transfer";
  static const String profile = baseURL + "/users/profile/update";
  static const String consults = baseURL + "/consulting";
  static const String fill = baseURL + "/voucher/fill";

  static const String interests = baseURL + "/consulting/interests";
  static const String prescription = baseURL + "/prescription";
  static const String write = baseURL + "/prescription/write";
  static const String accept = baseURL + "/prescription/accept";
  static const String pharmacy = baseURL + "/pharmacy";
  static const String drugs = baseURL + "/drugs";
  static const String generaldrugs = baseURL + "/drugs/general";
  static const String narcoticsdrugs = baseURL + "/drugs/narcotics";
  static const String psychodrugs = baseURL + "/drugs/psychotropic";
  static const String instrument = baseURL + "/drugs/instrument";
  static const String guidelines = baseURL + "/guidelines";
  static const String guidelinestatus = baseURL + "/guidelines/status";

  static const String medicalrecord = baseURL + "/patient/medicalrecord";
  static const String patient = baseURL + "/patient/patient";
  static const String patienturl = baseURL + "/patient";
  static const String mypharmacy = baseURL + "/pharmacy";
  static const String history = baseURL + "/prescription/readby";
  static const String change_password = baseURL + "/users/change/password";
  static const String changePassword = baseURL + "/passwordReset/change";

  static const String readprescription = baseURL + "/prescription/code";
  static const String readprescriptionPhone = baseURL + "/prescription/phone";

  static const String forgotPassword = baseURL + "/forgot-password";

  static const String professional = baseURL + "/users";

}
