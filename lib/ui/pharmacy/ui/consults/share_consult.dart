import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
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

import '../../../../constants.dart';

class PharmacyShareConsult extends StatefulWidget {
  final user_id;
  PharmacyShareConsult(this.user_id);
  @override
  _PharmacyShareConsultState createState() => _PharmacyShareConsultState();
}

class _PharmacyShareConsultState extends State<PharmacyShareConsult> {
  final formKey = new GlobalKey<FormState>();
  var _topic = new TextEditingController();
  XFile file;

  String name = '';
  String interestStatus = "hide";

  List<dynamic> interests = [];
  List<dynamic> subList = [];
  void _setImage(XFile image) {
    setState(() {
      file = image;
    });
  }

  void setInterests() {
    ConsultProvider().getInterests().then((value) {
      if (!mounted) return;
      setState(() {
        interests = value;
        subList = interests.sublist(0, 5);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInterests();
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator()],
  );
  @override
  Widget build(BuildContext context) {
    ConsultProvider consult = Provider.of<ConsultProvider>(context);

    List<dynamic> interest = interests
        .where((element) => element['interest'].toLowerCase().contains(name))
        .toList();
    return SafeArea(
      child: Column(
        children: [
          // Header(),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Row(
                  // Milkesa: Added mini image display next to consult text field
                  children: [
                    Flexible(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(3),
                        child: HashTagTextField(
                          decoration: InputDecoration(
                              hintText: 'Share, consult, promote, inform..',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade50, width: 0.5))),
                          basicStyle:
                              TextStyle(fontSize: 15, color: Colors.black),
                          decoratedStyle:
                              TextStyle(fontSize: 15, color: Colors.blue),
                          keyboardType: TextInputType.multiline,
                          controller: _topic,

                          /// Called when detection (word starts with #, or # and @) is being typed
                          onDetectionTyped: (text) {
                            setState(() {
                              interestStatus = "show";
                            });
                            if (text.length > 1) {
                              text.substring(2);
                              print("text ${text.substring(2)}");
                              setState(() {
                                name = text.substring(2).toLowerCase();
                              });
                            }

                            print("texttexttexttexttext $text");
                          },

                          /// Called when detection is fully typed
                          onDetectionFinished: () {
                            print("detection finished");
                          },
                          maxLines: 4,
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
                                  icon: Icon(Icons.cancel_outlined,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                          )
                        : Container(width: 0),
                  ],
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: EdgeInsets.only(right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        interestStatus == "show"
                            ? Container(
                                width: width(context) * 0.7,
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  direction: Axis.horizontal,
                                  children: interest.map<Widget>((e) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (name == "") {
                                          setState(() {
                                            _topic.text =
                                                "${_topic.text} #${e['interest']}";
                                          });
                                        }
                                      },
                                      child: Text(
                                        "#${e['interest']} ",
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            : Container(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ImageInputConsult(_setImage),
                            consult.shareStatus == ConsultStatus.Sharing
                                ? loading
                                : Align(
                                    alignment: Alignment.topRight,
                                    child: OutlinedButton(
                                      onPressed: () async {
                                        try {
                                          var photo = file != null
                                              ? File(file.path)
                                              : null;
                                          if (_topic.text !=
                                                  "" || //Milkessa: added posting capability with either text or image
                                              file != null) {
                                            var res = await consult.share(
                                                _topic.text, photo);
                                            if (res['status']) {
                                              consult.getConsults();
                                              showTopSnackBar(
                                                context,
                                                CustomSnackBar.success(
                                                  message:
                                                      "Your consult is uploaded succesfully",
                                                ),
                                              );
                                              _topic.text = "";
                                            }
                                          } else {
                                            showTopSnackBar(
                                              context,
                                              CustomSnackBar.error(
                                                message:
                                                    "Invalid Data! Make sure you have inserted image or text",
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
                                      },
                                      child: Container(
                                        margin: EdgeInsets.zero,
                                        padding: EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                          boxShadow: [buttonShadow],
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        child: Text(
                                          'Consult',
                                          textScaleFactor: 0.775,
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Divider(),
                PharmacyConsultList(widget.user_id, interest)
              ],
            ),
          ),
          Center(child: PharmacyFooter()),
        ],
      ),
    );
  }
}
