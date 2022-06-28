import 'package:flutter/material.dart';
import 'package:jobhiring/models/trips_history_model.dart';
import 'package:jobhiring/utility/my_constant.dart';

class HistoryDesignUIWidget extends StatefulWidget
{
  TripsHistoryModel? tripsHistoryModel;

  HistoryDesignUIWidget({this.tripsHistoryModel});

  @override
  State<HistoryDesignUIWidget> createState() => _HistoryDesignUIWidgetState();
}

class _HistoryDesignUIWidgetState extends State<HistoryDesignUIWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()
      {
        dialoghistory(context);
      },
      child: Card(
        color: MyConstant.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: ListTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              [
                Text(
                  widget.tripsHistoryModel!.jobName!,
                  style: MyConstant().headbar(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> dialoghistory(BuildContext context) {
    return showDialog(
      barrierDismissible: true, //no touch freespace for exits
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 10,
        title: Container(
          margin: const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const SizedBox(height: 2),

              Text(
                widget.tripsHistoryModel!.jobName!,
                style: MyConstant().jobname(),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "ค่าตอบแทน : " + widget.tripsHistoryModel!.jobMoney! + " " + "บาท",
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "สถานที่ทำงาน : " + widget.tripsHistoryModel!.jobAddress!,
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "ระดับความปลอดภัย : " + widget.tripsHistoryModel!.jobSafe!,
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "เบอร์ : " + widget.tripsHistoryModel!.jobPhone!,
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "วันที่ทำ : " + widget.tripsHistoryModel!.jobDate!,
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 13.0),

                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              "เวลา : " + widget.tripsHistoryModel!.jobTime!,
                              style: MyConstant().userinfo5(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    //const SizedBox(height: 13.0),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
