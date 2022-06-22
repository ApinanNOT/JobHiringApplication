import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../global/global.dart';

class ContPoint extends StatefulWidget {
  //const EmpPoint({Key? key}) : super(key: key);
  String? assignedUsersId;

  ContPoint({this.assignedUsersId});

  @override
  State<ContPoint> createState() => _ContPointState();
}

class _ContPointState extends State<ContPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "คะแนนผู้รับจ้าง"
              ),
              const SizedBox(height: 22.0,),

              const Divider(height: 4.0,thickness: 4.0),

              const SizedBox(height: 22.0,),

              SmoothStarRating(
                rating: countRatingStars,
                allowHalfRating: false,
                starCount: 5,
                size: 46,
                onRatingChanged: (valueOfStarsChoosed)
                {
                  countRatingStars = valueOfStarsChoosed;

                  if(countRatingStars == 1)
                  {
                    setState((){
                      titleStarsRating = "แย่";
                    });
                  }
                  if(countRatingStars == 2)
                  {
                    setState((){
                      titleStarsRating = "ค่อนข้างแย่";
                    });
                  }
                  if(countRatingStars == 3)
                  {
                    setState((){
                      titleStarsRating = "ดี";
                    });
                  }
                  if(countRatingStars == 4)
                  {
                    setState((){
                      titleStarsRating = "ค่อนข้างดีมาก";
                    });
                  }
                  if(countRatingStars == 5)
                  {
                    setState((){
                      titleStarsRating = "ดีมาก";
                    });
                  }
                },
              ),

              Text(
                titleStarsRating,
              ),

              const SizedBox(height: 18.0,),

              ElevatedButton(
                onPressed: ()
                {
                  // DatabaseReference rateEmployerRef = FirebaseDatabase.instance.ref()
                  //     .child("Users")
                  //     .child(widget.assignedEmpId!)
                  //     .child("ratings");
                  //
                  // rateEmployerRef.once().then((snap)
                  //     {
                  //       if(snap.snapshot.value == null)
                  //         {
                  //           rateEmployerRef.set(countRatingStars.toString());
                  //
                  //           SystemNavigator.pop();
                  //         }
                  //       else
                  //       {
                  //         double pastRatings = double.parse(snap.snapshot.value.toString());
                  //         double newAvgRatings = (pastRatings + countRatingStars) / 2;
                  //         rateEmployerRef.set(newAvgRatings.toString());
                  //       }
                  //     });
                },
                child: Text(
                    "ยืนยัน"
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
