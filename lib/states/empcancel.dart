import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/states/contractor.dart';
import 'package:jobhiring/states/mode.dart';
import 'package:jobhiring/tabStates/homecontractor.dart';
import 'package:jobhiring/utility/my_constant.dart';

import '../assistants/assistant_methods.dart';

class EmpCancel extends StatefulWidget {
  const EmpCancel({Key? key}) : super(key: key);

  @override
  _EmpCancelState createState() => _EmpCancelState();
}

class _EmpCancelState extends State<EmpCancel> {

  startTimer() {

    Timer(const Duration(seconds: 3), () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Contractor()));
    });
  }

  final refresh = const SpinKitFadingCircle(
    color: Colors.green,
    size: 70.0,
  );

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ผู้ว่าจ้างปฎิเสธ',
          style: MyConstant().headbar(),
        ),
        backgroundColor: MyConstant.primary,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'ผู้ว่าจ้างปฏิเสธคุณทำงาน',
                style: MyConstant().logotext(),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'ระบบกำลังนำคุณไปเลือกงานใหม่',style: MyConstant().h3Style(),
              ),
              const SizedBox(
                height: 30,
              ),
              refresh
            ],
          ),
        ),
      ),
    );
  }
}
