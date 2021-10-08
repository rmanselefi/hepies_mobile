import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInputConsult extends StatefulWidget {
  final Function setImage;
  ImageInputConsult(this.setImage);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInputConsult> {
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
    // TODO: implement build
    return Column(
      children: <Widget>[
        TextButton.icon(
          onPressed: () {
            _openImagePicker(context);
          },
          label: Text(
            '',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          icon: Icon(Icons.attach_file_outlined),
        ),

      ],
    );
  }
}
