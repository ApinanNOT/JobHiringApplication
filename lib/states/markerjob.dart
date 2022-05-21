import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/states/employered.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../utility/my_constant.dart';
import '../widgets/show_image.dart';
import '../widgets/show_title.dart';

class MarkerJob extends StatefulWidget {
  const MarkerJob({Key? key}) : super(key: key);

  @override
  State<MarkerJob> createState() => _MarkerJobState();
}

class _MarkerJobState extends State<MarkerJob> {

  final formKey = GlobalKey<FormState>(); //create variable
  List<Marker> myMarker = [];

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
    CameraPosition(target: latLngPosition, zoom: 18);

    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  saveCurrentLocation(){
    Map joblocationmap = {
      "latitude" : userCurrentPosition!.latitude,
      "longitude" : userCurrentPosition!.longitude,
    };
    DatabaseReference jobRef = FirebaseDatabase.instance.ref().child("Jobs");
    jobRef.child(currentFirebaseUser!.uid).child("location").set(joblocationmap);

    Toast.show(
      "บันทึกงานสำเร็จ",
      context,
      duration: Toast.lengthLong,
      gravity: Toast.center,
      backgroundColor: Colors.green,
      textStyle: MyConstant().texttoast(),
    );
  }

  @override
  void initState() {
    super.initState();

    checkIfLocationPermissionAllowed();

    Timer.run(() {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: ListTile(
            leading: ShowImage(path: MyConstant.imagelogo),
            title: ShowTitle(
                title: "สถานที่ทำงาน",
                textStyle: MyConstant().h2Style()),
            subtitle: ShowTitle(
                title: "ท่านต้องการปักหมุดสถานที่ทำงานหรือไม่ ถ้าไม่ระบบจะอิงตำแหน่งปัจจุบันของท่านเป็นสถานที่ทำงาน",
                textStyle: MyConstant().textdialog2()),
          ),
          actions: [
            TextButton(
              onPressed: () {
                saveCurrentLocation();
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => const Employered()));
              },
              child: Text(
                'ไม่ต้องการ',
                style: MyConstant().cancelbutton(),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'ต้องการ',
                style: MyConstant().confirmbutton(),
              ),
            ),
          ],
        ),
      );
    });
  }

  Future<dynamic> showDialogPost() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: ListTile(
          leading: ShowImage(path: MyConstant.imagelogo),
          title: ShowTitle(
              title: "ยืนยันสถานที่ทำงาน",
              textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(
              title: "โปรดตรวจสถานทีทำงานให้ถูกต้องก่อนการยืนยันข้อมูล",
              textStyle: MyConstant().textdialog2()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'ยกเลิก',
              style: MyConstant().cancelbutton(),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => const Employered()));
              Toast.show(
                "บันทึกงานสำเร็จ",
                context,
                duration: Toast.lengthLong,
                gravity: Toast.center,
                backgroundColor: Colors.green,
                textStyle: MyConstant().texttoast(),
              );
            },
            child: Text(
              'ยืนยัน',
              style: MyConstant().confirmbutton(),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> showDialogCancel() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: ListTile(
          leading: ShowImage(path: MyConstant.imagelogo),
          title: ShowTitle(
              title: "ใช้ตำแหน่งปัจจุบัน",
              textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(
              title: "ท่านต้องการใช้ตำแหน่งปัจจุบันเป็นสถานที่ทำงาน",
              textStyle: MyConstant().textdialog2()),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'ยกเลิก',
              style: MyConstant().cancelbutton(),
            ),
          ),
          TextButton(
            onPressed: () {
              saveCurrentLocation();
              Navigator.push(
                  context, MaterialPageRoute(builder: (c) => const Employered()));
              Toast.show(
                "บันทึกงานสำเร็จ",
                context,
                duration: Toast.lengthLong,
                gravity: Toast.center,
                backgroundColor: Colors.green,
                textStyle: MyConstant().texttoast(),
              );
            },
            child: Text(
              'ยืนยัน',
              style: MyConstant().confirmbutton(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'ตำแหน่งสถานที่ทำงาน',
          style: MyConstant().headbar(),
        ),
        backgroundColor: MyConstant.primary,
      ),
      //GoogleMap
      body: Stack(
        children: [
          GoogleMapAndMarker(),
          ButtonConfirmMarker(size),
          ButtonCancelMarker(size)
        ],
      ),
    );
  }

  GoogleMap GoogleMapAndMarker() {

    return GoogleMap(
      mapType: MapType.normal,
      myLocationButtonEnabled: true,
      mapToolbarEnabled: false,
      markers: Set.from(myMarker),
      onTap: _handleTap,
      myLocationEnabled: true,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: true,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controllerGoogleMap.complete(controller);
        newGoogleMapController = controller;

        locateUserPosition(); //Call GPS
      },
    );
  }

  _handleTap(LatLng tappedPoint){
    setState(() {
      myMarker = [];
      myMarker.add(
          Marker(
            markerId: MarkerId(currentFirebaseUser!.uid),
            position: LatLng(tappedPoint.latitude,tappedPoint.longitude),
            draggable: true,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          )
      );

      Map joblocationmap = {
        "latitude" : tappedPoint.latitude,
        "longitude" : tappedPoint.longitude,
      };
      DatabaseReference jobRef = FirebaseDatabase.instance.ref().child("Jobs");
      jobRef.child(currentFirebaseUser!.uid).child("location").set(joblocationmap);

      //tappedPoint;
    });
  }

  Positioned ButtonConfirmMarker(double size) {
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
                if(myMarker.isNotEmpty){
                  showDialogPost();
                }else{
                  Toast.show(
                    "กรุณาปักหมุดสถานที่ทำงาน",
                    context,
                    duration: Toast.lengthLong,
                    gravity: Toast.center,
                    backgroundColor: Colors.red,
                    textStyle: MyConstant().texttoast(),
                  );
                }
              },
              child: Text(
                'ยืนยันตำแหน่ง',
                style: MyConstant().textbutton3(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Positioned ButtonCancelMarker(double size) {
    return Positioned(
      bottom: 570,
      left: 0,
      right: 280,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 40),
            width: size * 0.2,
            child: ElevatedButton(
              style: MyConstant().myButtonStyle5(),
              onPressed: () {
                showDialogCancel();
              },
              child: Text(
                'ยกเลิก',
                style: MyConstant().textbutton4(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
