import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel{
  final CollectionReference profilelist= FirebaseFirestore.instance.collection('Student');
  String? uid;
  String? name;
  String? email;
  String? phonenum;
  String? address;
  String? aadharC;
  //String? password;
  String? highschoolcollegename;
  String? highschoolboard;
  String? highschoolpercent;
  String? intermediatecollegename;
  String? intermediateboard;
  String? intermediatepercent;
  String? photourl;
  String? signurl;
  String? aadharurl;
  String? dob;
  String? appFor;
  int? amountReq;
  int? amountRec;
  String? status;
  String? income;

  StudentModel({this.uid, this.name, this.email, this.phonenum, this.address, this.aadharC, this.highschoolcollegename,
    this.highschoolboard,this.highschoolpercent,this.intermediatecollegename, this.intermediateboard,
    this.intermediatepercent, this.photourl, this.signurl, this.aadharurl, this.dob, this.amountReq,this.appFor,this.status, this.amountRec,this.income});

  //Reciving data from firebase
  factory StudentModel.fromMap(map){
    return StudentModel(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        phonenum: map['phonenum'],
        address: map['address'],
        aadharC: map['aadharC'],
        //  password: map['password'],
        highschoolcollegename: map['highschoolcollegename'],
        highschoolboard: map['highschoolboard'],
        highschoolpercent: map['highschoolpercent'],
        intermediatecollegename: map['intermediatecollegename'],
        intermediateboard: map['intermediateboard'],
        intermediatepercent: map['intermediatepercent'],
        photourl: map['photourl'],
        signurl: map['signurl'],
        aadharurl: map['aadharurl'],
        dob: map['dob'],
        appFor: map['appFor'],
        amountReq: map['amountReq']
        , amountRec: map['amountRec'],
        status: map['status'],
        income:map['income']
    );
  }
  Future getStudentList()async{
    List studentlist=[];
    try{
      await profilelist.where('status',isEqualTo: "approved").get().then((querySnapshot){
        querySnapshot.docs.forEach((element){
          studentlist.add(element.data());
          //print(element.data);
        });
      });
      return studentlist;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  Future getStudent(String em)async{
    List student=[];
    try{
      await profilelist.where('email',isEqualTo: em).get().then((querySnapshot){
        querySnapshot.docs.forEach((element){
          student.add(element.data());
        });
      });
      return student;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
  //Sending data to firebase
  Map<String, dynamic> toMap(){
    return{
      'uid': uid,
      'name': name,
      'email': email,
      'phonenum': phonenum,
      'address': address,
      //  'password': password,
      'highschoolcollegename': highschoolcollegename,
      'highschoolboard': highschoolboard,
      'highschoolpercent': highschoolpercent,
      'intermediatecollegename': intermediatecollegename,
      'intermediateboard': intermediateboard,
      'intermediatepercent': intermediatepercent,
      'photourl': photourl,
      'signurl': signurl,
      'aadharurl': aadharurl,
      'dob': dob,
      'amountReq':amountReq,
      'appFor':appFor,
      'amountRec':amountRec,
      'status':status,
      'aadharC':aadharC,
      'income':income
    };
  }

}
