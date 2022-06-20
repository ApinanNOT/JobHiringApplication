import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobhiring/models/job_data.dart';
import '../models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
List jList = []; //jobKeyList
String? chosenJobId = "";
JobData jobData = JobData();
String cloudMessagingServerToken = "key=AAAAxMX3mhI:APA91bHk9C0vWQm93XL_ZahY0i_vp-k4FqCFv3DxMmW0vGXbGBnS2gmxKa2ffaYPxnxFQ9-72QRfbqhbAydo_MFnNE8JNOchI_ZshF26AHlqHSt9-0A-JRARfeZDtpUExLs9DeEoAS7E";
double countRatingStars = 0.0;
String titleStarsRating = "";