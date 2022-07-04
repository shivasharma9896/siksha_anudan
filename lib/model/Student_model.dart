class StudentModel{
  String? uid;
  String? name;
  String? email;
  String? phonenum;
  String? address;
  //String? password;
  String? highschoolcollegename;
  String? highschoolboard;
  String? highschoolpercent;
  String? intermediatecollegename;
  String? intermediateboard;
  String? intermediatepercent;

  StudentModel({this.uid, this.name, this.email, this.phonenum, this.address, this.highschoolcollegename,
    this.highschoolboard,this.highschoolpercent,this.intermediatecollegename, this.intermediateboard,
    this.intermediatepercent});

  //Reciving data from firebase
  factory StudentModel.fromMap(map){
    return StudentModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phonenum: map['phonenum'],
      address: map['address'],
      //  password: map['password'],
      highschoolcollegename: map['highschoolcollegename'],
      highschoolboard: map['highschoolboard'],
      highschoolpercent: map['highschoolpercent'],
      intermediatecollegename: map['intermediatecollegename'],
      intermediateboard: map['intermediateboard'],
      intermediatepercent: map['intermediatepercent']
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
    };
  }

}
