import 'package:firebase_auth/firebase_auth.dart';

import '../models/job_model.dart';
import '../models/user_model.dart';

final FirebaseAuth fAuth = FirebaseAuth.instance;
User? currentFirebaseUser;
UserModel? userModelCurrentInfo;
JobModel? jobModelCurrentInfo;
List jList = []; //jobKeyList
