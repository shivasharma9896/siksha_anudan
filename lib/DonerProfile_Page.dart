
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'constants.dart';
import 'TextFieldWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'model/Donor_model.dart';

class DonerProfile_Page  extends StatefulWidget {

  const DonerProfile_Page ({Key? key}) : super(key: key);

  @override
  State<DonerProfile_Page> createState() => _DonerProfile_Page();
}

class _DonerProfile_Page extends State<DonerProfile_Page> {
  final _auth=FirebaseAuth.instance;
  bool status=false;
  late User loggedUser;
  List donerProfile=[];
  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchDoner();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }
  Future<List> fetchDoner()async{
    dynamic resultant=await DonorModel().getDoner(loggedUser.email.toString());
    if(resultant==null){
      print("unable to retrieve");
    }
    else{
      setState((){
        donerProfile=resultant;
      });
    }
    return donerProfile;
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser!;
      loggedUser = user;
      print("user email profile");
      print(loggedUser.email);
    }
    catch (e) {
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    String phoneNumber=donerProfile[0]['phonenum'].toString();
    String address=donerProfile[0]['address'];
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 50),
          Container(
            height: 200,
            width: 200,
            child:  CircleAvatar(
              minRadius: 30,
              maxRadius: 100,
              backgroundImage: NetworkImage(donerProfile[0]['photourl'].toString()),
            ),
          ),

          const SizedBox(height: 24),
          Row(
            children: [
              const SizedBox(width: 150,),
              const Text("Editable ",style: bigTextGreenHeading,),
              const SizedBox(width: 10,),
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
            text:donerProfile[0]['name'],
            onChanged: (name) {}, enabled: false,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Aadhar Number',
            text:donerProfile[0]['aadharC'],
            onChanged: (aadhar) {}, enabled: false,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            label: 'Pan Card Number',
            text:donerProfile[0]['pancard'],
            onChanged: (panCard) {}, enabled: false,
          ),
          const SizedBox(height: 24),
          TextFieldWidget(
            enabled: false,
            label: 'Email',
            text: donerProfile[0]['email'],
            onChanged: (value) {
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
                var db = FirebaseFirestore.instance;
                db.collection("Donor").doc(donerProfile[0]['uid']).update({'phonenum': phoneNumber,'address':address});
                setState((){
                  status=false;
                });
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



