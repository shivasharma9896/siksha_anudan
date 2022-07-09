import 'package:cloud_firestore/cloud_firestore.dart';

class transaction{
  final CollectionReference profilelist= FirebaseFirestore.instance.collection('transaction');
  String? donoremail;
  String? studemail;
  String? donatedamt;
  String? tranid;
  String? dname;
  String? sname;
  String? date;
  transaction({
    this.donoremail,this.studemail,this.donatedamt,this.tranid,this.dname,this.sname,this.date
});
  Future gettransList(String em)async{
    List translist=[];
    try{
      await profilelist.where('DonorEmail',isEqualTo: em).get().then((querySnapshot){
        querySnapshot.docs.forEach((element){
          translist.add(element.data());
        });
      });
      return translist;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  factory transaction.fromMap(map){
    return transaction(
        donoremail: map['DonorEmail'],
        studemail: map['StudentEmail'],
        donatedamt: map['DonatedAmount'],
        tranid: map['TransId'],
        dname:map['DonorName'],
        sname:map['StudentName'],
      date: map['date']
    );
  }
  Map<String, dynamic> toMap(){
    return{
      'DonorEmail': donoremail,
      'StudentEmail': studemail,
      'DonatedAmount': donatedamt,
      'TransId': tranid ,
      'DonorName': dname,
      'StudentName':sname,
      'date':date
    };
  }

}