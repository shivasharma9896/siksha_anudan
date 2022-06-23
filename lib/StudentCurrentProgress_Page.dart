import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StudentCurrentPage extends StatefulWidget {
  const StudentCurrentPage({Key? key}) : super(key: key);

  @override
  State<StudentCurrentPage> createState() => _StudentCurrentPageState();
}

class _StudentCurrentPageState extends State<StudentCurrentPage> {
  int amountRaised=50000;
  int aidAmount=100000;
  String degree="MCA";
  String name="Kendal Jenner";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: ListView(
         padding: const EdgeInsets.symmetric(horizontal: 32),
         physics: const BouncingScrollPhysics(),
         children: [
           Center(
             child:Column(

               children: [
                 const SizedBox(height: 100),
                 Text("Hola!  $name ",style: bigTextGreenHeading),
                 const SizedBox(height: 50),
                 const CircleAvatar(
                   minRadius: 60,
                   maxRadius: 70,
                   backgroundImage: AssetImage('assets/images/profile.jpg'),
                 ),
                 const SizedBox(height: 50),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Text("Degree : ",style: bigTextGreenHeading),
                     Text(degree,style: const TextStyle(
                       color: Colors.lightBlueAccent,
                       fontWeight: FontWeight.w700,
                       fontSize: 30
                     ),),
                   ],
                 ),
                 const SizedBox(height: 40,),
                 const Text("Amount Raised",style: bigTextGreenHeading),
                 const SizedBox(height: 20,),
                 Text("$amountRaised",style: textLimeheading,),
               ],
             ),
           ),
           const SizedBox(height: 20),
           LinearPercentIndicator(
             width: 320,
             lineHeight: 40,
             center: const Text('50%'),
             progressColor: Colors.lightGreen,
             percent: .5,
             barRadius: const Radius.elliptical(30, 30),
             animation: true,
             animationDuration: 5000,
           ),
           const SizedBox(height: 40),
           Center(
             child:Column(
               children: [
                 const Text("Total Aid Amount",style: bigTextGreenHeading),
                 const SizedBox(height: 20),
                 Text("$aidAmount",style: textLimeheading,),
               ],
             ),
           ),
      ]
     ),
    );
  }
}
