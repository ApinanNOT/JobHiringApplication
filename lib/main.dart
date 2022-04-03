import 'package:flutter/material.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/states/contractor.dart';
import 'package:jobhiring/states/create_account.dart';
import 'package:jobhiring/states/employer.dart';
import 'package:jobhiring/utility/my_constant.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context) => CreateAccount(),
  '/employer': (BuildContext context) => Employer(),
  '/contractor': (BuildContext context) => Contractor(),
};

String? initlalRoute;

void main() {
  initlalRoute = MyConstant.routeAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initlalRoute,
    );
  }
}
