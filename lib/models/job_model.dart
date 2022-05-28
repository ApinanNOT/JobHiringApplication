import 'dart:ffi';

import 'package:firebase_database/firebase_database.dart';

class JobModel
{
  String? address;
  String? age;
  String? date;
  String? detail;
  String? gender;
  String? money;
  String? name;
  String? safe;
  String? time;

  JobModel({this.address,this.age,this.date,this.detail,this.gender,this.money,this.name,this.safe,this.time});

  JobModel.fromSnapshot(DataSnapshot snap)
  {
    address = (snap.value as dynamic)["address"];
    age = (snap.value as dynamic)["age"];
    date = (snap.value as dynamic)["date"];
    detail = (snap.value as dynamic)["detail"];
    gender = (snap.value as dynamic)["gender"];
    money = (snap.value as dynamic)["money"];
    name = (snap.value as dynamic)["name"];
    safe = (snap.value as dynamic)["safe"];
    time = (snap.value as dynamic)["time"];
  }
}