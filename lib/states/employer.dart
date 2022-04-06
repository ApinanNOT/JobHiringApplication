import 'package:flutter/material.dart';
import 'package:jobhiring/tabStates/home.dart';
import 'package:jobhiring/tabStates/postjob.dart';
import 'package:jobhiring/tabStates/profile.dart';
import 'package:jobhiring/tabStates/rating.dart';
import 'package:jobhiring/utility/my_constant.dart';

class Employer extends StatefulWidget {
  const Employer({Key? key}) : super(key: key);

  @override
  State<Employer> createState() => _EmployerState();
}

class _EmployerState extends State<Employer>
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

    tabController = TabController(length: 4, vsync: this);
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
        children: const [
          HomeTab(),
          PostTab(),
          RatingTab(),
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
        BottomNavigationBarItem(
          icon: Icon(Icons.post_add),
          label: 'ประกาศงาน',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.star),
          label: 'ให้คะแนน',
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
