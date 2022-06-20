import 'dart:convert';
//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jobhiring/global/global.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class AssistantMethods{
  static void readCurrentOnlineUserInfo() async{
    currentFirebaseUser = fAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("Users")
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap)
    {
      if(snap.snapshot.value != null)
        {
          userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
        }
    });
  }

  static void sendNotificationToEmployerNow(String usersToken , String contractorRequestId , context) async
  {

    Map<String, String> headerNotification =
    {
      'Content-Type': 'application/json',
      'Authorization': cloudMessagingServerToken,
    };

    Map bodyNotification =
    {
      "body": "มีคนสนใจงานของคุณ",
      "title": "Jobhiring" ,
    };

    Map dataMap =
    {
      "click_action" : "FLUTTER_NOTIFICATION_CLICK",
      "id" : "1",
      "status" : "done",
      "ContractorRequestId" : contractorRequestId,
    };

    Map officialNotificationFormat =
    {
      "notification" : bodyNotification,
      "data" : dataMap,
      "priority" : "high",
      "to" : usersToken,
    };

    var responseNotification = http.post(
      Uri.parse("https://fcm.googleapis.com/fcm/send"),
      headers: headerNotification,
      body: jsonEncode(officialNotificationFormat),
    );

  }

}