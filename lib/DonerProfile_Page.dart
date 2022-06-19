import 'dart:ffi';

import 'package:flutter/material.dart';
import 'BottomNav.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'constants.dart';
import 'TextFieldWidget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DonerProfile_Page  extends StatefulWidget {

  const DonerProfile_Page ({Key? key}) : super(key: key);

  @override
  State<DonerProfile_Page> createState() => _DonerProfile_Page();
}

class _DonerProfile_Page extends State<DonerProfile_Page> {
  final _auth=FirebaseAuth.instance;
  bool status=false;
  String name="Kendal Jenner";
  String email="Kendal@gmail.com";
  String phoneNumber="900695306";
  String aadhar="7120 1234 1241";
  String panCard="HPLT2453H";
  String address="8420 Melrose Avenue, West Hollywood, CA 90069-5306 United States";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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

          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(width: 150,),
              Text("Editable ",style: bigTextGreenHeading,),
              SizedBox(width: 10,),
              FlutterSwitch(
                activeColor: Colors.lime,
                width: 60.0,
                height: 40.0,
                valueFontSize: 15.0,
                toggleSize: 15.0,
                value: status,
                borderRadius: 30.0,
                padding: 8.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    status = val;
                  });
                },
              )
            ],
          ),
          TextFieldWidget(
            label: 'Full Name',
            text:name,
            onChanged: (name) {}, enabled: false,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Aadhar Number',
            text:aadhar,
            onChanged: (aadhar) {}, enabled: false,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Pan Card Number',
            text:panCard,
            onChanged: (panCard) {}, enabled: false,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            enabled: status,
            label: 'Email',
            text: email,
            onChanged: (value) {
              email=value;
            },
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            enabled: status,
            label: 'Phone Number',
            text: phoneNumber,
            onChanged: (value) {
              phoneNumber=value;
            },
          ),

          const SizedBox(height: 24),
          TextFieldWidget(
            enabled: status,
            label: 'Address',
            text: address,
            maxLines: 5,
            onChanged: (value) {
              address=value;
            },
          ),
          const SizedBox(height: 24),
          Center(
            child:ElevatedButton(onPressed: () async{
              if(status==true){
              print(name+" "+email+" "+panCard+" "+phoneNumber+" "+address);
              }

            },

              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFFE9EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child:  Text('Save Changes',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),
          Center(
            child:ElevatedButton(onPressed: () async{
              _auth.signOut();
              Navigator.pop(context);
            },

              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFFE9EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child:  Text('Log Out',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



