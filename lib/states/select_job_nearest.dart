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
import 'package:jobhiring/utility/my_constant.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../utility/progress_dialog.dart';

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
      body: ListView.builder(
        itemCount: jList.length,
        itemBuilder: (BuildContext context, index)
        {
          return GestureDetector(
            onTap: ()
            {
              setState(()
              {
                //selectJobID = jList[index]["jobID"].toString();
              });

              Navigator.pop(context,"jobSelected");

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
                  leading: Image.asset(
                    'images/' + jList[index]['safe'].toString() + ".png",
                  ),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:
                    [
                      Text(
                        jList[index]["name"],
                        style: MyConstant().h2Style(),
                      ),
                      Text(
                        jList[index]["money"],
                        style: MyConstant().h2Style(),
                      ),
                      //point of employer
                      SmoothStarRating(
                        rating: 3.5,
                        color: Colors.yellow,
                        borderColor: Colors.grey[600],
                        allowHalfRating: true,
                        starCount: 5,
                        size: 15,
                      )
                    ]
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
              )
            ),
          );
        },
      ),
    );
  }
}
