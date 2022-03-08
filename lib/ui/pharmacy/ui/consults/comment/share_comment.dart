import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hepies/constants.dart';
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
  final user_id;
  PharmacyShareComment(this.consultid, this.post, this.user_id);
  @override
  _PharmacyShareConsultState createState() => _PharmacyShareConsultState();
}

class _PharmacyShareConsultState extends State<PharmacyShareComment> {
  final formKey = new GlobalKey<FormState>();
  String _topic;
  XFile file;
  var topicController = new TextEditingController();
  void _setImage(XFile image) {
    setState(() {
      file = image;
    });
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
        resizeToAvoidBottomInset: true,
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 3,
                          child: Form(
                            key: formKey,
                            child: Container(
                              padding: EdgeInsets.all(10.0),
                              child: TextFormField(
                                controller: topicController,
                                onSaved: (value) => _topic = value,
                                validator: (value) => value.isEmpty
                                    ? "Please enter your comment"
                                    : null,
                                decoration: InputDecoration(
                                    hintText: 'Comment',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey, width: 2))),
                              ),
                            ),
                          ),
                        ),
                        file != null
                            ? Container(
                                width: width(context) * 0.25,
                                margin: EdgeInsets.all(5),
                                child: Stack(
                                  children: [
                                    Image.file(File(file.path),
                                        fit: BoxFit.contain),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          file = null;
                                        });
                                      },
                                      icon: Icon(Icons.cancel_rounded,
                                          color: Colors.blue),
                                    ),
                                  ],
                                ),
                              )
                            : Container(width: 0),
                      ],
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
                                              file = null;
                                              topicController.text = "";
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
                                          // print("eeeee ${e}");

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
                    Flexible(
                        child: PharmacyCommentList(widget.user_id, consultid)),
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
