class DonorModel{
  String? uid;
  String? name;
  String? email;
  String? phonenum;
  String? address;
  //String? password;
  String? aadharC;
  String? pancard;
  String? photourl;
  String? signurl;
  String? aadharurl;
  String? dob;

  DonorModel({this.uid, this.name, this.email, this.phonenum, this.address, this.aadharC, this.pancard, this.photourl, this.signurl, this.aadharurl, this.dob});

  //Reciving data from firebase
  factory DonorModel.fromMap(map){
    return DonorModel(
      uid: map['uid'],
      name: map['name'],
      email: map['email'],
      phonenum: map['phonenum'],
      address: map['address'],
    //  password: map['password'],
      aadharC: map['aadharC'],
      pancard: map['pancard'],
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
      'aadharC': aadharC,
      'pancard': pancard,
      'photourl': photourl,
      'signurl': signurl,
      'aadharurl': aadharurl,
      'dob': dob
    };
  }

}
