import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';

import '../global/global.dart';
import '../models/contractorRequestinformation.dart';
import 'authen.dart';

class ContPoint extends StatefulWidget {
  //const EmpPoint({Key? key}) : super(key: key);
  String? assignedContId;

  ContPoint({
    this.assignedContId
  });

  @override
  State<ContPoint> createState() => _ContPointState();
}

class _ContPointState extends State<ContPoint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstant.primary,
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
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 22.0),
              Text(
                "คะแนนผู้รับจ้าง" , style: MyConstant().h1Style(),
              ),
              const SizedBox(height: 22.0,),

              const Divider(height: 4.0,thickness: 4.0),

              const SizedBox(height: 22.0,),

              SmoothStarRating(
                rating: countRatingStars,
                allowHalfRating: false,
                starCount: 5,
                size: 46,
                color: Colors.yellow,
                borderColor: Colors.yellow,
                onRatingChanged: (valueOfStarsChoosed)
                {
                  countRatingStars = valueOfStarsChoosed;

                  if(countRatingStars == 1)
                  {
                    setState((){
                      titleStarsRating = "ปรับปรุง";
                    });
                  }
                  if(countRatingStars == 2)
                  {
                    setState((){
                      titleStarsRating = "พอใช้";
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
                      titleStarsRating = "ดีมาก";
                    });
                  }
                  if(countRatingStars == 5)
                  {
                    setState((){
                      titleStarsRating = "ดีเยี่ยม";
                    });
                  }
                },
              ),

              const SizedBox(height: 15.0),

              Text(
                titleStarsRating, style: MyConstant().jobmoney(),
              ),

              const SizedBox(height: 15.0,),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: MyConstant.confirm,
                  padding: const EdgeInsets.symmetric(horizontal: 38),
                ),
                onPressed: ()
                {
                  DatabaseReference rateContractorRef = FirebaseDatabase.instance.ref()
                      .child("Users")
                      .child(widget.assignedContId!)
                      .child("ratings");

                  rateContractorRef.once().then((snap)
                  {
                    if(snap.snapshot.value == null)
                    {
                      rateContractorRef.set(countRatingStars.toString());

                      fAuth.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const Authen(),
                        ),
                      );
                    }
                    else
                    {

                      double pastRatings = double.parse(snap.snapshot.value.toString());
                      double newAvgRatings = (pastRatings + countRatingStars) / 2;
                      rateContractorRef.set(newAvgRatings.toString());

                      fAuth.signOut();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const Authen(),
                        ),
                      );
                    }
                  });
                },
                child: Text(
                  "ยืนยัน" , style: MyConstant().textbutton3(),
                ),
              ),

              const SizedBox(height: 18.0),
            ],
          ),
        ),
      ),
    );
  }
}
