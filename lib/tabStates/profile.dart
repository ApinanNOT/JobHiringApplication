import 'package:flutter/material.dart';
import 'package:jobhiring/assistants/assistant_methods.dart';
import 'package:jobhiring/global/global.dart';
import 'package:jobhiring/states/authen.dart';
import 'package:jobhiring/utility/my_constant.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Column(
      children: [
        profilepicture(),
        const SizedBox(height: 10, width: 10),
        Text(
          userModelCurrentInfo!.name.toString() +
              " " +
              userModelCurrentInfo!.lastname.toString(),
          style: MyConstant().userinfo1(),
        ),
        Text(
          currentFirebaseUser!.uid,
          style: MyConstant().userinfo2(),
        ),
        const SizedBox(height: 30, width: 10),
        userinfo(size),
        const SizedBox(height: 15, width: 15),
        signoutbutton(context)
      ],
    );
  }

  ElevatedButton signoutbutton(BuildContext context) {
    return ElevatedButton(
      style: MyConstant().myButtonStyle1(),
      child: Text(
        "ออกจากระบบ",
        style: MyConstant().textbutton1(),
      ),
      onPressed: () {
        fAuth.signOut();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => const Authen(),
          ),
        );
      },
    );
  }

  Container userinfo(double size) {
    return Container(
      height: 300,
      child: Stack(
        children: [
          Positioned(
            child: Material(
              child: Container(
                height: size * 0.8,
                width: size * 0.85,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      offset: const Offset(0.0, 0.0),
                      blurRadius: 20.0,
                      spreadRadius: 3.0,
                    ), //BoxShadow
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 13, width: 13),
                      Text(
                        "หมายเลขบัตรประชาชน",
                        style: MyConstant().userinfo3(),
                      ),
                      Text(
                        userModelCurrentInfo!.id.toString(),
                        style: MyConstant().userinfo4(),
                      ),
                      const SizedBox(height: 8, width: 8),
                      Text(
                        "เบอร์โทรศัพท์",
                        style: MyConstant().userinfo3(),
                      ),
                      Text(
                        userModelCurrentInfo!.phone.toString(),
                        style: MyConstant().userinfo4(),
                      ),
                      const SizedBox(height: 8, width: 8),
                      Text(
                        "ที่อยู่",
                        style: MyConstant().userinfo3(),
                      ),
                      Text(
                        userModelCurrentInfo!.address.toString(),
                        style: MyConstant().userinfo4(),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8, width: 8),
                      Text(
                        "อีเมล",
                        style: MyConstant().userinfo3(),
                      ),
                      Text(
                        userModelCurrentInfo!.email.toString(),
                        style: MyConstant().userinfo4(),
                      ),
                      const SizedBox(height: 8, width: 8),
                      Text(
                        "เพศ",
                        style: MyConstant().userinfo3(),
                      ),
                      Text(
                       userModelCurrentInfo!.gender.toString(),
                        style: MyConstant().userinfo4(),
                      ),
                      const SizedBox(height: 8, width: 8),
                      Text(
                        "อายุ",
                        style: MyConstant().userinfo3(),
                      ),
                      Text(
                        userModelCurrentInfo!.age.toString(),
                        style: MyConstant().userinfo4(),
                      ),
                      const SizedBox(height: 13, width: 13),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding profilepicture() {
    return const Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: SizedBox(
        height: 90,
        width: 90,
        child: CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
      ),
    );
  }
}
