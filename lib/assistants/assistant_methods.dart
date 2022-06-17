import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:jobhiring/global/global.dart';
import '../models/user_model.dart';

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

}