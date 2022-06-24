import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/models/job_data.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/states/contpoint.dart';
import 'package:jobhiring/states/emppoint.dart';
import 'package:jobhiring/states/mode.dart';
import 'package:jobhiring/utility/my_constant.dart';

import '../assistants/assistant_methods.dart';
import '../models/contractorRequestinformation.dart';
import '../utility/progress_dialog.dart';
import '../widgets/show_image.dart';

class JobWait extends StatefulWidget {

  //const JobWait({Key? key}) : super(key: key);

  ContractorRequestInformation? contractorRequestDetails;

  JobWait({
    this.contractorRequestDetails,
  });

  @override
  _JobWaitState createState() => _JobWaitState();
}

class _JobWaitState extends State<JobWait> {

  @override
  void initState() {
    super.initState();
    saveAssignedJobDetailtoContractorRequest();
  }

  @override
  Widget build(BuildContext context)
  {
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
                  //Finish Job
                  //push to point
                  endJob();
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

  saveAssignedJobDetailtoContractorRequest()
  {
    DatabaseReference databaseReference = FirebaseDatabase.instance.ref()
        .child("ContractorRequest")
        .child(widget.contractorRequestDetails!.requestId!);
    
    databaseReference.child("status").set("accepted");
    databaseReference.child("jobId").set(jobData.id);
    databaseReference.child("jobName").set(jobData.name);
    databaseReference.child("jobAddress").set(jobData.address);
    databaseReference.child("jobAge").set(jobData.age);
    databaseReference.child("jobDate").set(jobData.date);
    databaseReference.child("jobGender").set(jobData.gender);
    databaseReference.child("jobMoney").set(jobData.money);
    databaseReference.child("jobPhone").set(jobData.phone);
    databaseReference.child("jobSafe").set(jobData.safe);
    databaseReference.child("jobTime").set(jobData.time);

    saveHistory();
  }

  saveHistory()
  {
    DatabaseReference historyRef = FirebaseDatabase.instance.ref()
        .child("Users")
        .child(currentFirebaseUser!.uid)
        .child("history");
    
    historyRef.child(widget.contractorRequestDetails!.requestId!).set(true);
  }

  endJob() async
  {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "กรุณารอสักครู่"
        );
      },
    );

    //fare amount

    await FirebaseDatabase.instance.ref()
        .child("ContractorRequest")
        .child(widget.contractorRequestDetails!.requestId!)
        .child("status")
        .set("JobEnd");

    toContPoint();
  }

  StreamSubscription<DatabaseEvent>? statusContractorRequestInfoStreamSubscription;

  String contractorRequestStatus = "" ;

  toContPoint()
  {

    //save point to Contractor
    DatabaseReference referenceContractorRequest = FirebaseDatabase.instance.ref()
        .child("ContractorRequest")
        .child(widget.contractorRequestDetails!.requestId!);

    statusContractorRequestInfoStreamSubscription = referenceContractorRequest.onValue.listen((eventSnap)
    {
      if(eventSnap.snapshot.value == null)
      {
        return;
      }
      if((eventSnap.snapshot.value as Map)["status"] != null)
      {
        contractorRequestStatus = (eventSnap.snapshot.value as Map)["status"].toString();
        if(contractorRequestStatus == "JobEnd")
        {
          if((eventSnap.snapshot.value as Map)["User UID"] != null)
          {
            String assignedContId = (eventSnap.snapshot.value as Map)["User UID"].toString();

            DatabaseReference historyyRef = FirebaseDatabase.instance.ref()
                .child("Users")
                .child(assignedContId)
                .child("history");
            historyyRef.child(widget.contractorRequestDetails!.requestId!).set(true);

            Navigator.push(
                context, MaterialPageRoute(builder: (c) => ContPoint(
              assignedContId: assignedContId,
            )));
          }
        }
      }
    });
  }
}
