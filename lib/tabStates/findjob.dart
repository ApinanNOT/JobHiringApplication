import 'package:flutter/material.dart';

class FindTab extends StatefulWidget {
  const FindTab({Key? key}) : super(key: key);

  @override
  State<FindTab> createState() => _FindTabState();
}

class _FindTabState extends State<FindTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('หางาน'),
    );
  }
}
