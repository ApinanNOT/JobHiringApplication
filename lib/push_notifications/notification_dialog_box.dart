import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/models/contractorRequestinformation.dart';
import 'package:jobhiring/states/job_wait.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:tbib_toast/tbib_toast.dart';


class NotificationDialogBox extends StatefulWidget
{

  ContractorRequestInformation? contractorRequestDetails;

  NotificationDialogBox({this.contractorRequestDetails});


  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context)
  {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      //backgroundColor: Colors.,
      elevation: 10,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 14),

              Image.asset("images/logo.png",
              width: 100,
              ),

              const SizedBox(height: 2),

              Text(
                "รายละเอียดผู้สนใจงาน", style: MyConstant().h2Style(),
              ),

              const SizedBox(height: 15.0),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "ชื่อ : " + widget.contractorRequestDetails!.name! + " " + widget.contractorRequestDetails!.lastname!,
                              style: MyConstant().userinfo5(),
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
                              "ที่อยู่ : " + widget.contractorRequestDetails!.address!,
                              style: MyConstant().userinfo5(),
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
                              "เพศ : " + widget.contractorRequestDetails!.gender!,
                              style: MyConstant().userinfo5(),
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
                              "เบอร์โทร : " + widget.contractorRequestDetails!.phone!,
                              style: MyConstant().userinfo5(),
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
                              "อายุ : " + widget.contractorRequestDetails!.age!,
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 18.0),

                    //คะแนนการทำงานเฉลี่ย
                    SmoothStarRating(
                      rating: 3.5,
                      color: Colors.yellow,
                      borderColor: Colors.grey[600],
                      allowHalfRating: true,
                      starCount: 5,
                      size: 20,
                    ),
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
                          //cancel
                          FirebaseDatabase.instance.ref()
                              .child("ContractorRequest")
                              .child(widget.contractorRequestDetails!.requestId!)
                              .remove().then((value)
                          {
                            FirebaseDatabase.instance.ref()
                                .child("Jobs")
                                .child(currentFirebaseUser!.uid)
                                .child("contractorId")
                                .set("idle");
                          }).then((value)
                          {
                            FirebaseDatabase.instance.ref()
                                .child("Users")
                                .child(currentFirebaseUser!.uid)
                                .child("history")
                                .child(widget.contractorRequestDetails!.requestId!)
                                .remove();
                          }).then((value)
                          {
                            Toast.show(
                              "ผู้ว่าจ้างปฏิเสธ",
                              context,
                              duration: Toast.lengthLong,
                              gravity: Toast.center,
                              backgroundColor: Colors.red,
                              textStyle: MyConstant().texttoast(),
                            );
                          });

                          Navigator.pop(context);
                          //SystemNavigator.pop();

                          print("Cancel");

                        },
                        child: Text(
                          "ยกเลิก".toUpperCase(),
                          style: MyConstant().textnotificationRequest(),
                        )
                    ),

                    const SizedBox(width: 25.0),

                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: MyConstant.confirm,
                        ),
                        onPressed: ()
                        {
                          acceptContractorRequest(context);

                          Navigator.push(
                              context, MaterialPageRoute(builder: (c) => JobWait()));
                        },
                        child: Text(
                          "ยอมรับ".toUpperCase(),
                          style: MyConstant().textnotificationRequest(),
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }

  acceptContractorRequest(BuildContext context)
  {
    String getContractorId = "";
    FirebaseDatabase.instance.ref()
        .child("Jobs")
        .child(currentFirebaseUser!.uid)
        .child("contractorId")
        .once()
        .then((snap)
    {
      if(snap.snapshot.value != null)
      {
        getContractorId = snap.snapshot.value.toString();
        print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
        print(getContractorId);
      }
      else
        {

        }

      print(widget.contractorRequestDetails!.requestId.toString());

      print("BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB");
      print(getContractorId);
      if(getContractorId ==  widget.contractorRequestDetails!.requestId)
      {
        FirebaseDatabase.instance.ref()
            .child("Jobs")
            .child(currentFirebaseUser!.uid)
            .child("contractorId")
            .set("accepted");

        Navigator.push(context, MaterialPageRoute(builder: (c) => JobWait
          (contractorRequestDetails: widget.contractorRequestDetails,

        )));
      }
      else
        {

        }
    });
  }

}
