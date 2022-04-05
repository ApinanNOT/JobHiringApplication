import 'package:flutter/material.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:jobhiring/widgets/show_image.dart';

class Mode extends StatefulWidget {
  const Mode({Key? key}) : super(key: key);

  @override
  State<Mode> createState() => _ModeState();
}

class _ModeState extends State<Mode> {
  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ประเภทผู้ใช้งาน',
          style: MyConstant().headbar(),
        ),
        backgroundColor: MyConstant.primary,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(
            FocusNode(),
          ),
          behavior: HitTestBehavior.opaque,
          child: ListView(
            children: [
              buildImage(size),
              buildContractor(size),
              buildEmployer(size),
            ],
          ),
        ),
      ),
    );
  }

  Row buildContractor(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          width: size * 0.7,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              Navigator.pushNamed(context, MyConstant.routeContractor);
            },
            child: Text(
              'ผู้รับจ้าง',
              style: MyConstant().textbutton1(),
            ),
          ),
        ),
      ],
    );
  }

  Row buildEmployer(double size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          width: size * 0.7,
          child: ElevatedButton(
            style: MyConstant().myButtonStyle1(),
            onPressed: () {
              Navigator.pushNamed(context, MyConstant.routeEmployer);
            },
            child: Text(
              'ผู้ว่าจ้าง',
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
}
