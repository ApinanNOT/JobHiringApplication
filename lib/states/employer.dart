import 'package:flutter/material.dart';
import 'package:jobhiring/utility/my_constant.dart';

class Employer extends StatefulWidget {
  const Employer({Key? key}) : super(key: key);

  @override
  State<Employer> createState() => _EmployerState();
}

class _EmployerState extends State<Employer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ผู้ว่าจ้าง',
          style: MyConstant().headbar(),
        ),
        backgroundColor: MyConstant.primary,
      ),
    );
  }
}
