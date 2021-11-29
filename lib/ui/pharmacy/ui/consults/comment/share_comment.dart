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

class PharmacyShareComment extends StatefulWidget {
  final consultid;
  final List<Widget> post;
  PharmacyShareComment(this.consultid, this.post);
  @override
  _PharmacyShareConsultState createState() => _PharmacyShareConsultState();
}

class _PharmacyShareConsultState extends State<PharmacyShareComment> {
  final formKey = new GlobalKey<FormState>();
  String _topic;
  XFile file;
  void _setImage(XFile image) {
    file = image;
    print("_formData_formData_formData${file}");
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator(), Text("Sharing....")],
  );

  @override
  Widget build(BuildContext context) {
    ConsultProvider consult = Provider.of<ConsultProvider>(context);
    var consultid = widget.consultid;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.post,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  children: [
                    Form(
                      key: formKey,
                      child: Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          onSaved: (value) => _topic = value,
                          validator: (value) =>
                              value.isEmpty ? "Please enter your comment" : null,
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: 'Comment',
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.grey, width: 2))),
                        ),
                      ),
                    ),
                    consult.shareStatus == ConsultStatus.Sharing
                        ? loading
                        : Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              padding: EdgeInsets.only(right: 15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ImageInputConsult(_setImage),
                                  OutlinedButton(
                                    onPressed: () async {
                                      final form = formKey.currentState;
                                      print("_topic_topic_topic_topic ${_topic}");
                                      if (form.validate()) {
                                        form.save();
                                        try {
                                          var photo = file != null
                                              ? File(file.path)
                                              : null;
                                          var res = await consult.comment(
                                              _topic, photo, consultid);
                                          if (res['status']) {
                                            setState(() {
                                              consult.getCommentByConsultId(
                                                  consultid);
                                            });
                                            showTopSnackBar(
                                              context,
                                              CustomSnackBar.success(
                                                message:
                                                    "Your Comment is shared succesfully",
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          print("eeeee ${e}");

                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.error(
                                              message:
                                                  "Unable to share your Comment",
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
                                    child: Text('Comment'),
                                  ),
                                ],
                              ),
                            ),
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
                            if (snapshot.data == null ||
                                snapshot.data.length == 0) {
                              return Center(
                                child: Text('No comment under this consult'),
                              );
                            }
                            return PharmacyCommentList(snapshot.data);
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
