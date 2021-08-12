import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  final Function setImage;
  ImageInput(this.setImage);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
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
            'Add Image',
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          icon: Icon(Icons.add_a_photo_outlined),
        ),
        SizedBox(height: 10.0),
        _image == null
            ? Text('Please Pick an image')
            : Container(
          width: 200.0,
              child: Image.file(
                  File(_image.path.toString()),
                  fit: BoxFit.cover,
                  height: 200.0,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter,
                ),
            )
      ],
    );
  }
}
