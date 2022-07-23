import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jobhiring/states/trips_history_screen.dart';
import 'package:jobhiring/utility/my_constant.dart';

import '../global/global.dart';
import '../widgets/show_image.dart';

class MyJob extends StatefulWidget {
  const MyJob({Key? key}) : super(key: key);

  @override
  State<MyJob> createState() => _MyJobState();
}

class _MyJobState extends State<MyJob> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery
        .of(context)
        .size
        .width;
    return Center(
      child: Card(
        margin: const EdgeInsets.all(30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: MyConstant.primary,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 20),

              Text(
                jobModelCurrentInfo!.name.toString(),
                style: MyConstant().jobname2(),
              ),

              const SizedBox(height: 6.0),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "ค่าตอบแทน : " + jobModelCurrentInfo!.money.toString() + " " + "บาท",
                              style: MyConstant().userinfo6(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "เพศที่ต้องการ : " + jobModelCurrentInfo!.gender.toString(),
                              style: MyConstant().userinfo6(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "ระดับความปลอดภัย : " + jobModelCurrentInfo!.safe.toString(),
                              style: MyConstant().userinfo6(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "อายุที่ต้องการ : " + jobModelCurrentInfo!.age.toString(),
                              style: MyConstant().userinfo6(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "วันที่ทำ : " + jobModelCurrentInfo!.date.toString(),
                              style: MyConstant().userinfo6(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "ปรเภทบุคคล : " + jobModelCurrentInfo!.type.toString(),
                              style: MyConstant().userinfo6(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "เวลา : " + jobModelCurrentInfo!.time.toString(),
                              style: MyConstant().userinfo6(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "สถานที่ : " + jobModelCurrentInfo!.address.toString(),
                              style: MyConstant().userinfo6(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "เพิ่มเติม : " + jobModelCurrentInfo!.detail.toString(),
                              style: MyConstant().userinfo6(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  }
}
