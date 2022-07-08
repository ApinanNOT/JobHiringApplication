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

class SelectJobNearest extends StatefulWidget {
  DatabaseReference? referenceContractorRequest;

  SelectJobNearest({this.referenceContractorRequest});

  @override
  State<SelectJobNearest> createState() => _SelectJobNearestState();
}

class _SelectJobNearestState extends State<SelectJobNearest>
{

  final List<dynamic> _allJobs = jList;

  // This list holds the data for the list view
  List<dynamic> _foundJobs = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundJobs = _allJobs;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allJobs;
    } else{
      results = _allJobs
          .where((job) =>
          job["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundJobs = results;
    });
  }

  bool searchState = false;

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyConstant.primary,
        title: !searchState
            ? Text(
          "งานรอบตัวคุณ",
          style: MyConstant().headbar(),
        )
            : TextField(
          style: MyConstant().searchtext(),
          decoration: InputDecoration(
            icon: const Icon(Icons.search, color: Colors.white, size: 25),
            hintText: "ค้นหา",
            hintStyle: MyConstant().searchtext(),
          ),
          onChanged: (value) {
            //search
            _runFilter(value);
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 5,
              ),
              Expanded(
                child: _foundJobs.isNotEmpty
                    ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: _foundJobs.length,
                  itemBuilder: (context, index)
                  {
                    return GestureDetector(
                      onTap: ()
                      {
                        dialogdetail(context,index);
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
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _foundJobs[index]["name"],
                                  style: MyConstant().jobname(),
                                ),

                                const SizedBox(height: 10.0),

                                Text(
                                  _foundJobs[index]["money"] + " " + "บาท",
                                  style: MyConstant().jobmoney(),
                                ),

                                const SizedBox(height: 13.0),

                                //point of employer
                                SmoothStarRating(
                                  rating: double.parse(_foundJobs[index]["ratings"]),
                                  color: Colors.yellow,
                                  borderColor: Colors.yellow,
                                  allowHalfRating: true,
                                  starCount: 5,
                                  size: 15,
                                ),

                                const SizedBox(height: 5.0),
                              ],
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 4),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: MyConstant.confirm,
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                        ),
                      ),
                    );
                  }
                )
                    : Column(
                      children: [
                        const SizedBox(height: 150),
                          const Center(
                            child: Icon(
                                Icons.search_off ,
                                size: 60,
                                color: Colors.grey
                            ),
                          ),
                        const SizedBox(height: 10),

                        Center(
                          child: Text(
                            "ไม่เจอสิ่งที่ค้นหา",
                            style: MyConstant().searchmatch(),
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

  Future<dynamic> dialogdetail(BuildContext context, int index)
  {
    return showDialog(
      barrierDismissible: true, //no touch freespace for exits
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        child: Container(
          margin: const EdgeInsets.all(5),
          width: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 5),

              Text(
                _foundJobs[index]["name"],
                style: MyConstant().jobname(),
              ),

              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "ค่าตอบแทน : " + _foundJobs[index]["money"] + " " + "บาท",
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "เพศที่ต้องการ : " + _foundJobs[index]["gender"],
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "ระดับความปลอดภัย : " + _foundJobs[index]["safe"],
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "อายุที่ต้องการ : " + _foundJobs[index]["age"],
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "เบอร์ติดต่อ : " + _foundJobs[index]["phone"],
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "วันที่ทำ : " + _foundJobs[index]["date"],
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "เวลา : " + _foundJobs[index]["time"],
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "สถานที่ : " + _foundJobs[index]["address"],
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "เพิ่มเติม : " + _foundJobs[index]["detail"],
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10.0),

                    //คะแนนการทำงานเฉลี่ย
                    SmoothStarRating(
                      rating: double.parse(_foundJobs[index]["ratings"]),
                      color: Colors.yellow,
                      borderColor: Colors.yellow,
                      allowHalfRating: true,
                      starCount: 5,
                      size: 20,
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
