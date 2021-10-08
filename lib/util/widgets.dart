import 'package:flutter/material.dart';

MaterialButton longButtons(String title, bool disabled, Function fun,
    {Color color: const Color(0xff07febb), Color textColor: Colors.black}) {
  return MaterialButton(
    onPressed: disabled ? null : fun,
    textColor: textColor,
    color: color,
    child: SizedBox(
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20.0),
      ),
    ),
    height: 45,
    minWidth: 600,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10))),
  );
}

label(String title) => Text(title);

InputDecoration buildInputDecoration(String hintText, IconData icon) {
  return InputDecoration(
    prefixIcon: Icon(icon, color: Color.fromRGBO(50, 62, 72, 1.0)),
    // hintText: hintText,
    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
  );
}
