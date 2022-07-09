import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'model/Student_model.dart';

class StudentCurrentPage extends StatefulWidget {
  const StudentCurrentPage({Key? key}) : super(key: key);

  @override
  State<StudentCurrentPage> createState() => _StudentCurrentPageState();
}

class _StudentCurrentPageState extends State<StudentCurrentPage> {
  final _auth = FirebaseAuth.instance;
  late User loggedUser;
  List studentProfile=[];
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchStudent();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }
  Future<List> fetchStudent()async{
    dynamic resultant=await StudentModel().getStudent(loggedUser.email.toString());
    if(resultant==null){
      print("unable to retrieve");
    }
    else{
      setState((){
        studentProfile=resultant;
      });
    }
    return studentProfile;
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser!;
      loggedUser = user;
      print("user email");
      print(loggedUser.email);
    }
    catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    double percent=(studentProfile[0]['amountRec']/studentProfile[0]['amountReq'] *100) ;
    int per=percent.round();
    return Scaffold(
     body: ListView(
         padding: const EdgeInsets.symmetric(horizontal: 32),
         physics: const BouncingScrollPhysics(),
         children: [
           Center(
             child:Column(

               children: [
                 const SizedBox(height: 100),
                 Text("Hola! "+studentProfile[0]['name'],style: bigTextGreenHeading),
                 const SizedBox(height: 50),
                  CircleAvatar(
                   minRadius: 60,
                   maxRadius: 70,
                   backgroundImage: NetworkImage(studentProfile[0]['photourl'].toString()),
                 ),
                 const SizedBox(height: 50),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     const Text("Degree : ",style: bigTextGreenHeading),
                     Text(studentProfile[0]['appFor'],style: const TextStyle(
                       color: Colors.lightBlueAccent,
                       fontWeight: FontWeight.w700,
                       fontSize: 30
                     ),),
                   ],
                 ),
                 const SizedBox(height: 40,),
                 const Text("Amount Raised",style: bigTextGreenHeading),
                 const SizedBox(height: 20,),
                 Text(studentProfile[0]['amountRec'].toString(),style: textLimeheading,),
               ],
             ),
           ),
           const SizedBox(height: 20),
           LinearPercentIndicator(
             width: 320,
             lineHeight: 40,
             center:  Text("$per%"),
             progressColor: Colors.lightGreen,
             percent: per/100,
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
                 Text(studentProfile[0]['amountReq'].toString(),style: textLimeheading,),
               ],
             ),
           ),
      ]
     ),
    );
  }
}
