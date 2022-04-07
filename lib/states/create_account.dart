import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/splash_screen/splash_screen.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/utility/progress_dialog.dart';
import 'package:jobhiring/widgets/show_image.dart';
import 'package:jobhiring/widgets/show_title.dart';
import '../utility/my_constant.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;
  final formKey = GlobalKey<FormState>(); //create variable
  List<String> genderlist = ["ชาย", "หญิง", "LGBTQ"]; //gender
  String? selectedgendertype;
  bool statusRedEye = true;

  TextEditingController idTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController lastnameTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  Row buildName(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            controller: nameTextEditingController,
            validator: (nameTextEditingController) {
              if (nameTextEditingController!.isEmpty) {
                return 'กรุณากรอกชื่อ';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'ชื่อ (ไม่ต้องระบุคำนำหน้า)',
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

  Row buildLastname(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            controller: lastnameTextEditingController,
            validator: (lastnameTextEditingController) {
              if (lastnameTextEditingController!.isEmpty) {
                return 'กรุณากรอกนามสกุล';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'นามสกุล',
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

  Row buildId(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: idTextEditingController,
            validator: (idTextEditingController) {
              if (idTextEditingController!.isEmpty) {
                return 'กรุณากรอกเลขบัตรประชาชน';
              } else if (!RegExp(r'[0-9]').hasMatch(idTextEditingController)) {
                return 'ต้องเป็นตัวเลข 0-9';
              } else if (idTextEditingController.length < 13) {
                return 'กรุณากรอกให้ครบ 13 หลัก';
              } else if (idTextEditingController.length > 13) {
                return 'เลขบัตรประชาชนต้องไม่เกิน 13 หลัก';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'เลขบัตรประชาชน',
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

  Row buildAddress(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            controller: addressTextEditingController,
            validator: (addressTextEditingController) {
              if (addressTextEditingController!.isEmpty) {
                return 'กรุณากรอกที่อยู่';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'ที่อยู่',
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

  Row buildPhone(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.phone,
            controller: phoneTextEditingController,
            validator: (phoneTextEditingController) {
              if (phoneTextEditingController!.isEmpty) {
                return 'กรุณากรอกเบอร์โทร';
              } else if (!RegExp(r'[0-9]')
                  .hasMatch(phoneTextEditingController)) {
                return 'เบอร์โทรต้องเป็นตัวเลข 0-9';
              } else if (phoneTextEditingController.length < 10) {
                return 'กรุณากรอกเบอร์โทรให้ครบ 10 หลัก';
              } else if (phoneTextEditingController.length > 10) {
                return 'เบอร์โทรต้องไม่เกิน 10 หลัก';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'เบอร์โทร',
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

  Row buildGender(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 20),
          child: SizedBox(
            width: size * 0.7,
            child: DropdownButtonFormField<String>(
              validator: (selectedgendertype) {
                if (selectedgendertype == null) {
                  return 'กรุณาระบุเพศ';
                } else {}
              },
              decoration: InputDecoration(
                errorStyle: MyConstant().errortext(),
                labelText: 'เพศ',
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
              value: selectedgendertype,
              onChanged: (newValue) {
                setState(() {
                  selectedgendertype = newValue.toString();
                });
              },
              items: genderlist.map((gender) {
                return DropdownMenuItem(
                  child: Text(
                    gender,
                    style: MyConstant().h3Style(),
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

  Row buildAge(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            controller: ageTextEditingController,
            keyboardType: TextInputType.phone,
            validator: (ageTextEditingController) {
              if (ageTextEditingController!.isEmpty) {
                return 'กรุณากรอกอายุ';
              } else if (!RegExp(r'[0-9]').hasMatch(ageTextEditingController)) {
                return 'อายุต้องเป็นตัวเลข 0-9';
              } else if (int.tryParse(ageTextEditingController)! < 18) {
                return 'อายุต้องอยู่ระหว่าง 18 - 60 ปี';
              } else if (int.tryParse(ageTextEditingController)! > 60) {
                return 'อายุต้องอยู่ระหว่าง 18 - 60 ปี';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'อายุ',
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

  Row buildEmail(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: emailTextEditingController,
            validator: (emailTextEditingController) {
              if (emailTextEditingController!.isEmpty) {
                return 'กรุณากรอกอีเมล';
              } else if (!RegExp(
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  .hasMatch(emailTextEditingController)) {
                return 'กรุณากรอกอีเมลที่ถูกต้อง';
              } else {}
            },
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              labelStyle: MyConstant().h3Style(),
              labelText: 'อีเมล',
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

  Row buildPassword(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 16),
          width: size * 0.7,
          child: TextFormField(
            controller: passwordTextEditingController,
            validator: (passwordTextEditingController) {
              if (passwordTextEditingController!.isEmpty) {
                return 'กรุณากรอกรหัสผ่าน';
              } else if (passwordTextEditingController.length < 6) {
                return 'รหัสผ่านต้องไม่น้อยกว่า 6 ตัวอักษร';
              } else if (passwordTextEditingController.length > 10) {
                return 'รหัสผ่านต้องไม่เกิน 10 ตัวอักษร';
              } else if (!RegExp(r'[0-9]')
                  .hasMatch(passwordTextEditingController)) {
                return 'รหัสผ่านต้องมีตัวเลข';
              } else if (!RegExp(r'[A-Z]')
                  .hasMatch(passwordTextEditingController)) {
                return 'รหัสผ่านต้องมีตัวอักษรพิมพ์ใหญ่ A-Z';
              } else if (!RegExp(r'[a-z]')
                  .hasMatch(passwordTextEditingController)) {
                return 'รหัสผ่านต้องมีตัวอักษรพิมพ์เล็ก a-z';
              } else if (!RegExp(r'[#?!@$%^&*-]')
                  .hasMatch(passwordTextEditingController)) {
                return 'รหัสผ่านต้องมีตัวอักษรพิเศษ';
              } else {}
            },
            obscureText: statusRedEye,
            decoration: InputDecoration(
              errorStyle: MyConstant().errortext(),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye = !statusRedEye;
                  });
                },
                icon: statusRedEye
                    ? Icon(
                        Icons.visibility_off,
                        color: MyConstant.dark,
                      )
                    : Icon(
                        Icons.visibility,
                        color: MyConstant.dark,
                      ),
              ),
              labelStyle: MyConstant().h3Style(),
              labelText: 'รหัสผ่าน',
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

  Row buildRegister(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          width: size * 0.7,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                saveUserInformation();
              }
            },
            child: Text(
              'สมัครสมาชิก',
              style: MyConstant().textbutton1(),
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
        Container(
          width: size * 0.7,
          child: ShowImage(path: MyConstant.imagelogo),
        ),
      ],
    );
  }

  //connect database and authen
  saveUserInformation() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "กำลังบันทึกข้อมูล",
        );
      },
    );
    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError(
      (msg) {
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "Error: " + msg.toString());
      },
    ))
        .user;

    if (firebaseUser != null) {
      Map usermap = {
        "User UID": firebaseUser.uid,
        "name": nameTextEditingController.text.trim(),
        "lastname": lastnameTextEditingController.text.trim(),
        "id": idTextEditingController.text.trim(),
        "gender": selectedgendertype,
        "address": addressTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
        "age": ageTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "password": passwordTextEditingController.text.trim(),
      };

      DatabaseReference usersRef =
          FirebaseDatabase.instance.ref().child("User");
      usersRef.child(firebaseUser.uid).set(usermap);

      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(
          msg: "สมัครสมาชิกสำเร็จ",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14,
          backgroundColor: Colors.green);
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => MySplashScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "สมัครสมาชิกล้มเหลว",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14,
          backgroundColor: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างบัญชีผู้ใช้',
          style: MyConstant().headbar(),
        ),
        backgroundColor: MyConstant.primary,
      ),
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
                buildTitle1('ข้อมูลส่วนตัว'),
                buildName(size),
                buildLastname(size),
                buildId(size),
                buildAddress(size),
                buildPhone(size),
                buildGender(size),
                buildAge(size),
                buildEmail(size),
                buildPassword(size),
                buildRegister(size),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTitle1(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }

  Container buildTitle2(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        textStyle: MyConstant().h2Style(),
      ),
    );
  }
}
