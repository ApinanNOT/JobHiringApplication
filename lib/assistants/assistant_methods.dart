import 'dart:convert';
//import 'dart:js';
import 'package:firebase_database/firebase_database.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/infoHandler/app_info.dart';
import 'package:jobhiring/models/trips_history_model.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

class AssistantMethods{
  static void readCurrentOnlineUserInfo() async
  {
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

  //retrieve the trips Keys for online user
  //trip key = ride request key
  static void readTripsKeysForOnlineUser(context)
  {
    FirebaseDatabase.instance.ref()
        .child("ContractorRequest")
        .orderByChild("age")
        .equalTo(userModelCurrentInfo!.age)
        .once()
        .then((snap)
    {
      if(snap.snapshot.value != null)
      {
        Map keysTripsId =  snap.snapshot.value as Map;
        int overAllTripsCounter = keysTripsId.length;

        Provider.of<AppInfo>(context, listen: false).updateOverAllTripsCounter(overAllTripsCounter);

        List<String> tripsKeysList = [];
        keysTripsId.forEach((key, value)
        {
          tripsKeysList.add(key);
        });

        Provider.of<AppInfo>(context, listen: false).updateOverAllTripsKeys(tripsKeysList);

        //get trips keys data - read trips complete information
        readTripsHistoryInformation(context);

      }
    });
  }

  static void readTripsHistoryInformation(context)
  {
    var tripsAllKeys = Provider.of<AppInfo>(context, listen: false).historyTripsKeysList;

    for(String eachKey in tripsAllKeys)
    {
      FirebaseDatabase.instance.ref()
          .child("ContractorRequest")
          .child(eachKey)
          .once()
          .then((snap)
      {
        var eachTripHistory = TripsHistoryModel.fromSnapshort(snap.snapshot);

        //update OverAllTrips History Data
        Provider.of<AppInfo>(context, listen: false).updateOverAllTripsHistoryInformation(eachTripHistory);
      });
    }
  }
}