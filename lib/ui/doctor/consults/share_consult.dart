import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/ui/doctor/consults/consult_list.dart';
import 'package:hepies/ui/pharmacy/ui/consults/consult_list.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/util/image_consult.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ShareConsult extends StatefulWidget {
  @override
  _ShareConsultState createState() => _ShareConsultState();
}

class _ShareConsultState extends State<ShareConsult> {
  final formKey = new GlobalKey<FormState>();
  String _topic;
  XFile file;
  void _setImage(XFile image) {
    file = image;
    print("_formData_formData_formData${file}");
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      CircularProgressIndicator(),
      Text("Sharing....")
    ],
  );
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
            child: Column(
              children: [
                Form(
                  key: formKey,
                  child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      onSaved: (value) => _topic = value,
                      maxLines: 4,
                      decoration: InputDecoration(
                          hintText: 'Share, consult, promote, inform..',
                          border: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.grey.shade50, width: 0.5))),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ImageInputConsult(_setImage),
                        consult.shareStatus == ConsultStatus.Sharing
                            ? loading
                            : Align(
                            alignment: Alignment.topRight,
                            child: OutlinedButton(
                              onPressed: () async {
                                final form = formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  try {
                                    var photo =
                                    file != null ? File(file.path) : null;
                                    var res =
                                    await consult.share(_topic, photo);
                                    if (res['status']) {
                                      consult.getConsults();
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.success(
                                          message:
                                          "Your consult is uploaded succesfully",
                                        ),
                                      );
                                    }
                                  } catch (e) {
                                    print("eeeee ${e}");
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                        message:
                                        "Unable to share your consult",
                                      ),
                                    );
                                  }
                                } else {
                                  showTopSnackBar(
                                    context,
                                    CustomSnackBar.error(
                                      message:
                                      "Please Complete the form properly",
                                    ),
                                  );
                                }
                              },
                              child: Text('Consult'),
                            )),
                      ],
                    ),
                  ),
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
                        return Expanded(child: PharmacyConsultList(snapshot.data));
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
