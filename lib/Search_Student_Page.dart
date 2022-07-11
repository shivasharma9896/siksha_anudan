
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:drop_down_list/drop_down_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siksha_anudan/Profile_card.dart';

import 'constants.dart';
class SearchStudent_Page extends StatefulWidget {

  SearchStudent_Page({Key? key}) : super(key: key);

  @override
  State<SearchStudent_Page> createState() => _SearchStudentPage();
}

class _SearchStudentPage extends State<SearchStudent_Page> {
  final _auth = FirebaseAuth.instance;
  String income="";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }


  @override
  Widget build(BuildContext context) {
    final TextEditingController incomefil=TextEditingController();
    FirebaseFirestore _firestore=FirebaseFirestore.instance;
    return Scaffold(
        backgroundColor: Colors.white,
        body:  SafeArea(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Container(
                width: 200,
                  child:CustomDropdown(
                    // fillColor: Colors.alabaster,
                    borderRadius: BorderRadius.circular(5),
                    hintText: "Income",
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                    ),
                    items: const ["Below 1,00,000",
                        "1,00,000 - 3,00,000",
                        "4,00,000 - 7,00,000",
                        "7,00,000 - 10,00,000"],
                    controller: incomefil,
                    onChanged: (value){
                      setState((){
                        income=value;
                      });
                    },
                  ),),
              Expanded(child: StreamBuilder(
                stream: _firestore.collection("Student").where('status',isEqualTo: "approved").snapshots(),
                builder:  (context, snapshot){
                  if(!snapshot.hasData){
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    );
                  }
                  final messages=snapshot.data!.docs;
                  List<Search_Profile_Card> studentlist=[];
                  for (var message in messages){
                    Map<String,dynamic> student=message.data();
                    if(income==""){
                        studentlist.add(Search_Profile_Card(studentProfileList: student));
                    }
                    else{
                      if(message.data()['income']==income){
                        studentlist.add(Search_Profile_Card(studentProfileList: student));
                      }
                    }
                  }
                  return ListView(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                    children: studentlist,
                  );
                },
              )),
            ],
          ),
        )
    );
  }
}



