import 'dart:async';
import 'dart:math';

import 'package:buddhist_datetime_dateformat_sns/buddhist_datetime_dateformat_sns.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/states/employer.dart';
import 'package:jobhiring/states/markerjob.dart';
import 'package:tbib_toast/tbib_toast.dart';

import '../utility/my_constant.dart';
import '../utility/progress_dialog.dart';
import '../widgets/show_image.dart';
import '../widgets/show_title.dart';

class PostTab extends StatefulWidget {
  const PostTab({Key? key}) : super(key: key);

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {

  final formKey = GlobalKey<FormState>(); //create variable

  String? typeUser;
  List<String> jobgenderlist = ["ชาย", "หญิง", "LGBTQ", "ทุกเพศ"]; //gender
  String? selectedjobgendertype;

  List<String> jobsafelist = ["ปลอดภัย", "เสี่ยง", "อันตราย"]; //gender
  String? selectedjobsafetype;

  List<String> jobagelist = [
    "18 - 60 ปี",
    "18 - 20 ปี",
    "21 - 30 ปี",
    "31 - 40 ปี",
    "41 - 50 ปี",
    "51 - 60 ปี"
  ]; //age
  String? selectedjobagetype;

  List<String> typejoblist = [
    "บุคคลทั่วไป",
    "ช่างก่อสร้าง",
    "ช่างประปา",
  ]; //type
  String? selectedtypejobtype;

  @override
  void initState()
  {
    super.initState();
  }

  TextEditingController jobnameTextEditingController = TextEditingController();
  TextEditingController jobmoneyTextEditingController = TextEditingController();
  TextEditingController jobgenderTextEditingController = TextEditingController();
  TextEditingController jobsafeTextEditingController = TextEditingController();
  TextEditingController jobageTextEditingController = TextEditingController();
  TextEditingController jobdateTextEditingController = TextEditingController();
  TextEditingController jobtimeTextEditingController = TextEditingController();
  TextEditingController jobaddressTextEditingController = TextEditingController();
  TextEditingController jobdetailTextEditingController = TextEditingController();
  TextEditingController jobphoneTextEditingController = TextEditingController();
  TextEditingController jobtypeTextEditingController = TextEditingController();

  saveJobInformation() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "กำลังบันทึกข้อมูล",
        );
      },
    );

    Map jobmap = {
      "jobId" : currentFirebaseUser!.uid,
      "name": jobnameTextEditingController.text.trim(),
      "money": jobmoneyTextEditingController.text.trim(),
      "gender": selectedjobgendertype,
      "safe": selectedjobsafetype,
      "age": selectedjobagetype,
      "date": jobdateTextEditingController.text.trim(),
      "time": jobtimeTextEditingController.text.trim(),
      "address": jobaddressTextEditingController.text.trim(),
      "detail": jobdetailTextEditingController.text.trim(),
      "phone" : jobphoneTextEditingController.text.trim(),
      "type" : selectedtypejobtype,
      "ratings" : userModelCurrentInfo!.ratings,
      "contractorId" : "idle",
    };

    DatabaseReference jobRef = FirebaseDatabase.instance.ref().child("Jobs");
    jobRef.child(currentFirebaseUser!.uid).set(jobmap);

    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const MarkerJob()));
  }

  Row buildJobName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: size * 0.6,
          child: TextFormField(
            style: MyConstant().textinput(),
            controller: jobnameTextEditingController,
            validator: (jobnameTextEditingController) {
              if (jobnameTextEditingController!.isEmpty) {
                return 'กรุณากรอกชื่องาน';
              } else if (RegExp(r'[\s]')
                  .hasMatch(jobnameTextEditingController)) {
                return 'ต้องไม่มีช่องว่าง';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: "ชื่องาน",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildJobMoney(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: size * 0.6,
          child: TextFormField(
            style: MyConstant().textinput(),
            controller: jobmoneyTextEditingController,
            keyboardType: TextInputType.number,
            validator: (jobmoneyTextEditingController) {
              if (jobmoneyTextEditingController!.isEmpty) {
                return 'กรุณากรอกค่าตอบแทน';
              } else if (RegExp(r'[\s]')
                  .hasMatch(jobmoneyTextEditingController)) {
                return 'ต้องไม่มีช่องว่าง';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: "ค่าตอบแทน",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildJobPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: size * 0.6,
          child: TextFormField(
            style: MyConstant().textinput(),
            controller: jobphoneTextEditingController,
            keyboardType: TextInputType.number,
            validator: (jobphoneTextEditingController) {
              if (jobphoneTextEditingController!.isEmpty) {
                return 'กรุณากรอกเบอร์ติดต่อ';
              } else if (RegExp(r'[\s]')
                  .hasMatch(jobphoneTextEditingController)) {
                return 'ต้องไม่มีช่องว่าง';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: "เบอร์ติดต่อ",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildJobGender(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
              validator: (selectedjobgendertype) {
                if (selectedjobgendertype == null) {
                  return 'กรุณาระบุเพศที่ต้องการ';
                } else {}
              },
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'เพศที่ต้องการ',
                labelStyle: MyConstant().h3Style(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              value: selectedjobgendertype,
              onChanged: (newValue) {
                setState(() {
                  selectedjobgendertype = newValue.toString();
                });
              },
              items: jobgenderlist.map((gender) {
                return DropdownMenuItem(
                  child: Text(
                    gender,
                    style: MyConstant().textinput(),
                  ),
                  value: gender,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildJobSafe(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
              validator: (selectedjobsafetype) {
                if (selectedjobsafetype == null) {
                  return 'กรุณาระบุความปลอดภัย';
                } else {}
              },
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'ระดับความปลอดภัย',
                labelStyle: MyConstant().h3Style(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              value: selectedjobsafetype,
              onChanged: (newValue) {
                setState(() {
                  selectedjobsafetype = newValue.toString();
                });
              },
              items: jobsafelist.map((safe) {
                return DropdownMenuItem(
                  child: Text(
                    safe,
                    style: MyConstant().textinput(),
                  ),
                  value: safe,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildJobAge(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
              validator: (selectedjobagetype) {
                if (selectedjobagetype == null) {
                  return 'กรุณาระบุช่วงอายุ';
                } else {}
              },
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'ช่วงอายุ',
                labelStyle: MyConstant().h3Style(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              value: selectedjobagetype,
              onChanged: (newValue) {
                setState(() {
                  selectedjobagetype = newValue.toString();
                });
              },
              items: jobagelist.map((age) {
                return DropdownMenuItem(
                  child: Text(
                    age,
                    style: MyConstant().textinput(),
                  ),
                  value: age,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildJobDate(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: size * 0.6,
          child: TextFormField(
            style: MyConstant().textinput(),
            controller: jobdateTextEditingController,
            onTap: () async {
              DateTime date = DateTime.now();
              FocusScope.of(context).requestFocus(FocusNode());
              DateTime? picked =
              // await showDatePicker(
              //     context: context,
              //     initialDate: date,
              //     firstDate: date,
              //     lastDate: DateTime(date.year + 5),);
              await showRoundedDatePicker(
                  height: 308,
                  context: context,
                  locale: Locale("th", "TH"),
                  initialDate: date,
                  firstDate: date,
                  lastDate: DateTime(date.year + 3),
                  era: EraMode.BUDDHIST_YEAR,
                  borderRadius: 20,
                  textPositiveButton: "ตกลง",
                  textNegativeButton: "ยกเลิก",
                theme: ThemeData(
                  primaryColor: MyConstant.primary,
                  primarySwatch: Colors.green,
                ),
                styleDatePicker: MaterialRoundedDatePickerStyle(
                  textStyleYearButton: MyConstant().headbar(),
                  textStyleButtonNegative: MyConstant().cancelbutton(),
                  textStyleButtonPositive: MyConstant().confirmbutton(),
                  textStyleDayButton: MyConstant().searchmatch(),
                  textStyleDayHeader: MyConstant().jobmoney(),
                  textStyleMonthYearHeader: MyConstant().jobmoney(),
                ),
                styleYearPicker: MaterialRoundedYearPickerStyle(
                  textStyleYear: MyConstant().textinput(),
                  textStyleYearSelected: MyConstant().jobname(),
                ),
              );
              if (picked != null && picked != date) {
                jobdateTextEditingController.text = '${picked.day}/${picked.month}/${picked.yearInBuddhistCalendar}';// add this line.
                setState(() {
                  date = picked;
                });
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาระบุวันที่เริ่มทำงาน';
              }
              return null;
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'วันที่เริ่มทำงาน',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildJobTime(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size * 0.6,
          child: TextFormField(
            controller: jobtimeTextEditingController,
            style: MyConstant().textinput(),
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'เวลาเริ่มทำงาน',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onTap: () async {
              TimeOfDay time = TimeOfDay.now();
              FocusScope.of(context).requestFocus(FocusNode());
              TimeOfDay? picked =
              await showTimePicker(
                context: context,
                initialTime: time,
              );
              if (picked != null && picked != time) {
                jobtimeTextEditingController.text = picked.format(context).toString();// add this line.
                setState(() {
                  time = picked;
                });
              }
            },
            validator: (value) {
              if (value!.isEmpty) {
                return 'กรุณาระบุเวลาทำงาน';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Row buildJobAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: size * 0.6,
          child: TextFormField(
            style: MyConstant().textinput(),
            controller: jobaddressTextEditingController,
            validator: (jobaddressTextEditingController) {
              if (jobaddressTextEditingController!.isEmpty) {
                return 'กรุณากรอกสถานที่ทำงาน';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'สถานที่ทำงาน',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildDetails(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          width: size * 0.6,
          child: TextFormField(
            style: MyConstant().textinput(),
            controller: jobdetailTextEditingController,
            validator: (jobdetailTextEditingController) {
              if (jobdetailTextEditingController!.isEmpty) {
                return 'กรุณากรอกรายละเอียดเพิ่มเติม';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'รายละเอียดเพิ่มเติม',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.dark),
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyConstant.light),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Row buildConfirm(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: size * 0.6,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              {
                if(formKey.currentState!.validate())
                {
                  showDialogPost();
                }
              }
            },
            child: Text(
              'บันทึกข้อมูล',
              style: MyConstant().textbutton1(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildJobType(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
              validator: (selectedtypejobtype) {
                if (selectedtypejobtype == null) {
                  return 'กรุณาระบุประเภทบุคคล';
                } else {}
              },
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'ประเภทบุคคล',
                labelStyle: MyConstant().h3Style(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.dark),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: MyConstant.light),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              value: selectedtypejobtype,
              onChanged: (newValue) {
                setState(() {
                  selectedtypejobtype = newValue.toString();
                });
              },
              items: typejoblist.map((type) {
                return DropdownMenuItem(
                  child: Text(
                    type,
                    style: MyConstant().textinput(),
                  ),
                  value: type,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size * 0.3,
          child: ShowImage(path: MyConstant.imagelogo),
        ),
      ],
    );
  }

  Container buildTitle1(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  Container buildTitle2(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
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
              title: "ยืนยันการบันทึกข้อมูล",
              textStyle: MyConstant().h2Style()),
          subtitle: ShowTitle(
              title: "โปรดตรวจสอบข้อมูลให้ถูกต้องก่อนการยืนยันข้อมูล",
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
              Navigator.pop(context);
              saveJobInformation();
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
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        behavior: HitTestBehavior.opaque,
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                buildImage(size),
                buildTitle1("รายละเอียดงาน"),
                buildJobName(size),
                buildJobMoney(size),
                buildJobGender(size),
                buildJobSafe(size),
                buildJobType(size),
                buildJobAge(size),
                buildJobPhone(size),
                buildJobDate(size),
                buildJobTime(size),
                buildJobAddress(size),
                buildDetails(size),
                buildConfirm(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
