import 'package:flutter/material.dart';
import 'package:siksha_anudan/DonerProfile_Page.dart';
import 'package:siksha_anudan/StudentCurrentProgress_Page.dart';
import 'package:line_icons/line_icons.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  int currentIndex=0;
  final screens=[
    const StudentCurrentPage(),

    const DonerProfile_Page(),
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
            icon: Icon(LineIcons.home),
            label: 'Home',
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
