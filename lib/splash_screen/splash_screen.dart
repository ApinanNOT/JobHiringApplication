import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/states/mode.dart';
import 'package:jobhiring/utility/my_constant.dart';

import '../assistants/assistant_methods.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {

    fAuth.currentUser != null ?  AssistantMethods.readCurrentOnlineUserInfo() : null; //เรียกใช้งานเมื่อเข้าสู่ระบบสำเร็จ
    //fAuth.currentUser !=null ? AssistantMethods.readCurrentOnlineJobInfo() : null;


    Timer(const Duration(seconds: 2), () async {
      if (await fAuth.currentUser != null) {
        currentFirebaseUser = fAuth.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Mode()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Authen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/logo.png"),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Job Hiring',
                style: MyConstant().logotext(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
