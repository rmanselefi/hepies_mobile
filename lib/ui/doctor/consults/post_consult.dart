import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hashtagable/widgets/hashtag_text.dart';
import 'package:hashtagable/widgets/hashtag_text_field.dart';
import 'package:hepies/constants.dart';
import 'package:hepies/providers/consult.dart';
import 'package:hepies/ui/doctor/consults/consult_list.dart';
import 'package:hepies/ui/pharmacy/ui/consults/consult_list.dart';
import 'package:hepies/ui/pharmacy/ui/consults/search_list.dart';
import 'package:hepies/ui/pharmacy/widgets/footer.dart';
import 'package:hepies/util/image_consult.dart';
import 'package:hepies/widgets/footer.dart';
import 'package:hepies/widgets/header.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';

class PostConsult extends StatefulWidget {
  const PostConsult({Key key}) : super(key: key);

  @override
  State<PostConsult> createState() => _PostConsultState();
}

class _PostConsultState extends State<PostConsult> {
  final formKey = new GlobalKey<FormState>();
  var _interestsController = new TextEditingController();
  var _topic = new TextEditingController();
  XFile file;
  List<dynamic> interests = [];
  List<dynamic> subList = [];
  String interestStatus = "hide";
  List<dynamic> _myInterests = [];

  List interestList = [];

  var name = '';
  void _setImage(XFile image) {
    setState(() {
      file = image;
    });

    print("_formData_formData_formData${file}");
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

  getInterests() async {
    List interests = await ConsultProvider().getInterests();

    setState(() {
      interests.forEach((element) {
        var property = {
          'display': "#${element['interest']}",
          'value': element['interest'],
        };
        interestList.add(property);
      });
    });
  }

  var loading = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[CircularProgressIndicator()],
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setInterests();
    getInterests();
  }

  @override
  Widget build(BuildContext context) {
    ConsultProvider consult = Provider.of<ConsultProvider>(context);

    List<dynamic> interest = interests
        .where((element) => element['interest'].toLowerCase().contains(name))
        .toList();
    final interestField = new MultiSelectFormField(
      open: () {
        getInterests();
      },
      chipBackGroundColor: Colors.red,
      chipLabelStyle: TextStyle(fontWeight: FontWeight.bold),
      dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
      checkBoxActiveColor: Colors.red,
      checkBoxCheckColor: Colors.green,
      dialogShapeBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0))),
      title: Text(
        "Add interests ",
        style: TextStyle(fontSize: 16),
      ),
      dataSource: interestList,
      textField: 'display',
      valueField: 'value',
      okButtonLabel: 'OK',
      cancelButtonLabel: 'CANCEL',
      hintWidget: Text('Please choose one or more'),
      initialValue: _myInterests,
      onSaved: (value) {
        if (value == null) return;
        // print("_interests_interests_interests ${value.join(",")}");
        var hashtaglists = [];
        for (var item in value) {
          hashtaglists.add("#${item.toString()}");
        }
        setState(() {
          _myInterests = hashtaglists;
        });
      },
    );
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black54)),
      body: Container(
        height: MediaQuery.of(context).size.height / 1.7,
        child: Column(
          children: [
            Expanded(
                child: SizedBox(
              height: 10,
            )),
            Expanded(
              flex: 2,
              child: Container(
                  margin: EdgeInsets.all(10),
                  child: TextField(
                    controller: _topic,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Enter your Topic....",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1)),
                    ),
                    maxLines: 8,
                  )),
            ),
            Expanded(
              flex: 3,
              child: Row(
                // Milkesa: Added mini image display next to consult text field
                children: [
                  Flexible(
                    flex: 3,
                    child: Padding(
                      padding: EdgeInsets.all(3),
                      child: interestField,
                    ),
                  ),
                  file != null
                      ? Expanded(
                          child: Container(
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
                          ),
                        )
                      : Container(width: 0),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.only(right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        ImageInputConsult(_setImage),
                        consult.shareStatus == ConsultStatus.Sharing
                            ? loading
                            : Align(
                                alignment: Alignment.topRight,
                                child: OutlinedButton(
                                  onPressed: () async {
                                    try {
                                      var photo =
                                          file != null ? File(file.path) : null;
                                      if (_myInterests.length !=
                                              0 || //Milkessa: added posting capability with either text or image
                                          file != null || _topic.text.length != 0) {
                                        var res = await consult.share(
                                            _topic.text,
                                            photo,
                                            _myInterests.join(" ").toString());
                                        if (res['status']) {
                                          consult.getConsults();
                                          showTopSnackBar(
                                            context,
                                            CustomSnackBar.success(
                                              message:
                                                  "Your consult is uploaded succesfully",
                                            ),
                                          );
                                          Navigator.pop(context);
                                        }
                                      } else {
                                        showTopSnackBar(
                                          context,
                                          CustomSnackBar.error(
                                            message:
                                                "Invalid Data! Make sure you have inserted image or text",
                                          ),
                                        );
                                        Navigator.pop(context);
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
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Container(
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.all(3.0),
                                    decoration: BoxDecoration(
                                      boxShadow: [buttonShadow],
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Container(
                                      margin: EdgeInsets.zero,
                                      padding: EdgeInsets.all(3.0),
                                      decoration: BoxDecoration(
                                        boxShadow: [buttonShadow],
                                        borderRadius: BorderRadius.circular(3),
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
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
