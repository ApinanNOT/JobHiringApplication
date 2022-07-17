import 'package:flutter/material.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:jobhiring/states/select_job_nearest.dart';
import 'package:jobhiring/tabStates/findjob.dart';
import 'package:jobhiring/tabStates/history.dart';
import 'package:jobhiring/tabStates/homecontractor.dart';
import 'package:jobhiring/tabStates/profile.dart';
import 'package:jobhiring/utility/my_constant.dart';

import '../assistants/geofire_assistant.dart';
import '../global/global.dart';
import '../utility/progress_dialog.dart';

class Contractor extends StatefulWidget {
  const Contractor({Key? key}) : super(key: key);

  @override
  State<Contractor> createState() => _ContractorState();
}

class _ContractorState extends State<Contractor>
    with SingleTickerProviderStateMixin
{
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(
          () {
        selectedIndex = index;
        tabController!.index = selectedIndex;
        print("INDEXXXXXXXXXXXXXXXXXXXXXXXXX");
        print(index);
        print("SELECTINDEXXXXXXXXX");
        print(selectedIndex);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    print("เป็นอิหยังวะ");
    print(jList);
    print(jList.length);

    tabController = TabController(length: 3, vsync: this);
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
          HomeTabContractor(),
          //FindTab(),
          HistoryTab(),
          ProfileTab(),
        ],
      ),
      bottomNavigationBar: buildBottomlower(),
    );
  }

  // void removeQueryListener() async {
  //   bool? response = await Geofire.stopListener();
  //
  //   jList.clear();
  //   print("PPPPPPPPPPPPPPPPPPPPPPPPPPPP");
  //   print(response);
  // }

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
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.search),
        //   label: 'ระบุงาน',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'ประวัติ',
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
      onTap: onItemClicked ,
    );
  }
}
