
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:jobhiring/models/contractorRequestinformation.dart';
import 'package:jobhiring/push_notifications/notification_dialog_box.dart';

import '../global/global.dart';
import '../utility/my_constant.dart';

class PushNotificationSystem
{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async
  {
    //1. Terminated
    //When the app is completely closed and opened directly from the push notification

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage)
    {
      if(remoteMessage != null)
      {
        //display contractor request information - user information who request a job
        readContractorRequestInformation(remoteMessage.data["ContractorRequestId"], context);
        print("This is Remote Message :: ");
        print(remoteMessage.data);
      }
    });


    //2. Foreground
    //When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage)
    {
      //display contractor request information - user information who request a job
      readContractorRequestInformation(remoteMessage!.data["ContractorRequestId"], context);
      print("This is Remote Message :: ");
      print(remoteMessage.data);
    });
    
    
    //3. Background
    //When the app is in the background and opened directly form the push notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage)
    {
      readContractorRequestInformation(remoteMessage!.data["ContractorRequestId"], context);
      print("This is Remote Message :: ");
      print(remoteMessage.data);
    });
  }

  readContractorRequestInformation(String contractorRequestId , BuildContext context)
  {
    FirebaseDatabase.instance.ref()
        .child("ContractorRequest")
        .child(contractorRequestId)
        .once()
        .then((snapData)
    {
      if(snapData.snapshot.value != null)
      {
        String id  = (snapData.snapshot.value! as Map)["id"];
        String name = (snapData.snapshot.value! as Map)["name"];
        String lastname = (snapData.snapshot.value! as Map)["lastname"];
        String gender = (snapData.snapshot.value! as Map)["gender"];
        String address = (snapData.snapshot.value! as Map)["address"];
        String phone = (snapData.snapshot.value! as Map)["phone"];
        String age = (snapData.snapshot.value! as Map)["age"];
        String ratings = (snapData.snapshot.value! as Map)["ratings"];
        //String jobId = (snapData.snapshot.value ! as Map)["jobId"];

        //String? requestId = snapData.snapshot.key;
        //String? jobId = snapData.snapshot.key;
        String? requestId = snapData.snapshot.key;

        ContractorRequestInformation contractorRequestDetails = ContractorRequestInformation();
        contractorRequestDetails.id = id;
        contractorRequestDetails.name = name;
        contractorRequestDetails.lastname = lastname;
        contractorRequestDetails.gender = gender;
        contractorRequestDetails.address = address;
        contractorRequestDetails.phone = phone;
        contractorRequestDetails.age = age;
        contractorRequestDetails.ratings = ratings;
        //contractorRequestDetails.jobId = jobId;
        //contractorRequestDetails.requestId = requestId;

        contractorRequestDetails.requestId = requestId;

        print("This is contractor request information :: ");
        print(contractorRequestDetails.id);
        print(contractorRequestDetails.name);
        print(contractorRequestDetails.lastname);
        print(contractorRequestDetails.gender);
        print(contractorRequestDetails.address);
        print(contractorRequestDetails.phone);
        print(contractorRequestDetails.age);
        print(contractorRequestDetails.requestId);
        print(contractorRequestDetails.ratings);

        showDialog(
            context: context,
            builder: (BuildContext context) => NotificationDialogBox(
                contractorRequestDetails: contractorRequestDetails,
            ),
        );

      }
      else
      {
        //else condition
      }
    });
  }

  Future generateAndGetToken() async
  {
    String? registrationToken = await messaging.getToken();
    print("FCM Registration Token : ");
    print(registrationToken);

    //save to database
    FirebaseDatabase.instance.ref()
        .child("Users")
        .child(currentFirebaseUser!.uid)
        .child("token")
        .set(registrationToken);

    messaging.subscribeToTopic("allEmployer");
    messaging.subscribeToTopic("allContractor");
  }
}
