import 'dart:ffi';

class ContractorRequestInformation
{
  String? requestId;
  String? id;
  String? jobId;
  String? name;
  String? lastname;
  String? gender;
  String? address;
  String? phone;
  String? age;
  String? ratings;

  ContractorRequestInformation({
    this.requestId,
    this.id,
    this.jobId,
    this.name,
    this.lastname,
    this.gender,
    this.address,
    this.phone,
    this.age,
    this.ratings,
});
}