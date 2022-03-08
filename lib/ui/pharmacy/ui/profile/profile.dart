import 'package:flutter/material.dart';
import 'package:hepies/providers/prescription_provider.dart';
import 'package:hepies/ui/doctor/medicalrecords/personal_info.dart';
import 'package:hepies/ui/doctor/medicalrecords/personal_info_code.dart';

class PrescriberProfile extends StatefulWidget {
  final patient;
  final id;
  final from;
  PrescriberProfile({this.patient, this.id, this.from});
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

  getProfessional(var id) {
    PrescriptionProvider().getProfessionalByID(id).then((value) {
      setState(() {
        professional = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var patient = widget.patient;
    // print("professionalprofessionalprofessional $professional");
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget.from == 'phone'
                ? PersonalInfo(
                    patient: patient,
                  )
                : PersonalInfoCode(
                    patient: patient,
                  ),
          ),
          Padding(
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
                    child: Icon(
                      Icons.person,
                      size: 100,
                    ),
                  ),
                  professional != null
                      ? Column(children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              professional != null
                                  ? Text(
                                      '${professional['proffesion']} ${professional['name']} ${professional['fathername']}',
                                      style: TextStyle(fontSize: 20))
                                  : Text("")
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              professional != null
                                  ? Text(
                                      'Place of Work - ${professional['workplace']} ',
                                      style: TextStyle(fontSize: 20))
                                  : Text("")
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              professional != null
                                  ? Text(
                                      'Email - ${professional['email']} ',
                                      style: TextStyle(fontSize: 20),
                                    )
                                  : Text("")
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              professional != null
                                  ? Text('Phone - ${professional['phone']} ',
                                      style: TextStyle(fontSize: 20))
                                  : Text("")
                            ],
                          )
                        ])
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                ],
              ),
            ),
          ),
          GestureDetector(
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
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
