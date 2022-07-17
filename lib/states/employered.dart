import 'package:flutter/material.dart';
import 'package:jobhiring/tabStates/homeemployer.dart';
import 'package:jobhiring/tabStates/myjob.dart';
import 'package:jobhiring/tabStates/postjob.dart';
import 'package:jobhiring/tabStates/profile.dart';
import 'package:jobhiring/utility/my_constant.dart';

import '../assistants/assistant_methods.dart';
import '../global/global.dart';
import '../tabStates/history.dart';

class Employered extends StatefulWidget {
  const Employered({Key? key}) : super(key: key);

  @override
  State<Employered> createState() => _EmployeredState();
}

class _EmployeredState extends State<Employered>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(
          () {
        selectedIndex = index;
        tabController!.index = selectedIndex;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    AssistantMethods.readCurrentOnlineJobInfo();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'ผู้ว่าจ้าง',
          style: MyConstant().headbar(),
        ),
        backgroundColor: MyConstant.primary,
        automaticallyImplyLeading: false,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          HomeTabEmployer(),
          MyJob(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: buildBottomlower(),
    );
  }

  BottomNavigationBar buildBottomlower() {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'หน้าหลัก',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.star),
        //   label: 'ให้คะแนน',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.schedule),
          label: 'รอผู้รับจ้าง',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'โปรไฟล์',
        ),
      ],
      unselectedItemColor: Colors.white38,
      selectedItemColor: Colors.white,
      backgroundColor: const Color(0xffc62828),
      type: BottomNavigationBarType.fixed,
      selectedLabelStyle: MyConstant().h4Style(),
      unselectedLabelStyle: MyConstant().h6Style(),
      showUnselectedLabels: true,
      currentIndex: selectedIndex,
      onTap: onItemClicked,
    );
  }
}
