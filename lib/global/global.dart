import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobhiring/models/job_data.dart';
import '../models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List jList = []; //jobKeyList
String? chosenJobId = "";
JobData jobData = JobData();