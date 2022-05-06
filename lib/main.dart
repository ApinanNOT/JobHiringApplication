import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jobhiring/splash_screen/splash_screen.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/states/contractor.dart';
import 'package:jobhiring/states/create_account.dart';
import 'package:jobhiring/states/employer.dart';
import 'package:jobhiring/states/mode.dart';
import 'package:jobhiring/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => const Authen(),
  '/createaccount': (BuildContext context) => const CreateAccount(),
  '/employer': (BuildContext context) => const Employer(),
  '/contractor': (BuildContext context) => const Contractor(),
  '/mode': (BuildContext context) => const Mode(),
};

String? initlalRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initlalRoute = MyConstant.routeAuthen;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      //initialRoute: initlalRoute,
      home: const MySplashScreen(),
    );
  }
}
