import 'package:flutter/material.dart';

import '../global/global.dart';

class RatingTab extends StatefulWidget {
  const RatingTab({Key? key}) : super(key: key);

  @override
  State<RatingTab> createState() => _RatingTabState();
}

class _RatingTabState extends State<RatingTab> {

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('คะแนน'),
    );
  }
}
