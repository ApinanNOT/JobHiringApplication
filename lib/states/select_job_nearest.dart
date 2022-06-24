import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:jobhiring/assistants/geofire_assistant.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/main.dart';
import 'package:jobhiring/states/contractor.dart';
import 'package:jobhiring/tabStates/homecontractor.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../models/job_location.dart';
import '../utility/progress_dialog.dart';
import '../widgets/show_image.dart';
import '../widgets/show_title.dart';
import 'employered.dart';

class SelectJobNearest extends StatefulWidget
{

  DatabaseReference? referenceContractorRequest;

  SelectJobNearest({this.referenceContractorRequest});

  @override
  State<SelectJobNearest> createState() => _SelectJobNearestState();
}

class _SelectJobNearestState extends State<SelectJobNearest>
{

  @override
  void initState()
  {
    super.initState();
    //jList.length = 0;
    //jList.clear();

    print("เป็นอิหยังวะ");
    print(jList);
    print(jList.length);
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyConstant.primary,
        title: Text(
          "งานรอบตัวคุณ"
          ,style: MyConstant().headbar(),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: ()
          {
            widget.referenceContractorRequest!.remove();
            Navigator.pop(context);
            jList.clear();
          },
        ),
      ),
      body: Scrollbar(
        thickness: 8,
        child: ListView.builder(
          itemCount: jList.length,
          itemBuilder: (BuildContext context, index)
          {
            return GestureDetector(
              onTap: ()
              {

                //dialogdetail(context, index);
                setState(()
                {
                  chosenJobId = jList[index]["jobId"].toString();
                });


                Navigator.pop(context,"jobChoosed");
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  child: ListTile(
                    // leading: Image.asset(
                    //   'images/' + jList[index]['safe'].toString() + ".png",
                    // ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children:
                      [
                        Text(
                          jList[index]["name"],
                          style: MyConstant().jobname(),
                        ),

                        const SizedBox(height: 10.0),

                        Text(
                          jList[index]["money"] + " " + "บาท",
                          style: MyConstant().jobmoney(),
                        ),

                        const SizedBox(height: 13.0),

                        //point of employer
                        SmoothStarRating(
                          rating: 2,
                          color: Colors.yellow,
                          borderColor: Colors.grey[600],
                          allowHalfRating: true,
                          starCount: 5,
                          size: 15,
                        ),
                      ],
                    ),
                    // trailing: Column(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const SizedBox(height: 2,),
                    //     Text(
                    //       "10 กิโลเมตร", style: MyConstant().h4Style(),
                    //     )
                    //   ],
                    // ),
                  ),
                ),
              ),
            );
          },
        ),
        radius: const Radius.circular(50),
      ),
    );
  }

  Future<dynamic> dialogdetail(BuildContext context, int index) {
    return showDialog(
      barrierDismissible: false, //no touch freespace for exits
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 10,
                title: Container(
                  margin: const EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      const SizedBox(height: 2),

                      Text(
                        jList[index]["name"],
                        style: MyConstant().jobname(),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "ค่าตอบแทน : " + jList[index]["money"] + " " + "บาท",
                                        style: MyConstant().userinfo5(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 13.0),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "เพศที่ต้องการ : " + jList[index]["gender"],
                                        style: MyConstant().userinfo5(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 13.0),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "ระดับความปลอดภัย : " + jList[index]["safe"],
                                        style: MyConstant().userinfo5(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 13.0),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "อายุที่ต้องการ : " + jList[index]["age"],
                                        style: MyConstant().userinfo5(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 13.0),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "เบอร์ติดต่อ : " + jList[index]["phone"],
                                        style: MyConstant().userinfo5(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 13.0),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "วันที่ทำ : " + jList[index]["date"],
                                        style: MyConstant().userinfo5(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 13.0),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "เวลา : " + jList[index]["time"],
                                        style: MyConstant().userinfo5(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 13.0),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "สถานที่ : " + jList[index]["address"],
                                        style: MyConstant().userinfo5(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 13.0),

                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Text(
                                        "เพิ่มเติม : " + jList[index]["detail"],
                                        style: MyConstant().userinfo5(),
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 13.0),

                              //คะแนนการทำงานเฉลี่ย
                              SmoothStarRating(
                                rating: 2,
                                color: Colors.yellow,
                                borderColor: Colors.grey[600],
                                allowHalfRating: true,
                                starCount: 5,
                                size: 20,
                              )
                            ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red,
                                ),
                                onPressed: ()
                                {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "ไม่สนใจ".toUpperCase(),
                                  style: MyConstant().textnotificationRequest(),
                                )
                            ),

                            const SizedBox(width: 40.0),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: MyConstant.confirm,
                              ),
                              onPressed: ()
                              {

                                setState(()
                                {
                                  chosenJobId = jList[index]["jobId"].toString();
                                });

                                Navigator.pop(context,"jobChoosed");

                              },
                              child: Text(
                                "สนใจ".toUpperCase(),
                                style: MyConstant().textnotificationRequest(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
  }
}
