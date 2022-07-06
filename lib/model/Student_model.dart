class StudentModel{
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

  StudentModel({this.uid, this.name, this.email, this.phonenum, this.address, this.aadharC, this.highschoolcollegename,
    this.highschoolboard,this.highschoolpercent,this.intermediatecollegename, this.intermediateboard,
    this.intermediatepercent, this.photourl, this.signurl, this.aadharurl, this.dob});

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
      dob: map['dob']
    );
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
    };
  }

}
