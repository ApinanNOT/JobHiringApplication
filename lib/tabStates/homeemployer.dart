import 'dart:async';
import 'dart:ffi';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_launcher_icons/ios.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobhiring/assistants/geofire_assistant.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/models/job_location.dart';
import 'package:jobhiring/push_notifications/push_notification_system.dart';

import '../utility/my_constant.dart';
import '../utility/progress_dialog.dart';

class HomeTabEmployer extends StatefulWidget {
  const HomeTabEmployer({Key? key}) : super(key: key);

  @override
  State<HomeTabEmployer> createState() => _HomeTabEmployerState();
}

class _HomeTabEmployerState extends State<HomeTabEmployer>
{

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  bool jobLocationKeysLoaded = false;

  GlobalKey<ScaffoldState> sKey = GlobalKey<ScaffoldState>();

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

    initializeGeoFireListener();
  }

  readCurrentContractorInformation() async
  {
    currentFirebaseUser = fAuth.currentUser;

    FirebaseDatabase.instance.ref()
        .child("Jobs")
        .child(currentFirebaseUser!.uid)
        .once()
        .then((snap)
    {
      if(snap.snapshot.value != null)
        {
          jobData.id = (snap.snapshot.value as Map)["jobId"];
          jobData.address = (snap.snapshot.value as Map)["address"];
          jobData.age = (snap.snapshot.value as Map)["age"];
          jobData.date = (snap.snapshot.value as Map)["date"];
          jobData.detail = (snap.snapshot.value as Map)["detail"];
          jobData.gender = (snap.snapshot.value as Map)["gender"];
          jobData.money = (snap.snapshot.value as Map)["money"];
          jobData.name = (snap.snapshot.value as Map)["name"];
          jobData.phone = (snap.snapshot.value as Map)["phone"];
          jobData.safe = (snap.snapshot.value as Map)["safe"];
          jobData.time = (snap.snapshot.value as Map)["time"];

          print("*************************************");
          print(jobData.id);
          print(jobData.address);
          print(jobData.age);
          print(jobData.date);
          print(jobData.detail);
          print(jobData.gender);
          print(jobData.money);
          print(jobData.name);
          print(jobData.phone);
          print(jobData.safe);
          print(jobData.time);
        }
    });
    
    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
    pushNotificationSystem.initializeCloudMessaging(context);
    pushNotificationSystem.generateAndGetToken();
  }

  @override
  void initState()
  {

    super.initState();

    checkIfLocationPermissionAllowed(); //check permission
    readCurrentContractorInformation();
  }

  @override
  Widget build(BuildContext context)
  {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      key: sKey,
      //GoogleMap
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: true,
            markers: markersSet,
            circles: circlesSet,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              locateUserPosition(); //Call GPS
            },
          ),
          //ButtonSearch(size)
        ],
      ),
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
            showJoblocation();
            break;
        }
      }

      setState(() {});
    });
  }

  showJoblocation()
  {

    // final Uint8List customMarker= await getBytesFromAsset(
    //     path: 'images/location.png' , //paste the custom image path
    //     width: 130 // size of custom image as marker
    // );

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
          //icon: BitmapDescriptor.fromBytes(customMarker),
          icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'images/location.png'),
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

