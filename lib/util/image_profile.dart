import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInputProfile extends StatefulWidget {
  final Function setImage;
  final String profile;
  ImageInputProfile(this.setImage, this.profile);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInputProfile> {
  XFile _image;
  Future getImage(BuildContext context, ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile image = await _picker.pickImage(source: source, maxWidth: 400.0);

    setState(() {
      _image = image;
    });
    print("imageimageimageimage $image");
    widget.setImage(image);
    Navigator.of(context).pop();
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            height: 250.0,
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Text(
                  'Pick an Image',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Divider(),
                TextButton(
                  child: Text('Use Gallery'),
                  onPressed: () {
                    getImage(context, ImageSource.gallery);
                  },
                ),
                TextButton(
                  child: Text('Use Camera'),
                  onPressed: () {
                    getImage(context, ImageSource.camera);
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print("profileprofile ${widget.profile}");
    //bool _validURL = Uri.parse(widget.profile).isAbsolute;
    bool _validURL = false; // Milkessa: just for the time being
    // TODO: implement build
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 20.0),
          child: new Stack(fit: StackFit.loose, children: <Widget>[
            widget.profile != null || _image != null
                ? new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              image: _image == null
                                  ? new NetworkImage(widget.profile)
                                  : new FileImage(
                                      File(_image.path.toString()),
                                    ),
                              fit: BoxFit.cover,
                            ),
                          )),
                    ],
                  )
                : Container(),
            Padding(
                padding: EdgeInsets.only(top: 90.0, right: 100.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new CircleAvatar(
                      backgroundColor: Colors.red,
                      radius: 25.0,
                      child: IconButton(
                        onPressed: () {
                          _openImagePicker(context);
                        },
                        icon: new Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )),
          ]),
        ),
      ],
    );
  }
}
