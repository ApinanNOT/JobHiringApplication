import 'package:flutter/material.dart';
import 'package:jobhiring/utility/my_constant.dart';

class Contractor extends StatefulWidget {
  const Contractor({Key? key}) : super(key: key);

  @override
  State<Contractor> createState() => _ContractorState();
}

class _ContractorState extends State<Contractor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ผู้รับจ้าง',
          style: MyConstant().headbar(),
        ),
        backgroundColor: MyConstant.primary,
      ),
    );
  }
}
