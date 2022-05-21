import 'package:flutter/material.dart';
import 'package:tbib_toast/tbib_toast.dart';
import '../utility/my_constant.dart';
import '../utility/progress_dialog.dart';
import '../widgets/show_image.dart';
import '../widgets/show_title.dart';

class FindTab extends StatefulWidget {
  const FindTab({Key? key}) : super(key: key);

  @override
  State<FindTab> createState() => _FindTabState();
}

class _FindTabState extends State<FindTab> {
  String? typeUser;
  final formKey = GlobalKey<FormState>(); //create variable
  List<String> searchgenderlist = ["ชาย", "หญิง", "LGBTQ", "ทุกเพศ"]; //gender
  String? selectedsearchgendertype;

  List<String> searchsafelist = ["ปลอดภัย", "เสี่ยง", "อันตราย"]; //gender
  String? selectedsearchsafetype;

  List<String> searchagelist = [
    "18 - 60 ปี",
    "18 - 20 ปี",
    "21 - 30 ปี",
    "31 - 40 ปี",
    "41 - 50 ปี",
    "51 - 60 ปี"
  ]; //age
  String? selectedsearchagetype;

  List<String> searchmoneylist = [
    "น้อยกว่า 100 บาท",
    "100 - 500 บาท",
    "501 - 1000 บาท",
    "1001 - 1500 บาท",
    "1501 - 2000 บาท",
    "2001 - 2500 บาท",
    "2501 - 3000 บาท",
    "มากกว่า 3000 บาท"
  ]; //money
  String? selectedsearchmoneytype;

  TextEditingController searchmoneyTextEditingController =
      TextEditingController();
  TextEditingController searchgenderTextEditingController =
      TextEditingController();
  TextEditingController searchsafeTextEditingController =
      TextEditingController();
  TextEditingController searchageTextEditingController =
      TextEditingController();

  //searchdetailsjob
  searchdetails() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "กำลังค้นหางาน",
        );
      },
    );
  }

  Row buildSearchMoney(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'ค่าตอบแทน',
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
              value: selectedsearchmoneytype,
              onChanged: (newValue) {
                setState(() {
                  selectedsearchmoneytype = newValue.toString();
                });
              },
              items: searchmoneylist.map((money) {
                return DropdownMenuItem(
                  child: Text(
                    money,
                    style: MyConstant().textinput(),
                  ),
                  value: money,
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildSearchGender(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
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
              value: selectedsearchgendertype,
              onChanged: (newValue) {
                setState(() {
                  selectedsearchgendertype = newValue.toString();
                });
              },
              items: searchgenderlist.map((gender) {
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

  Row buildSearchSafe(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
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
              value: selectedsearchsafetype,
              onChanged: (newValue) {
                setState(() {
                  selectedsearchsafetype = newValue.toString();
                });
              },
              items: searchsafelist.map((safe) {
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

  Row buildSearchAge(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.6,
            child: DropdownButtonFormField<String>(
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
              value: selectedsearchagetype,
              onChanged: (newValue) {
                setState(() {
                  selectedsearchagetype = newValue.toString();
                });
              },
              items: searchagelist.map((age) {
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

  Row buildImage(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: size * 0.7,
          child: ShowImage(path: MyConstant.imagelogo),
        ),
      ],
    );
  }

  Row buildSearch(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 18),
          width: size * 0.6,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              if((selectedsearchmoneytype != null) ||
                  (selectedsearchgendertype != null) ||
                  (selectedsearchsafetype != null) ||
                  (selectedsearchsafetype != null) ||
                  (selectedsearchagetype != null))
              {
                Navigator.pop(context);
                searchdetails();
              }else{
              Toast.show(
              "กรุณาระบุรายละเอียดอย่างน้อย 1 อย่าง",
              context,
              duration: Toast.lengthLong,
              gravity: Toast.center,
              backgroundColor: Colors.red,
              textStyle: MyConstant().texttoast(),
              );
              }
            },
            child: Text(
              'ค้นหา',
              style: MyConstant().textbutton1(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildSearchDetails(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: size * 0.7,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              dialogformsearch(size);
            },
            child: Text(
              'ค้นหาแบบละเอียด',
              style: MyConstant().textbutton1(),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> dialogformsearch(double size) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          scrollable: true,
          title: Text(
            "รายละเอียด",
            style: MyConstant().h2Style(),
            textAlign: TextAlign.center,
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    buildSearchMoney(size),
                    buildSearchGender(size),
                    buildSearchSafe(size),
                    buildSearchAge(size),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            buildSearch(size),
          ],
        );
      },
    );
  }

  Row buildSearchNormal(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          width: size * 0.7,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              //Navigator.pushNamed(context, MyConstant.routeEmployer);
            },
            child: Text(
              'ค้นหาในรัศมี 10 กิโลเมตร',
              style: MyConstant().textbutton1(),
            ),
          ),
        ),
      ],
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
                buildSearchNormal(size),
                buildSearchDetails(size)
              ],
            ),
          ),
        ),
      ),
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
}
