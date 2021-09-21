import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/ui/doctor/consults/consult_list.dart';
import 'package:hepies/util/image_consult.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ShareConsult extends StatefulWidget {
  ShareConsult();
  @override
  _ShareConsultState createState() => _ShareConsultState();
}

class _ShareConsultState extends State<ShareConsult> {
  final formKey = new GlobalKey<FormState>();
  String _topic;
  XFile file;
  void _setImage(XFile image) {
    file = image;
  }

  @override
  Widget build(BuildContext context) {
    ConsultProvider consult = Provider.of<ConsultProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          // Header(),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView(
              children: [
                Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      onSaved: (value) => _topic = value,
                      validator: (value) =>
                          value.isEmpty ? "Please enter your consult" : null,
                      maxLines: 8,
                      decoration: InputDecoration(
                          hintText: 'Share consult',
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 2))),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImageInputConsult(_setImage),
                    SizedBox(
                      width: 100,
                    ),
                    ButtonTheme(
                      minWidth: 100,
                      padding: EdgeInsets.only(right: 10.0),
                      child: OutlinedButton(
                        onPressed: () async {
                          final form = formKey.currentState;
                          print("_topic_topic_topic_topic ${_topic}");
                          if (form.validate()) {
                            form.save();
                            try {
                              var photo = file != null ? File(file.path) : null;
                              var res = await consult.share(_topic, photo);
                              if (res['status']) {
                                consult.getConsults();
                                Flushbar(
                                  title: 'Consult Shared',
                                  duration: Duration(seconds: 10),
                                  message:
                                      'Your consult is uploaded succesfully',
                                ).show(context);
                              }
                            } catch (e) {
                              print("eeeee ${e}");
                              Flushbar(
                                title: "Sharing Consult Failed",
                                message: 'Unable to share your consult',
                                duration: Duration(seconds: 10),
                              ).show(context);
                            }
                          } else {
                            Flushbar(
                              title: "Invalid form",
                              message: "Please Complete the form properly",
                              duration: Duration(seconds: 10),
                            ).show(context);
                          }
                        },
                        child: Text('Consult'),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Divider(),
                FutureBuilder<List<dynamic>>(
                    future: Provider.of<ConsultProvider>(context).getConsults(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.data == null) {
                          return Center(
                            child: Text('No data to show'),
                          );
                        }

                        print("objectobjectobject ${snapshot.data}");
                        return ConsultList(snapshot.data);
                      }
                    }),
              ],
            ),
          ),
          Footer()
        ],
      ),
    );
  }
}
