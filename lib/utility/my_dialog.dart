import 'package:flutter/material.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:jobhiring/widgets/show_image.dart';
import 'package:jobhiring/widgets/show_title.dart';

class MyDialog {
  final Function()? funcAction;
  MyDialog({this.funcAction});
  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: ListTile(
          leading: ShowImage(path: MyConstant.imagelogo),
          title: ShowTitle(title: title, textStyle: MyConstant().h2Style()),
          subtitle:
              ShowTitle(title: message, textStyle: MyConstant().textdialog2()),
        ),
        children: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'ตกลง',
              style: MyConstant().h3Style(),
            ),
          )
        ],
      ),
    );
  }
}
