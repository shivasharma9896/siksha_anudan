class DonorModel{
  String? uid;
  String? name;
  String? email;
  String? phonenum;
  String? address;
  //String? password;
  String? aadharC;
  String? pancard;

  DonorModel({this.uid, this.name, this.email, this.phonenum, this.address, this.aadharC, this.pancard});

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
    };
  }

}
