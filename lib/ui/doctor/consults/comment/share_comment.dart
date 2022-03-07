import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/ui/doctor/consults/consult_list.dart';
import 'package:hepies/ui/pharmacy/ui/consults/comment/comment_list.dart';
import 'package:hepies/ui/pharmacy/ui/consults/consult_list.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/util/image_consult.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ShareComment extends StatefulWidget {
  final consultid;
  ShareComment(this.consultid);
  @override
  _PharmacyShareConsultState createState() => _PharmacyShareConsultState();
}

class _PharmacyShareConsultState extends State<ShareComment> {
  final formKey = new GlobalKey<FormState>();
  String _topic;
  XFile file;
  void _setImage(XFile image) {
    file = image;
    print("_formData_formData_formData${file}");
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator(), Text("Commenting....")],
  );
  @override
  Widget build(BuildContext context) {
    ConsultProvider consult = Provider.of<ConsultProvider>(context);
    var consultid = widget.consultid;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Header(),
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
                            value.isEmpty ? "Please enter your comment" : null,
                        maxLines: 4,
                        decoration: InputDecoration(
                            hintText: 'Comment',
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
                                      var res = await consult.comment(
                                          _topic, photo, consultid);
                                      if (res['status']) {
                                        setState(() {
                                          _topic = "";
                                          file = null;
                                          consult
                                              .getCommentByConsultId(consultid);
                                        });

                                        showTopSnackBar(
                                          context,
                                          CustomSnackBar.error(
                                            message:
                                                'Your Comment is shared succesfully',
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      print("eeeee ${e}");
                                      showTopSnackBar(
                                        context,
                                        CustomSnackBar.error(
                                            message:
                                                'Unable to share your Comment'),
                                      );
                                    }
                                  } else {
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.error(
                                          message:
                                              "Please Complete the form properly"),
                                    );
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
                      future: Provider.of<ConsultProvider>(context)
                          .getCommentByConsultId(consultid),
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
                          return PharmacyCommentList(snapshot.data, 0);
                        }
                      }),
                ],
              ),
            ),
            PharmacyFooter()
          ],
        ),
      ),
    );
  }
}
