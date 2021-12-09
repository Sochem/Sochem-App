import 'package:flutter/material.dart';

const String SochemIcon = "assets/sochem.jpeg";
const String Slideimg1 = "assets/slider/img1.png";
const String Slideimg2 = "assets/slider/img2.png";
const String Slideimg3 = "assets/slider/img3.png";

class ColorConstant {
  static Color highlighted = Colors.white;
  static Color unhighlighted = Colors.white;

  static colorAssign() {
    ColorConstant.highlighted = Color.fromRGBO(136, 144, 178, 1);
    ColorConstant.unhighlighted = Color.fromRGBO(206, 209, 223, 1);
  }
}
