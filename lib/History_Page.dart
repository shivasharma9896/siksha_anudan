
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:siksha_anudan/History_Student_Card.dart';

import 'model/transaction.dart';

class HistoryPage extends StatefulWidget {

  HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  final _auth=FirebaseAuth.instance;
  late User loggedUser;
  List translist=[];
  void getCurrentUser()async{
    try{
      final user=_auth.currentUser!;
      loggedUser=user;
      print("user email history");
      print(loggedUser.email);
    }
    catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    fetchtransList();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }
  Future<List> fetchtransList()async{
    dynamic resultant=await transaction().gettransList(loggedUser.email.toString());
    if(resultant==null){
      print("unable to retrieve");
    }
    else{
      setState((){
        translist=resultant;
      });
    }
    return translist;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  Container(
            child: ListView.builder(itemCount: translist.length,itemBuilder: (context,index){
              return History_Profile_Card(transdetail: translist[index],);
            })));
  }
}

