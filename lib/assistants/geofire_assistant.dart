import 'package:jobhiring/models/job_location.dart';

class GeoFireAssistant
{
  static List<JobLocation> jobLocationList = [];

  static void deleteJobLocationFromList(String jobId)
  {
    int indexNumber = jobLocationList.indexWhere((element) => element.jobId == jobId);
    jobLocationList.removeAt(indexNumber);
  }

  static void updateJobLocation(JobLocation jobLocationMove)
  {
    int indexNumber = jobLocationList.indexWhere((element) => element.jobId ==  jobLocationMove.jobId);

    jobLocationList[indexNumber].locationLatitude =  jobLocationMove.locationLatitude;
    jobLocationList[indexNumber].locationLongitude = jobLocationMove.locationLongitude;
  }
}