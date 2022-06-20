import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/models/job_data.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/states/mode.dart';
import 'package:jobhiring/utility/my_constant.dart';

import '../assistants/assistant_methods.dart';
import '../models/contractorRequestinformation.dart';
import '../widgets/show_image.dart';

class EmpAccepted extends StatefulWidget {

  const EmpAccepted({Key? key}) : super(key: key);

  @override
  _EmpAcceptedState createState() => _EmpAcceptedState();
}

class _EmpAcceptedState extends State<EmpAccepted> {
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ผู้ว่าจ้างยอมรับคุณทำงาน',
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
                'รอผู้ว่าจ้างยอมรับงาน',
                style: MyConstant().logotext(),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'ผู้ว่าจ้างจะยอมรับงานเมื่อคุณได้ทำงานสำเร็จ',style: MyConstant().h3Style(),
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
