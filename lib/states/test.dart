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

class Test extends StatefulWidget {
  DatabaseReference? referenceContractorRequest;

  Test({this.referenceContractorRequest});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  String? typeUser;
  final formKey = GlobalKey<FormState>(); //create variable
  List<String> searchgenderlist = ["ชาย", "หญิง", "LGBTQ", "ทุกเพศ"]; //gender
  String? selectedsearchgendertype;

  List<String> searchsafelist = ["ปลอดภัย", "เสี่ยง", "อันตราย"]; //gender
  String? selectedsearchsafetype;

  List<String> searchagelist = [
    "18 - 60 ปี",
    "18 - 20 ปี",
    "21 - 30 ปี",
    "31 - 40 ปี",
    "41 - 50 ปี",
    "51 - 60 ปี"
  ]; //age
  String? selectedsearchagetype;

  List<String> searchmoneylist = [
    "น้อยกว่า 100 บาท",
    "100 - 500 บาท",
    "501 - 1000 บาท",
    "1001 - 1500 บาท",
    "1501 - 2000 บาท",
    "2001 - 2500 บาท",
    "2501 - 3000 บาท",
    "มากกว่า 3000 บาท"
  ]; //money
  String? selectedsearchmoneytype;

  bool searchState = false;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //jList.length = 0;
    //jList.clear();
    //_searchController.addListener(_onSearchChanged);
    //_searchController.dispose();

