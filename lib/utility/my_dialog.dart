import 'package:flutter/material.dart';
import 'package:jobhiring/utility/my_constant.dart';
import 'package:jobhiring/widgets/show_image.dart';
import 'package:jobhiring/widgets/show_title.dart';

class MyDialog {
  Future<Null> normalDialog(
      BuildContext context, String title, String message) async {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: ListTile(
          leading: ShowImage(path: MyConstant.imagelogo),
          title: ShowTitle(title: title, textStyle: MyConstant().h2Style()),
          subtitle:
              ShowTitle(title: message, textStyle: MyConstant().h4Style()),
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
