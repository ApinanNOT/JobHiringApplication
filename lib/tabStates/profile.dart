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

    AssistantMethods.readCurrentOnlineUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        profilepicture(),
        const Padding(
          padding: EdgeInsets.all(5.0),
        ),
        Text("อภินันท์ ประแกกัน", style: MyConstant().userinfo1()),
        Text("25n6gTe4tVgGCCsWC14yFrbgasH2", style: MyConstant().userinfo2()),
        const Padding(
          padding: EdgeInsets.all(18.0),
        ),
        Text("หมายเลขบัตรประชาชน", style: MyConstant().userinfo3()),
        Text("1529902069405", style: MyConstant().userinfo4()),
        Text("เบอร์โทรศัพท์", style: MyConstant().userinfo3()),
        Text("0612953013", style: MyConstant().userinfo4()),
        Text("เพศ", style: MyConstant().userinfo3()),
        Text("ชาย", style: MyConstant().userinfo4()),
        Text("ที่อยู่", style: MyConstant().userinfo3()),
        Text("ลำปาง", style: MyConstant().userinfo4()),
        Text("อีเมล", style: MyConstant().userinfo3()),
        Text("not.254355@gmail.com", style: MyConstant().userinfo4()),
        Text("อายุ", style: MyConstant().userinfo3()),
        Text("22", style: MyConstant().userinfo4()),
        const Padding(
          padding: EdgeInsets.all(10.0),
        ),
        ElevatedButton(
          style: MyConstant().myButtonStyle1(),
          child: Text(
            "ออกจากระบบ",
            style: MyConstant().textbutton1(),
          ),
          onPressed: () {
            fAuth.signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => const Authen()));
          },
        )
      ],
    );
  }

  Padding profilepicture() {
    return const Padding(
      padding: EdgeInsets.only(top: 30.0),
      child: SizedBox(
        height: 100,
        width: 100,
        child: CircleAvatar(
          backgroundImage: AssetImage("images/profile.png"),
        ),
      ),
    );
  }
}
