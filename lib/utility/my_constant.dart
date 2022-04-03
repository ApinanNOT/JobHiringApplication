import 'package:flutter/material.dart';

class MyConstant {
  // General
  static String appName = 'Job Hiring';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createAccount';
  static String routeContractor = '/contractor';
  static String routeEmployer = '/employer';

  // Image
  static String imagelogo = 'images/logo.png';

  // Color
  static Color primary = Color(0xffc62828);
  static Color dark = Color(0xff8e0000);
  static Color light = Color(0xffff5f52);

  // Style
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => TextStyle(
        fontSize: 16,
        color: dark,
        fontWeight: FontWeight.normal,
      );
}
