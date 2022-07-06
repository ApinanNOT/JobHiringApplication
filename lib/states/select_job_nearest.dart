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

class _SelectJobNearestState extends State<SelectJobNearest> {

  Widget appBarTitle =
  Text(
    "งานรอบตัวคุณ",
    style: MyConstant().headbar(),
  );
  Icon icon = const Icon(
    Icons.search,
    color: Colors.white,
  );

  final globalKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final List<dynamic> _list = jList;
  late bool _isSearching;
  String _searchText = "";
  List searchresult = [];

  _SelectJobNearestState() {
    _controller.addListener(() {
      if (_controller.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _controller.text;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: globalKey,
        appBar: AppBar(
            centerTitle: true,
            title: appBarTitle,
            backgroundColor: MyConstant.primary,
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
              actions: [
          IconButton(
            icon: icon,
            onPressed: () {
              setState(() {
                if (icon.icon == Icons.search) {
                  icon =  const Icon(
                    Icons.cancel,
                    color: Colors.white,
                    size: 25,
                  );
                  appBarTitle = TextField(
                    controller: _controller,
                    style: MyConstant().searchtext(),
                    decoration: InputDecoration(
                      icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25),
                      hintText: "ค้นหา",
                      hintStyle: MyConstant().searchtext(),
                    ),
                    onChanged: searchOperation,
                  );
                  _handleSearchStart();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ]),
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: searchresult.isNotEmpty || _controller.text.isNotEmpty
                      ? ListView.builder(
                    //เมื่อมีการค้นหา
                    shrinkWrap: true,
                    itemCount: searchresult.length,
                    itemBuilder: (BuildContext context, int index) {
                      String jobname = searchresult[index];
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
                                    //jList[index]["name"],
                                    jobname.toString(),
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
                  )
                  //เมื่อไม่มีการค้นหา
                      : ListView.builder(
                    shrinkWrap: true,
                    itemCount: _list.length,
                    itemBuilder: (BuildContext context, int index) {
                      String jobname = _list[index]["name"];
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
              ),
            ],
          ),
        ));
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      icon = const Icon(
        Icons.cancel,
        color: Colors.white,
        size: 25,
      );
      appBarTitle = Text(
        "งานรอบตัวคุณ",
        style: MyConstant().headbar(),
      );
      _isSearching = false;
      _controller.clear();
    });
  }

  void searchOperation(String searchText) {
    searchresult.clear();
    if (_isSearching != null)
    {
      for (int i = 0; i < _list.length; i++) {
        String name = _list[i]["name"];
        String money = _list[i]["money"];
        String safe = _list[i]["safe"];
        String gender = _list[i]["gender"];

        if (name.toLowerCase().contains(searchText.toLowerCase()))
        {
          searchresult.add(name);
        }
        else if(money.toLowerCase().contains(searchText.toLowerCase()))
        {
          searchresult.add(money);
        }
        else if(safe.toLowerCase().contains(searchText.toLowerCase()))
        {
          searchresult.add(safe);
        }
        else if(gender.toLowerCase().contains(searchText.toLowerCase()))
        {
          searchresult.add(gender);
        }
      }
    }
  }
}
