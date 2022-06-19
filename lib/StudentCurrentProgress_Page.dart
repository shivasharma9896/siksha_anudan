import 'package:drop_down_list/drop_down_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siksha_anudan/DonerProfile_Page.dart';
import 'package:siksha_anudan/History_Page.dart';
import 'Search_Student_Page.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StudentCurrentPage extends StatefulWidget {
  const StudentCurrentPage({Key? key}) : super(key: key);

  @override
  State<StudentCurrentPage> createState() => _StudentCurrentPageState();
}

class _StudentCurrentPageState extends State<StudentCurrentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: ListView(
         padding: EdgeInsets.symmetric(horizontal: 32),
         physics: BouncingScrollPhysics(),
         children: [
         const SizedBox(height: 50),
      CircleAvatar(
        minRadius: 60,
        maxRadius: 70,
        backgroundImage: AssetImage('assets/images/profile.jpg'),
      ),
           const SizedBox(height: 50),
           Text("Amoount Raised"),
           LinearPercentIndicator(
             width: 320,
             lineHeight: 40,
             center: Text('50%'),
             progressColor: Colors.lightGreen,
             percent: .5,
             barRadius: Radius.elliptical(30, 30),
             animation: true,
             animationDuration: 5000,
           ),
      ]
     ),
    );
  }
}
