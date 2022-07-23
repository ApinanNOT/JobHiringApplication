// main.dart
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobhiring/assistants/assistant_methods.dart';
import 'package:jobhiring/assistants/geofire_assistant.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/main.dart';
import 'package:jobhiring/models/job_location.dart';
import 'package:jobhiring/states/contractor.dart';
import 'package:jobhiring/states/empaccepted.dart';
import 'package:jobhiring/states/empcancel.dart';
import 'package:jobhiring/states/emppoint.dart';
import 'package:jobhiring/states/select_job_nearest.dart';
import 'package:restart_app/restart_app.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../models/contractorRequestinformation.dart';
import '../splash_screen/splash_screen.dart';
import '../states/test.dart';
import '../states/test.dart';
import '../utility/my_constant.dart';
import '../utility/progress_dialog.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../widgets/show_image.dart';
import '../widgets/show_title.dart';
class Test  extends StatefulWidget {
  const Test ({Key? key}) : super(key: key);

  @override
  State<Test > createState() => _TestState ();
}

class _TestState  extends State<Test > {

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  bool jobLocationKeysLoaded = false;

  int i=0;

  StreamSubscription<DatabaseEvent>? statusContractorRequestInfoStreamSubscription;

  String contractorRequestStatus = "" ;

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();
  //double boxwaiting = 220;
  double waitingResponseFromEmployerContainerHeight = 0 ;

  //GoogleMap
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();
  GoogleMapController? newGoogleMapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  //GPS
  Position? userCurrentPosition;
  var geoLocator = Geolocator();

  LocationPermission? _locationPermission;

