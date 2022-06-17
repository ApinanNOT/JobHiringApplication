import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/states/mode.dart';
import 'package:jobhiring/utility/my_constant.dart';

import '../assistants/assistant_methods.dart';
import '../widgets/show_image.dart';

class JobEnd extends StatefulWidget {
  const JobEnd({Key? key}) : super(key: key);

  @override
  _JobEndState createState() => _JobEndState();
}

class _JobEndState extends State<JobEnd> {

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
          'ยอมรับงาน',
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
                'กรุณายอมรับงาน',
                style: MyConstant().logotext(),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                'ยอมรับงานเมื่อผู้รับจ้างทำงานได้ตามที่ตกลง',style: MyConstant().h3Style(),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MyConstant.confirm,
                ),
                onPressed: ()
                {

                },
                child: Text(
                  "ยอมรับ".toUpperCase(),
                  style: MyConstant().headbar(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
