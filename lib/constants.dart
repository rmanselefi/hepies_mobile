import 'package:flutter/material.dart';

const Color greenShadow = Color(0x1e62ab45);
const Color green = Color(0xff62ab45);
const Color white = Color(0xffffffff);
const Color nearWhite = Color(0xfff7f7f7);
const Color black = Color(0xff000000);
const Color nearBlack = Color(0xff717171);
const Color fadeBlack = Color(0xffafadad);
const Color transparent = Colors.transparent;
const Color red = Colors.red;

const _kFontFam = 'MyFlutterApp';

const IconData home_circled = IconData(0xe801, fontFamily: _kFontFam);
const IconData pharmacy = IconData(0xe829, fontFamily: _kFontFam);
const IconData pills = IconData(0xea61, fontFamily: _kFontFam);
const IconData history = IconData(0xf1da, fontFamily: _kFontFam);
const IconData file_signature = IconData(0xf573, fontFamily: _kFontFam);
// const String customFont = 'varta';
// const String dir = 'assets/images/';

// const TextStyle vsText = TextStyle(fontFamily: customFont, fontSize: 12);
// const TextStyle sText = TextStyle(fontFamily: customFont, fontSize: 13.5);
// const TextStyle mText = TextStyle(fontFamily: customFont, fontSize: 15);
// const TextStyle lText = TextStyle(fontFamily: customFont, fontSize: 16.5);
// const TextStyle vlText = TextStyle(fontFamily: customFont, fontSize: 18);

const FontWeight bold = FontWeight.w700;

double aspectRatio(BuildContext context) {
  return MediaQuery.of(context).size.aspectRatio;
}

double width(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

const double stdAspectRatio = 0.5625;

const BoxShadow cardShadow = BoxShadow(
  color: greenShadow,
  offset: Offset(0, 2),
  blurRadius: 5,
);
const BoxShadow iconShadow = BoxShadow(
  color: greenShadow,
  offset: Offset(0, 10),
  blurRadius: 20,
);
const BoxShadow buttonShadow = BoxShadow(
  color: greenShadow,
  offset: Offset(0, 3),
  blurRadius: 20,
);
const BoxShadow appBarShadow = BoxShadow(
  color: greenShadow,
  offset: Offset(0, 3),
  blurRadius: 18,
);
const BoxShadow textFieldShadow = BoxShadow(
  color: greenShadow,
  offset: Offset(0, 3),
  blurRadius: 6,
);
