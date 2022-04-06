import 'package:flutter/material.dart';
import 'package:jobhiring/tabStates/findjob.dart';
import 'package:jobhiring/tabStates/home.dart';
import 'package:jobhiring/tabStates/profile.dart';
import 'package:jobhiring/tabStates/rating.dart';
import 'package:jobhiring/utility/my_constant.dart';

class Contractor extends StatefulWidget {
  const Contractor({Key? key}) : super(key: key);

  @override
  State<Contractor> createState() => _ContractorState();
}

class _ContractorState extends State<Contractor>
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
          'ผู้รับจ้าง',
          style: MyConstant().headbar(),
        ),
        backgroundColor: MyConstant.primary,
        automaticallyImplyLeading: false, //no back botton
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTab(),
          FindTab(),
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
          icon: Icon(Icons.search),
          label: 'ค้นหางาน',
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
