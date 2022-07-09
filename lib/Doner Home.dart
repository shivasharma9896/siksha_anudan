import 'package:flutter/material.dart';
import 'package:siksha_anudan/DonerProfile_Page.dart';
import 'package:siksha_anudan/History_Page.dart';
import 'Search_Student_Page.dart';
import 'package:line_icons/line_icons.dart';

class DonerHome extends StatefulWidget {
  const DonerHome({Key? key}) : super(key: key);

  @override
  State<DonerHome> createState() => _DonerHomeState();
}

class _DonerHomeState extends State<DonerHome> {
  int currentIndex=0;
  final screens=[
     SearchStudent_Page(),
     HistoryPage(),
     DonerProfile_Page(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        showUnselectedLabels: false,
        onTap:(index)=> setState(()=>currentIndex=index) ,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.user),
            label: 'Profile',
          ),
        ],
        fixedColor: Colors.lime,
        backgroundColor: Colors.green,
        unselectedItemColor: Colors.white,
      ),
      body: IndexedStack(
        index: currentIndex,
        children:screens,
      ),
    );
  }
}
