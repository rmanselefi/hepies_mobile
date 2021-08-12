import 'package:hepies/models/patient.dart';

class Prescription {
  int id;
  String dose;
  String route;
  String takein;
  String frequency;
  String drug;
  String ampule;
  Patient patient;

  Prescription(
      {this.takein,
      this.frequency,
      this.route,
      this.patient,
      this.id,
      this.dose,
      this.ampule});
}
