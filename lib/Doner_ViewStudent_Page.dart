import 'dart:core';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonerViewStudent_Page  extends StatefulWidget {

  const DonerViewStudent_Page ({Key? key}) : super(key: key);

  @override
  State<DonerViewStudent_Page> createState() => _DonerViewStudent_Page();
}

class _DonerViewStudent_Page extends State<DonerViewStudent_Page> {
  final _auth=FirebaseAuth.instance;
  String name="Kendal Jenner";
  String dob="12/10/1989";
  String age="23";
  String phoneNumber="900695306";
  String city="West Hollywood, CA";
  String degree="MCA";
  String college="VIT Bhopal";
  String sscName="Birla international school";
  String sscBoar="CBSE";
  String sscPassingYear="1999";
  String sscPercentage="90%";
  String colName="St.Xavier's College";
  String colUni="Gujarat University";
  String colPassingYear="2010";
  String colPercentage="70%";
  int tAmount=100000;
  int rAmount=50000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 50),
          const CircleAvatar(
            minRadius: 60,
            maxRadius: 70,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          const SizedBox(height: 24,),
          const Text("Personal Information",style: bigTextGreenHeading,),
          Container(
            margin: const EdgeInsets.all(10),
            padding:  EdgeInsets.all(10),
            decoration: limeCard,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Name : ",style: bigTextGreenHeading,),
                    Text(name,style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("DOB : ",style: bigTextGreenHeading,),
                    Text(dob,style: mainBlackHeading,),
                    SizedBox(width: 30,),
                    const Text("Age : ",style: bigTextGreenHeading,),
                    Text(age,style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Phone Number : ",style: bigTextGreenHeading,),
                    Text(phoneNumber,style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("City : ",style: bigTextGreenHeading,),
                    Text(name,style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 24,),
          const Text("Educational Qualification",style: bigTextGreenHeading,),
          Container(
            margin: const EdgeInsets.all(10),
            padding:  EdgeInsets.all(10),
            decoration: limeCard,
            child: Column(
              children: [
                const SizedBox(height: 24,),
                const Text("SSC Details",style: headingInCard,),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical, //Vertical || Horizontal
                      children: <Widget>[
                        const Text("School Name : ",style: bigTextGreenHeading,),
                        Text(sscName,style: mainBlackHeading,),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Board : ",style: bigTextGreenHeading,),
                    Text(sscBoar,style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Passing Year : ",style: bigTextGreenHeading,),
                    Text(sscPassingYear,style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Percenetage : ",style: bigTextGreenHeading,),
                    Text(sscPercentage,style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24,),
                const Text("HSC Details",style: headingInCard,),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical, //Vertical || Horizontal
                      children: <Widget>[
                        const Text("School Name : ",style: bigTextGreenHeading,),
                        Text(sscName,style: mainBlackHeading,),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Board : ",style: bigTextGreenHeading,),
                    Text(sscBoar,style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Passing Year : ",style: bigTextGreenHeading,),
                    Text(sscPassingYear,style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Percenetage : ",style: bigTextGreenHeading,),
                    Text(sscPercentage,style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24,),
                const Text("UG Details",style: headingInCard,),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical, //Vertical || Horizontal
                      children: <Widget>[
                        const Text("College Name : ",style: bigTextGreenHeading,),
                        Text(colName,style: mainBlackHeading,),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("University : ",style: bigTextGreenHeading,),
                    Text(colUni,style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Passing Year : ",style: bigTextGreenHeading,),
                    Text(colPassingYear,style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Percenetage : ",style: bigTextGreenHeading,),
                    Text(colPercentage,style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 24,),
          GestureDetector(
            onTap: (){
              const imageProvider = AssetImage('assets/images/sop.jpg');
              showImageViewer(context, imageProvider, onViewerDismissed: () {
                print("dismissed");
              });
            },
            child: Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(child: Text("SOP",style: bigTextGreenHeading,)),
            ),
          ),
          GestureDetector(
            onTap: (){
              const imageProvider = AssetImage('assets/images/bon.jpg');
              showImageViewer(context, imageProvider, onViewerDismissed: () {
                print("dismissed");
              });
            },
            child:Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(child: Text("Bonafied Letter",style: bigTextGreenHeading,)),
            ),
          ),
          const Text("Aid Information",style: bigTextGreenHeading,),
          Container(
            margin: const EdgeInsets.all(10),
            padding:  EdgeInsets.all(10),
            decoration: limeCard,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Degree : ",style: bigTextGreenHeading,),
                    Text(degree,style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("College Name : ",style: bigTextGreenHeading,),
                    Text(college,style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Total Amount : ",style: bigTextGreenHeading,),
                    Text("$tAmount",style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Required Amount : ",style: bigTextGreenHeading,),
                    Text("$rAmount",style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Center(
            child:ElevatedButton(onPressed: (){

            },

              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFFE9EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child:  Text('Donate',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}