  checkIfLocationPermissionAllowed() async
  {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateUserPosition() async
  {

    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng latLngPosition =
    LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

    CameraPosition cameraPosition =
    CameraPosition(target: latLngPosition, zoom: 15);

    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    GeoFireAssistant.jobLocationList.clear();

    initializeGeoFireListener();
  }

  @override
  void initState()
  {
    super.initState();

    jobsearchinformation();
  }

  List<JobLocation> onlineJobList = [];

  DatabaseReference? referenceContractorRequest;

  jobsearchinformation()
  {

    referenceContractorRequest = FirebaseDatabase.instance.ref()
        .child("ContractorRequest").push();

    Map contractorInformation =
    {
      "User UID" : currentFirebaseUser!.uid,
      "id" : userModelCurrentInfo!.id,
      "name": userModelCurrentInfo!.name,
      "lastname": userModelCurrentInfo!.lastname,
      "gender": userModelCurrentInfo!.gender,
      "address": userModelCurrentInfo!.address,
      "phone": userModelCurrentInfo!.phone,
      "age": userModelCurrentInfo!.age,
      "requestId" : referenceContractorRequest!.key,
      "ratings" : userModelCurrentInfo!.ratings,
      "jobId" : "waiting",
    };

    referenceContractorRequest!.set(contractorInformation);

    statusContractorRequestInfoStreamSubscription = referenceContractorRequest!.onValue.listen((eventSnap)
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
          if((eventSnap.snapshot.value as Map)["jobId"] != null)
          {
            String assignedUsersId = (eventSnap.snapshot.value as Map)["jobId"].toString();
            Navigator.push(
              context, MaterialPageRoute(builder: (c) => EmpPoint(
              assignedUsersId: assignedUsersId,

            ),),);
          }
        }
      }
    });

    onlineJobList = GeoFireAssistant.jobLocationList;
    searchJobNearest();
  }

  searchJobNearest() async
  {
    if(onlineJobList.isEmpty)
    {

      referenceContractorRequest!.remove();

      Toast.show(
        "ไม่มีงานรอบตัวคุณ",
        context,
        duration: Toast.lengthLong,
        gravity: Toast.center,
        backgroundColor: Colors.red,
        textStyle: MyConstant().texttoast(),
      );

      return;
    }

    await retrieveOnlineJobInformation(onlineJobList);

    var response = await Navigator.push(context,MaterialPageRoute(
        builder: (c)=> SelectJobNearest(referenceContractorRequest: referenceContractorRequest)));

    if(response == "jobChoosed")
    {
      FirebaseDatabase.instance.ref()
          .child("Jobs")
          .child(chosenJobId!)
          .once()
          .then((snap)
      {
        if(snap.snapshot.value != null)
        {
          //send notification to that specific employer
          sendNotificationToEmployer(chosenJobId!);

          //Display Waiting Response form a Employer
          showWaitingResponseFromEmployerUI();

          //Response from Employer
          FirebaseDatabase.instance.ref()
              .child("Jobs")
              .child(chosenJobId!)
              .child("contractorId")
              .onValue.listen((eventSnapshot)
          {
            //1. Employer Cancel
            //contractorId : "idle"
            if(eventSnapshot.snapshot.value == "idle")
            {
              print("ผู้ว่าจ้างปฏิเสธ");
              //Navigator.pop(context);
              //SystemNavigator.pop();
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => const EmpCancel()));
            }
            //2. Employer Confirm
            //contractorId : "accepted"
            if(eventSnapshot.snapshot.value == "accepted")
            {
              showDialog(
                barrierDismissible: false, //no touch freespace for exits
                context: context,
                builder: (context) =>
                    Scaffold(
                      appBar: AppBar(
                        centerTitle: true,
                        title: Text(
                          'ผู้ว่าจ้างยอมรับคุณทำงาน',
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
                                'รอผู้ว่าจ้างยอมรับงาน',
                                style: MyConstant().logotext(),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                'ผู้ว่าจ้างจะยอมรับงานเมื่อคุณได้ทำงานสำเร็จ',
                                style: MyConstant().h3Style(),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              );
            }
          });
        }
        else
        {
          Toast.show(
            "เกิดข้อผิดพลาด กรุณาเลือกงานใหม่",
            context,
            duration: Toast.lengthLong,
            gravity: Toast.center,
            backgroundColor: Colors.red,
            textStyle: MyConstant().texttoast(),
          );
        }
      }
      );
    }
  }

  showWaitingResponseFromEmployerUI()
  {
    setState(()
    {
      waitingResponseFromEmployerContainerHeight = 220;
    });
  }

  sendNotificationToEmployer(String chosenJobId)
  {
    //assign contractorRequestId to Jobs
    FirebaseDatabase.instance.ref()
        .child("Jobs")
        .child(chosenJobId)
        .child("contractorId")
        .set(referenceContractorRequest!.key);

    //automate the push notification
    FirebaseDatabase.instance.ref()
        .child("Users")
        .child(chosenJobId)
        .child("token")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        String usersToken = snap.snapshot.value.toString();

        //send Notification Now
        AssistantMethods.sendNotificationToEmployerNow(
          usersToken,
          referenceContractorRequest!.key.toString(),
          context,
        );

        print("ส่งการแจ้งเตือนสำเร็จ");

      }
      else
      {
        Toast.show(
          "เกิดข้อผิดพลาด กรุณาเลือกงานใหม่",
          context,
          duration: Toast.lengthLong,
          gravity: Toast.center,
          backgroundColor: Colors.red,
          textStyle: MyConstant().texttoast(),
        );
        return;
      }
    });
  }

  retrieveOnlineJobInformation(List onlineNearestJobList) async
  {
    DatabaseReference ref = FirebaseDatabase.instance.ref().child("Jobs");

    for(i=0 ;i<onlineNearestJobList.length; i++)
    {
      await ref.child(onlineNearestJobList[i].jobId.toString())
          .once()
          .then((dataSnapshot)
      {
        var jobKeyInfo = dataSnapshot.snapshot.value;
        jList.add(jobKeyInfo);
        print(jobKeyInfo);
      });
    }
  }

  bool searchState = false;

  @override
  Widget build(BuildContext context)
  {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: const Text('งาน'),
    );
  }

  initializeGeoFireListener()
  {

    Geofire.initialize("JobLocation");

    Geofire.queryAtLocation(
        userCurrentPosition!.latitude, userCurrentPosition!.longitude,10)!
        .listen((map) {
      print(map);
      if (map != null) {
        var callBack = map["callBack"];

        //latitude will be retrieved from map['latitude']
        //longitude will be retrieved from map['longitude']

        switch (callBack) {
          case Geofire.onKeyEntered:
            JobLocation jobLocation = JobLocation();
            jobLocation.locationLatitude = map['latitude'];
            jobLocation.locationLongitude = map['longitude'];
            jobLocation.jobId = map['key'];
            GeoFireAssistant.jobLocationList.add(jobLocation);
            if (jobLocationKeysLoaded == true) {
              showJoblocation();
            }
            break;

          case Geofire.onKeyExited:
            GeoFireAssistant.deleteJobLocationFromList(map['key']);
            showJoblocation();
            break;

          case Geofire.onKeyMoved:
            JobLocation jobLocation = JobLocation();
            jobLocation.locationLatitude = map['latitude'];
            jobLocation.locationLongitude = map['longitude'];
            jobLocation.jobId = map['key'];
            GeoFireAssistant.updateJobLocation(jobLocation);
            showJoblocation();
            break;

          case Geofire.onGeoQueryReady:
            jobLocationKeysLoaded = true;
            showJoblocation();
            break;
        }
      }

      setState(() {
      });
    });
  }

  showJoblocation()
  {
    setState(() async{
      markersSet.clear();
      circlesSet.clear();

      Set<Marker> jobMarkerSet = Set<Marker>();

      for(JobLocation eachJob in GeoFireAssistant.jobLocationList)
      {
        LatLng eachJobLocationPosition = LatLng(eachJob.locationLatitude!, eachJob.locationLongitude!);

        Marker marker = Marker(
          markerId: MarkerId(eachJob.jobId!),
          position: eachJobLocationPosition,
          //icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          icon: await BitmapDescriptor.fromAssetImage(const ImageConfiguration(), 'images/location.png'),
          rotation: 360,
        );

        jobMarkerSet.add(marker);
      }
      setState(() {
        markersSet = jobMarkerSet;
      });
    });
  }
}