    print("เป็นอิหยังวะ");
    print(jList);
    print(jList.length);
  }

  searchDetails() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "กำลังค้นหางาน",
        );
      },
    );

    //function search
  }

  Row buildSearchMoney(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'ค่าตอบแทน',
                labelStyle: MyConstant().h3Style(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              value: selectedsearchmoneytype,
              onChanged: (newValue) {
                setState(() {
                  selectedsearchmoneytype = newValue.toString();
                });
              },
              items: searchmoneylist.map((money) {
                return DropdownMenuItem(
                  child: Text(
                    money,
                    style: MyConstant().textinput(),
                  ),
                  value: money,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildSearchGender(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'เพศที่ต้องการ',
                labelStyle: MyConstant().h3Style(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              value: selectedsearchgendertype,
              onChanged: (newValue) {
                setState(() {
                  selectedsearchgendertype = newValue.toString();
                });
              },
              items: searchgenderlist.map((gender) {
                return DropdownMenuItem(
                  child: Text(
                    gender,
                    style: MyConstant().textinput(),
                  ),
                  value: gender,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildSearchSafe(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'ระดับความปลอดภัย',
                labelStyle: MyConstant().h3Style(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              value: selectedsearchsafetype,
              onChanged: (newValue) {
                setState(() {
                  selectedsearchsafetype = newValue.toString();
                });
              },
              items: searchsafelist.map((safe) {
                return DropdownMenuItem(
                  child: Text(
                    safe,
                    style: MyConstant().textinput(),
                  ),
                  value: safe,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildSearchAge(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'ช่วงอายุ',
                labelStyle: MyConstant().h3Style(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              value: selectedsearchagetype,
              onChanged: (newValue) {
                setState(() {
                  selectedsearchagetype = newValue.toString();
                });
              },
              items: searchagelist.map((age) {
                return DropdownMenuItem(
                  child: Text(
                    age,
                    style: MyConstant().textinput(),
                  ),
                  value: age,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size * 0.3,
          child: ShowImage(path: MyConstant.imagelogo),
        ),
      ],
    );
  }

  Row buildSearch(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 18),
          width: size * 0.6,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              if ((selectedsearchmoneytype != null) ||
                  (selectedsearchgendertype != null) ||
                  (selectedsearchsafetype != null) ||
                  (selectedsearchsafetype != null) ||
                  (selectedsearchagetype != null)) {
                Navigator.pop(context);
                searchDetails();
              } else {
                Toast.show(
                  "กรุณาระบุรายละเอียดอย่างน้อย 1 อย่าง",
                  context,
                  duration: Toast.lengthLong,
                  gravity: Toast.center,
                  backgroundColor: Colors.red,
                  textStyle: MyConstant().texttoast(),
                );
              }
            },
            child: Text(
              'ค้นหา',
              style: MyConstant().textbutton1(),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> jobFormSearch(double size) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          scrollable: true,
          title: Text(
            "รายละเอียด",
            style: MyConstant().h2Style(),
            textAlign: TextAlign.center,
          ),
          content: Padding(
            padding: const EdgeInsets.all(14.0),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //buildImage(size),
                    buildSearchMoney(size),
                    buildSearchGender(size),
                    buildSearchSafe(size),
                    buildSearchAge(size),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            buildSearch(size),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyConstant.primary,
        title: !searchState
            ? Text(
                "งานรอบตัวคุณ",
                style: MyConstant().headbar(),
              )
            : TextField(
                controller: searchController,
                style: MyConstant().searchtext(),
                decoration: InputDecoration(
                  icon: const Icon(Icons.search, color: Colors.white, size: 25),
                  hintText: "ค้นหา",
                  hintStyle: MyConstant().searchtext(),
                ),
                onChanged: (value) {
                  //search
                  print(searchController);
                },
              ),
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            widget.referenceContractorRequest!.remove();
            Navigator.pop(context);
            jList.clear();
          },
        ),
        actions: <Widget>[
          !searchState
              ? IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    //jobFormSearch(size);
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    //jobFormSearch(size);
                    setState(() {
                      searchState = !searchState;
                    });
                  },
                ),
          const SizedBox(width: 10)
        ],
      ),
      body: Scrollbar(
        thickness: 8,
        child: ListView.builder(
          itemCount: jList.length,
          itemBuilder: (BuildContext context, index) {
            return GestureDetector(
              onTap: () {
                //dialogdetail(context, index);
                setState(() {
                  chosenJobId = jList[index]["jobId"].toString();
                });

                Navigator.pop(context, "jobChoosed");
              },
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                elevation: 5,
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 24.0),
                  child: ListTile(
                    //image for safe type
                    // leading: Image.asset(
                    //   'images/' + jList[index]['safe'].toString() + ".png",
                    // ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
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
                          rating: double.parse(jList[index]["ratings"]),
                          color: Colors.yellow,
                          borderColor: Colors.yellow,
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

  // Future<dynamic> dialogdetail(BuildContext context, int index) {
  //   return showDialog(
  //     barrierDismissible: false, //no touch freespace for exits
  //             context: context,
  //             builder: (context) => AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(20),
  //               ),
  //               elevation: 10,
  //               title: Container(
  //                 margin: const EdgeInsets.all(8),
  //                 width: double.infinity,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(10),
  //                   color: Colors.white,
  //                 ),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: [
  //
  //                     const SizedBox(height: 2),
  //
  //                     Text(
  //                       jList[index]["name"],
  //                       style: MyConstant().jobname(),
  //                     ),
  //
  //                     Padding(
  //                       padding: const EdgeInsets.all(20.0),
  //                         child: Column(
  //                           children: [
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Text(
  //                                       "ค่าตอบแทน : " + jList[index]["money"] + " " + "บาท",
  //                                       style: MyConstant().userinfo5(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             const SizedBox(height: 13.0),
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Text(
  //                                       "เพศที่ต้องการ : " + jList[index]["gender"],
  //                                       style: MyConstant().userinfo5(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             const SizedBox(height: 13.0),
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Text(
  //                                       "ระดับความปลอดภัย : " + jList[index]["safe"],
  //                                       style: MyConstant().userinfo5(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             const SizedBox(height: 13.0),
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Text(
  //                                       "อายุที่ต้องการ : " + jList[index]["age"],
  //                                       style: MyConstant().userinfo5(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             const SizedBox(height: 13.0),
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Text(
  //                                       "เบอร์ติดต่อ : " + jList[index]["phone"],
  //                                       style: MyConstant().userinfo5(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             const SizedBox(height: 13.0),
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Text(
  //                                       "วันที่ทำ : " + jList[index]["date"],
  //                                       style: MyConstant().userinfo5(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             const SizedBox(height: 13.0),
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Text(
  //                                       "เวลา : " + jList[index]["time"],
  //                                       style: MyConstant().userinfo5(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             const SizedBox(height: 13.0),
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Text(
  //                                       "สถานที่ : " + jList[index]["address"],
  //                                       style: MyConstant().userinfo5(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             const SizedBox(height: 13.0),
  //
  //                             Row(
  //                               children: [
  //                                 Expanded(
  //                                   child: Container(
  //                                     child: Text(
  //                                       "เพิ่มเติม : " + jList[index]["detail"],
  //                                       style: MyConstant().userinfo5(),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //
  //                             const SizedBox(height: 13.0),
  //
  //                             //คะแนนการทำงานเฉลี่ย
  //                             SmoothStarRating(
  //                               rating: 2,
  //                               color: Colors.yellow,
  //                               borderColor: Colors.grey[600],
  //                               allowHalfRating: true,
  //                               starCount: 5,
  //                               size: 20,
  //                             )
  //                           ],
  //                       ),
  //                     ),
  //
  //                     Padding(
  //                       padding: const EdgeInsets.all(15.0),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           ElevatedButton(
  //                               style: ElevatedButton.styleFrom(
  //                                 primary: Colors.red,
  //                               ),
  //                               onPressed: ()
  //                               {
  //                                 Navigator.pop(context);
  //                               },
  //                               child: Text(
  //                                 "ไม่สนใจ".toUpperCase(),
  //                                 style: MyConstant().textnotificationRequest(),
  //                               )
  //                           ),
  //
  //                           const SizedBox(width: 40.0),
  //
  //                           ElevatedButton(
  //                             style: ElevatedButton.styleFrom(
  //                               primary: MyConstant.confirm,
  //                             ),
  //                             onPressed: ()
  //                             {
  //
  //                               setState(()
  //                               {
  //                                 chosenJobId = jList[index]["jobId"].toString();
  //                               });
  //
  //                               Navigator.pop(context,"jobChoosed");
  //
  //                             },
  //                             child: Text(
  //                               "สนใจ".toUpperCase(),
  //                               style: MyConstant().textnotificationRequest(),
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             ),
  //           );
  // }
}
