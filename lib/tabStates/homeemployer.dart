import 'dart:async';
import 'dart:ffi';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:ui' as ui;
import 'dart:typed_data';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobhiring/assistants/geofire_assistant.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/models/job_location.dart';

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

  // //customMarker
  // Future<Uint8List> getBytesFromAsset({required String path,required int width})async {
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(
  //       data.buffer.asUint8List(),
  //       targetWidth: width
  //   );
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   return (await fi.image.toByteData(
  //       format: ui.ImageByteFormat.png))!
  //       .buffer.asUint8List();
  // }

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

  @override
  void initState()
  {

    super.initState();

    checkIfLocationPermissionAllowed(); //check permission
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

  Positioned ButtonSearch(double size)
  {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            width: size * 0.5,
            child: ElevatedButton(
              style: MyConstant().myButtonStyle4(),
              onPressed: () {
                //searchjob();
              },
              child: Text(
                'ค้นหางานรอบตัว',
                style: MyConstant().textbutton3(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

