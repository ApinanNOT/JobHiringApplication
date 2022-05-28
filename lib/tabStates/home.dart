import 'dart:async';
import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobhiring/assistants/geofire_assistant.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/models/job_location.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  Set<Marker> markersSet = {};
  Set<Circle> circlesSet = {};
  bool jobLocationKeysLoaded = false;
  BitmapDescriptor? joblocationIcon;

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

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateUserPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    userCurrentPosition = cPosition;

    LatLng latLngPosition =
        LatLng(userCurrentPosition!.latitude, userCurrentPosition!.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);

    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    initializeGeoFireListener();
  }

  @override
  void initState()
  {
    super.initState();

    checkIfLocationPermissionAllowed(); //check permission
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: sKey,
      //GoogleMap
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            //markers: getMarker(),
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
        ],
      ),
    );
  }

  initializeGeoFireListener() {
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
      setState((){
      markersSet.clear();
      circlesSet.clear();

      Set<Marker> jobMarkerSet = Set<Marker>();

      for(JobLocation eachJob in GeoFireAssistant.jobLocationList)
      {
        LatLng eachJobLocationPosition = LatLng(eachJob.locationLatitude!, eachJob.locationLongitude!);

        Marker marker = Marker(
          markerId: MarkerId(eachJob.jobId!),
          position: eachJobLocationPosition,
          icon: BitmapDescriptor.defaultMarker,
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

