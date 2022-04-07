import 'package:flutter/material.dart';
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
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      style: MyConstant().myButtonStyle1(),
      child: Text(
        "ออกจากระบบ",
        style: MyConstant().textbutton1(),
      ),
      onPressed: () {
        fAuth.signOut();
        Navigator.push(context, MaterialPageRoute(builder: (c) => Authen()));
      },
    ));
  }
}
