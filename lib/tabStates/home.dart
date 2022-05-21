import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobhiring/global/global.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

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
  }

  List<Marker> jobMarker = [];

  @override
  void initState() {
    super.initState();
    intilize();
    checkIfLocationPermissionAllowed(); //check permission
  }

  intilize(){
    Marker one = const Marker(
        markerId: MarkerId("1"),
        position: LatLng(18.2888,99.4909),
        infoWindow: InfoWindow(
          title: "ลำปาง",
          snippet: "ประเทศไทย",
        ),
    );
    Marker two = const Marker(
      markerId: MarkerId("1"),
      position: LatLng(18.3,99.51),
      infoWindow: InfoWindow(
        title: "เชียงใหม่",
        snippet: "ประเทศไทย",
      ),
    );
    Marker three = const Marker(
      markerId: MarkerId("1"),
      position: LatLng(18.2889,99.500),
      infoWindow: InfoWindow(
        title: "พะเยา",
        snippet: "ประเทศไทย",
      ),
    );

    jobMarker.add(one);
    jobMarker.add(two);
    jobMarker.add(three);
    setState((){

    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //GoogleMap
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            mapToolbarEnabled: false,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            //markers: Set<Marker>.of(jobMarker),
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              locateUserPosition(); //Call GPS
            },
            markers: jobMarker.map((e)=>e).toSet(),
          ),
        ],
      ),
    );
  }
}
