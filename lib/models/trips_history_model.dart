import 'package:firebase_database/firebase_database.dart';

class TripsHistoryModel
{
  String? status;
  String? jobName;
  String? jobMoney;
  String? jobAddress;
  String? jobDetail;
  String? jobSafe;
  String? jobAge;
  String? jobGender;
  String? jobDate;
  String? jobPhone;
  String? jobTime;

  TripsHistoryModel({
    this.jobSafe,
    this.jobAddress,
    this.jobMoney,
    this.jobName,
    this.jobDetail,
    this.status,
    this.jobAge,
    this.jobDate,
    this.jobGender,
    this.jobPhone,
    this.jobTime,
  });

  TripsHistoryModel.fromSnapshort(DataSnapshot dataSnapshot)
  {
    status = (dataSnapshot.value as Map)["status"];
    jobName = (dataSnapshot.value as Map)["jobName"];
    jobMoney = (dataSnapshot.value as Map)["jobMoney"];
    jobDetail = (dataSnapshot.value as Map)["jobDetail"];
    jobAddress = (dataSnapshot.value as Map)["jobAddress"];
    jobSafe = (dataSnapshot.value as Map)["jobSafe"];
    jobAge = (dataSnapshot.value as Map)["jobAge"];
    jobTime = (dataSnapshot.value as Map)["jobTime"];
    jobDate = (dataSnapshot.value as Map)["jobDate"];
    jobPhone = (dataSnapshot.value as Map)["jobPhone"];
    jobGender = (dataSnapshot.value as Map)["jobGender"];
  }
}