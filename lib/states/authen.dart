import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/splash_screen/splash_screen.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:jobhiring/utility/progress_dialog.dart';
import 'package:jobhiring/widgets/show_image.dart';
import 'package:jobhiring/widgets/show_title.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);
  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  bool statusRedEye = true;
  final formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  loginUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext c) {
        return ProgressDialog(
          message: "เข้าสู่ระบบ",
        );
      },
    );
    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            .catchError(
      (msg) {
        Navigator.pop(context);
        Fluttertoast.showToast(
            msg: "กรุณาระบุอีเมลและรหัสผ่านที่ถูกต้อง",
            toastLength: Toast.LENGTH_LONG,
            fontSize: 14,
            backgroundColor: Colors.red);
      },
    ))
        .user;

    if (firebaseUser != null) {
      currentFirebaseUser = firebaseUser;
      Fluttertoast.showToast(
          msg: "เข้าสู่ระบบสำเร็จ",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14,
          backgroundColor: Colors.green);
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "เข้าสู่ระบบล้มเหลว",
          toastLength: Toast.LENGTH_LONG,
          fontSize: 14,
          backgroundColor: Colors.red);
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
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
              buildCreatAccount()
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
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.routeCreateAccount),
          child: Text(
            'สร้างบัญชีผู้ใช้',
            style: MyConstant().h5Style(),
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
              // if (formKey.currentState!.validate()) {
              // }
              loginUser();
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
