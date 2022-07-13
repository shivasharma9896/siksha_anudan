
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siksha_anudan/History_Student_Card.dart';

class HistoryPage extends StatefulWidget {

  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _auth=FirebaseAuth.instance;
  late User loggedUser;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;
  void getCurrentUser()async{
    try{
      final user=_auth.currentUser!;
      loggedUser=user;
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  StreamBuilder(
          stream: _firestore.collection("transaction").where('DonorEmail',isEqualTo: loggedUser.email.toString()).snapshots(),
          builder:  (context, snapshot){
            if(!snapshot.hasData){
              return Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.lightBlueAccent,
                ),
              );
            }
            final messages=snapshot.data!.docs;
            List<History_Profile_Card> translist=[];
            for (var message in messages){
              Map<String,dynamic> trans=message.data();
              translist.add(History_Profile_Card(transdetail: trans));
            }
            return ListView(
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 20),
              children: translist,
            );
          },
        ));
  }
}

