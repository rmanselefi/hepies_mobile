import 'package:flutter/material.dart';
import 'package:hepius/providers/prescription_provider.dart';
import 'package:hepius/ui/doctor/medicalrecords/personal_info.dart';
import 'package:hepius/ui/doctor/medicalrecords/personal_info_code.dart';

class PrescriberProfile extends StatefulWidget {
  final patient;
  final id;
  final from;
  final diagnosis;
  PrescriberProfile({this.patient, this.id, this.from, this.diagnosis});
  @override
  _PrescriberProfileState createState() => _PrescriberProfileState();
}

class _PrescriberProfileState extends State<PrescriberProfile> {
  var professional;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProfessional(widget.id);
  }

  getProfessional(var id) async {
    await PrescriptionProvider().getProfessionalByID(id).then((value) {
      setState(() {
        professional = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var patient = widget.patient;
    print("professionalprofessionalprofessional $professional");
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: widget.from == 'phone'
                  ? PersonalInfo(
                      patient: patient,
                      diagnosis: widget.diagnosis,
                    )
                  : PersonalInfoCode(
                      patient: patient,
                      diagnosis: widget.diagnosis,
                    ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 1.47,
                decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Color(0xff707070))),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey,
                        backgroundImage: professional != null
                            ? professional['profile'] != null &&
                                    professional['profile'] != ""
                                ? NetworkImage(professional['profile'])
                                : null
                            : null,
                      ),
                    ),
                    professional != null
                        ? Table(
                            border: TableBorder(
                                horizontalInside: BorderSide(
                                    width: 0,
                                    color: Colors.blue,
                                    style: BorderStyle.solid)),
                            children: [
                              TableRow(children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "${professional['proffesion'] ?? ''} ${professional['name'] ?? ''} ${professional['fathername'] ?? ''}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Place of Work - ${professional['workplace'] ?? ''} ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Email - ${professional['email'] ?? ''} ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ]),
                              TableRow(children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    "Phone - ${professional['phone'] ?? ''} ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                              ]),
                            ],
                          )
                        : Container(
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () async {
                Navigator.of(context).pop();
              },
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 40,
                  margin: EdgeInsets.only(right: 20.0, top: 0.0),
                  decoration: BoxDecoration(
                      color: Color(0xff07febb),
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Center(
                      child: Text(
                    'Back',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
