import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  TextStyle h1Style() => GoogleFonts.prompt(
        fontSize: 24,
        color: dark,
        fontWeight: FontWeight.bold,
      );
  TextStyle h2Style() => GoogleFonts.sarabun(
        fontSize: 18,
        color: dark,
        fontWeight: FontWeight.w700,
      );
  TextStyle h3Style() => GoogleFonts.sarabun(
        fontSize: 16,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h4Style() => GoogleFonts.sarabun(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.normal,
      );
  TextStyle h5Style() => GoogleFonts.sarabun(
        fontSize: 14,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle headbar() => GoogleFonts.prompt(
        fontSize: 24,
        color: Color(0xffffffff),
        fontWeight: FontWeight.bold,
      );
  TextStyle textbutton() => GoogleFonts.sarabun(
        fontSize: 16,
        color: Color(0xffffffff),
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
