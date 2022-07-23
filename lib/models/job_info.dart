
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
  String? phone;
  String? safe;
  String? time;
  String? type;

  JobModel({this.gender,this.money,this.detail,this.age,this.name,this.time,this.safe,this.phone,this.date,this.address,this.type});

  JobModel.fromSnapshot(DataSnapshot snap)
  {
    address = (snap.value as dynamic)["address"];
    age = (snap.value as dynamic)["age"];
    date = (snap.value as dynamic)["date"];
    detail = (snap.value as dynamic)["detail"];
    gender = (snap.value as dynamic)["gender"];
    money = (snap.value as dynamic)["money"];
    name = (snap.value as dynamic)["name"];
    phone = (snap.value as dynamic)["phone"];
    safe = (snap.value as dynamic)["safe"];
    time = (snap.value as dynamic)["time"];
    type = (snap.value as dynamic)["type"];
  }
}