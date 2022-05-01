import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyConstant {
  // General
  static String appName = 'Job Hiring';

  // Route
  static String routeAuthen = '/authen';
  static String routeCreateAccount = '/createaccount';
  static String routeContractor = '/contractor';
  static String routeEmployer = '/employer';
  static String routeMode = '/mode';

  // Image
  static String imagelogo = 'images/logo.png';

  // Color
  static Color primary = const Color(0xffc62828);
  static Color dark = const Color(0xff8e0000);
  static Color light = const Color(0xffff5f52);

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

  TextStyle h6Style() => GoogleFonts.sarabun(
        fontSize: 12,
        color: dark,
        fontWeight: FontWeight.normal,
      );

  TextStyle h7Style() => GoogleFonts.sarabun(
        fontSize: 12,
        color: light,
        fontWeight: FontWeight.normal,
      );

  TextStyle textinput() => GoogleFonts.sarabun(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      );

  TextStyle confirmbutton() => GoogleFonts.sarabun(
        fontSize: 16,
        color: Colors.green,
        fontWeight: FontWeight.normal,
      );

  TextStyle cancelbutton() => GoogleFonts.sarabun(
        fontSize: 16,
        color: Colors.red,
        fontWeight: FontWeight.normal,
      );

  TextStyle headbar() => GoogleFonts.prompt(
        fontSize: 24,
        color: const Color(0xffffffff),
        fontWeight: FontWeight.bold,
      );

  TextStyle logotext() => GoogleFonts.prompt(
        fontSize: 30,
        color: dark,
        fontWeight: FontWeight.bold,
      );

  TextStyle errortext() => GoogleFonts.kanit(
        fontSize: 14,
        color: Colors.red[400],
        fontWeight: FontWeight.normal,
      );

  TextStyle textbutton1() => GoogleFonts.sarabun(
        fontSize: 16,
        color: const Color(0xffffffff),
        fontWeight: FontWeight.normal,
      );

  TextStyle textbutton2() => GoogleFonts.sarabun(
        fontSize: 12,
        color: const Color(0xffffffff),
        fontWeight: FontWeight.normal,
      );

  TextStyle textdialog() => GoogleFonts.notoSansThai(
        fontSize: 15,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      );

  TextStyle textdialog2() => GoogleFonts.sarabun(
        fontSize: 12,
        color: Colors.black,
        fontWeight: FontWeight.normal,
      );

  TextStyle userinfo1() => GoogleFonts.prompt(
        fontSize: 24,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );

  TextStyle userinfo2() => GoogleFonts.prompt(
        fontSize: 14,
        color: Colors.grey,
        fontWeight: FontWeight.bold,
      );
  TextStyle userinfo3() => GoogleFonts.prompt(
        fontSize: 14,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      );
  TextStyle userinfo4() => GoogleFonts.prompt(
        fontSize: 12,
        color: Colors.grey,
        fontWeight: FontWeight.normal,
      );

  TextStyle texttoast() => GoogleFonts.sarabun(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.normal,
      );

  ButtonStyle myButtonStyle1() => ElevatedButton.styleFrom(
        primary: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );

  ButtonStyle myButtonStyle2() => ElevatedButton.styleFrom(
        primary: MyConstant.dark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );

  ButtonStyle myButtonStyle3() => ElevatedButton.styleFrom(
        primary: MyConstant.light,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      );
}
