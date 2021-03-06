import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/splash_screen/splash_screen.dart';
import 'package:jobhiring/states/create_account.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:jobhiring/utility/progress_dialog.dart';
import 'package:jobhiring/widgets/show_image.dart';
import 'package:jobhiring/widgets/show_title.dart';
import 'package:jobhiring/utility/my_dialog.dart';
import 'package:tbib_toast/tbib_toast.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);
  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  validateForm() {
    if (!emailTextEditingController.text.contains("@")) {
      MyDialog().normalDialog(
          context, 'กรุณาระบุอีเมล', 'โปรดตรวจสอบว่ามีการกรอกอีเมลที่ถูกต้อง');
    } else if (passwordTextEditingController.text.isEmpty) {
      MyDialog().normalDialog(context, 'กรุณาระบุรหัสผ่าน',
          'โปรดตรวจสอบว่ามีการกรอกรห้สผ่านที่ถูกต้อง');
    } else {
      loginUser();
    }
  }

  loginUser() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "กำลังเข้าสู่ระบบ",
          );
        });

    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError((msg) {
      Navigator.pop(context);
      MyDialog().normalDialog(context, 'ไม่มีข้อมูลการลงทะเบียน',
          'โปรดตรวจสอบว่าท่านได้ลงทะเบียนเรียบร้อยแล้ว');
    }))
        .user;

    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      Toast.show(
        "เข้าสู่ระบบสำเร็จ",
        context,
        duration: Toast.lengthLong,
        gravity: Toast.center,
        backgroundColor: Colors.green,
        textStyle: MyConstant().texttoast(),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (c) => const MySplashScreen(),
        ),
      );
    } else {
      Navigator.pop(context);
      Toast.show(
        "เกิดข้อผิดพลาดในการเข้าสู่ระบบ",
        context,
        duration: Toast.lengthLong,
        gravity: Toast.center,
        backgroundColor: Colors.red,
        textStyle: MyConstant().texttoast(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width; //auto detect size images
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          //when click on screen keybord down
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: [
              buildImage(size),
              buildAppName(),
              buildEmail(size),
              buildPassword(size),
              buildLogin(size),
              buildCreatAccount(),
              // const SizedBox(height: 30),
              // buildForgotPassword(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildCreatAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'ยังไม่มีบัญชี ?',
          textStyle: MyConstant().h4Style(),
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const CreateAccount()));
          },
          child: Text(
            'สร้างบัญชีผู้ใช้',
            style: MyConstant().h5Style(),
          ),
        )
      ],
    );
  }

  Row buildForgotPassword() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: ()
          {

          },
          child: Text(
            'ลืมรหัสผ่าน?',
            style: MyConstant().forgotpass(),
          ),
        )
      ],
    );
  }

  Row buildLogin(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          width: size * 0.7,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              validateForm();
            },
            child: Text(
              'เข้าสู่ระบบ',
              style: MyConstant().textbutton1(),
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
            style: MyConstant().textinput(),
            keyboardType: TextInputType.emailAddress,
            controller: emailTextEditingController,
            decoration: InputDecoration(
              labelStyle: MyConstant().h3Style(),
              labelText: 'อีเมล',
              prefixIcon: Icon(
                Icons.person,
                color: MyConstant.dark,
              ),
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
            style: MyConstant().textinput(),
            controller: passwordTextEditingController,
            obscureText: statusRedEye,
            decoration: InputDecoration(
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
              prefixIcon: Icon(
                Icons.key,
                color: MyConstant.dark,
              ),
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

  Row buildAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: MyConstant.appName,
          textStyle: MyConstant().h1Style(),
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
}

class BOTTOM {}
