import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:jobhiring/states/trips_history_screen.dart';
import 'package:jobhiring/utility/my_constant.dart';

import '../global/global.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {

  @override
  void initState()
  {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: TripsHistoryScreen(),
    );
  }
// Row buildContractor(double size) {
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       Container(
//         margin: const EdgeInsets.symmetric(vertical: 20),
//         width: size * 0.7,
//         child: ElevatedButton(
//           style: MyConstant().myButtonStyle1(),
//           onPressed: () {
//             Navigator.push(context, MaterialPageRoute(builder: (c) => TripsHistoryScreen()));
//           },
//           child: Text(
//             'ผู้รับจ้าง',
//             style: MyConstant().textbutton1(),
//           ),
//         ),
//       ),
//     ],
//   );
// }
}