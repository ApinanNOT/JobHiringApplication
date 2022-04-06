import 'package:flutter/material.dart';
import 'package:jobhiring/utility/my_constant.dart';

class ProgressDialog extends StatelessWidget {
  String? message;
  ProgressDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        margin: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: buildDialogBox(),
        ),
      ),
    );
  }

  Row buildDialogBox() {
    return Row(
      children: [
        const SizedBox(
          width: 6.0,
        ),
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
        ),
        const SizedBox(
          width: 26.0,
        ),
        Text(
          message!,
          style: MyConstant().textdialog(),
        ),
      ],
    );
  }
}

class CircularProgressIndicatior {}