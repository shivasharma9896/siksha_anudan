import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siksha_anudan/Profile_card.dart';

class SearchStudent_Page extends StatefulWidget {

  SearchStudent_Page({Key? key}) : super(key: key);

  @override
  State<SearchStudent_Page> createState() => _SearchStudentPage();
}

class _SearchStudentPage extends State<SearchStudent_Page> {
  final _auth = FirebaseAuth.instance;
  String income="All";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }


  @override
  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    FirebaseFirestore _firestore=FirebaseFirestore.instance;
    return Scaffold(
        backgroundColor: Colors.white,
        body:  SafeArea(
          child: Column(
            children: [
              SizedBox(height: size.height*0.04,),
              Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: size.width*0.15,),
                Text("Income : ",style: TextStyle(fontSize: 20,color: Colors.grey[700]),),
                SizedBox(width: size.width*0.05,),
                 Expanded(
                   child: SizedBox(
                      height: size.height*0.04,
                        width: size.width*0.1,
                        child:DropdownButton<String>(
                          style: TextStyle(fontSize: 20,color: Colors.green),
                          value: income,
                          // Step 4.
                          items: <String> ["All","Below 1,00,000",
                            "1,00,000 - 3,00,000",
                            "4,00,000 - 7,00,000",
                            "7,00,000 - 10,00,000"]
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(fontSize: 20),
                              ),
                            );
                          }).toList(),
                          // Step 5.
                          onChanged: (String? newValue) {
                            setState(() {
                              income = newValue!;
                            });
                          },
                        )

                ),
                 ),
              ],),
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
                    if(income=="All"){
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



