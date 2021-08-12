import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  final String label;
  final bool withAsterisk;
  const FormTextField({Key key, @required this.label, @required this.withAsterisk})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(

        child: TextFormField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 1),
              )),
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10, top: 10),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: ' $label',
                  style: TextStyle(
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
              TextSpan(
                  text: withAsterisk ? '* ' : ' ',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      backgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                      color: Colors.red)),
            ],
          ),
        ),
      ),
    ]);
  }
}