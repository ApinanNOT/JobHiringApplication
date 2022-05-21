import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobhiring/global/global.dart';

class MarkerJob extends StatefulWidget {
  const MarkerJob({Key? key}) : super(key: key);

  @override
  State<MarkerJob> createState() => _MarkerJobState();
}

class _MarkerJobState extends State<MarkerJob> {

  List<Marker> markers = [];
  int id = 1; //id marker

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

  @override
  void initState() {
    super.initState();

    checkIfLocationPermissionAllowed();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //GoogleMap
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            //marker when tap
            onTap: (LatLng latLng){
              Marker newMarker = Marker(
                markerId: MarkerId('$id'),
                position: LatLng(latLng.latitude,latLng.longitude),
                infoWindow: InfoWindow(title: "ชื่องาน"),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueRed,
                ),
              );
              markers.add(newMarker);
              setState((){
                id = id + 1;
              });
            },
            //finish marker when tap
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;

              locateUserPosition(); //Call GPS
            },
            //marker on tap
            markers: markers.map((e) => e).toSet(),
          ),
        ],
      ),
    );
  }
}
