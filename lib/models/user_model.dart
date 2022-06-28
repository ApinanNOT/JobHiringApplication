
import 'package:firebase_database/firebase_database.dart';

class UserModel
{
  String? phone;
  String? name;
  String? lastname;
  String? id;
  String? gender;
  String? address;
  String? age;
  String? email;
  String? password;

  UserModel({this.phone,this.address,this.age,this.email,this.gender,this.id,this.lastname,this.name,this.password});

  UserModel.fromSnapshot(DataSnapshot snap)
  {
    phone = (snap.value as dynamic)["phone"];
    name = (snap.value as dynamic)["name"];
    lastname = (snap.value as dynamic)["lastname"];
    gender = (snap.value as dynamic)["gender"];
    address = (snap.value as dynamic)["address"];
    age = (snap.value as dynamic)["age"];
    id = (snap.value as dynamic)["id"];
    email = (snap.value as dynamic)["email"];
    password = (snap.value as dynamic)["password"];
  }
}