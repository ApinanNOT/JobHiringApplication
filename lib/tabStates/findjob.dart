import 'package:flutter/material.dart';
import '../utility/my_constant.dart';
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

  TextEditingController searchmoneyTextEditingController =
      TextEditingController();
  TextEditingController searchgenderTextEditingController =
      TextEditingController();
  TextEditingController searchsafeTextEditingController =
      TextEditingController();
  TextEditingController searchageTextEditingController =
      TextEditingController();

  Row buildSearchMoney(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            style: MyConstant().textinput(),
            controller: searchmoneyTextEditingController,
            keyboardType: TextInputType.number,
            validator: (searchmoneyTextEditingController) {
              if (searchmoneyTextEditingController!.isEmpty) {
                return 'กรุณากรอกค่าตอบแทน';
              } else if (RegExp(r'[\s]')
                  .hasMatch(searchmoneyTextEditingController)) {
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

  Row buildSearchGender(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.7,
            child: DropdownButtonFormField<String>(
              validator: (selectedsearchgendertype) {
                if (selectedsearchgendertype == null) {
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
            width: size * 0.7,
            child: DropdownButtonFormField<String>(
              validator: (selectedsearchsafetype) {
                if (selectedsearchsafetype == null) {
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
          margin: const EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            style: MyConstant().textinput(),
            controller: searchageTextEditingController,
            //keyboardType: TextInputType.number,
            validator: (searchageTextEditingController) {
              if (searchageTextEditingController!.isEmpty) {
                return 'กรุณากรอกช่วงอายุที่ต้องการ';
              } else if (RegExp(r'[\s]')
                  .hasMatch(searchageTextEditingController)) {
                return 'ต้องไม่มีช่องว่าง';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'ช่วงอายุ',
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

  Row buildSearch(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: size * 0.7,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                //showDialogRegister();
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
              //Navigator.pushformsearch(context, size);
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
    return formsearch(context, size);
    // return Scaffold(
    //   body: SafeArea(
    //     child: GestureDetector(
    //       onTap: () => FocusScope.of(context).requestFocus(
    //         FocusNode(),
    //       ),
    //       behavior: HitTestBehavior.opaque,
    //       child: ListView(
    //         children: [
    //           buildImage(size),
    //           buildSearchNormal(size),
    //           buildSearchDetails(size),
    //         ],
    //       ),
    //     ),
    //   ),
    // );
  }

  Scaffold formsearch(BuildContext context, double size) {
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
                buildTitle1("ระบุรายละเอียด"),
                buildSearchMoney(size),
                buildSearchGender(size),
                buildSearchSafe(size),
                buildSearchAge(size),
                buildSearch(size),
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
