class transaction{
  String? donoremail;
  String? studemail;
  String? donatedamt;
  String? tranid;
  String? dname;
  String? sname;
  transaction({
    this.donoremail,this.studemail,this.donatedamt,this.tranid,this.dname,this.sname
});
  factory transaction.fromMap(map){
    return transaction(
        donoremail: map['DonarEmail'],
        studemail: map['StudentEmail'],
        donatedamt: map['DonatedAmount'],
        tranid: map['TransId'],
        dname:map['DonorName'],
        sname:map['StudentName'],
    );
  }
  Map<String, dynamic> toMap(){
    return{
      'DonarEmail': donoremail,
      'StudentEmail': studemail,
      'DonatedAmount': donatedamt,
      'TransId': tranid ,
      'DonorName': dname,
      'StudentName':sname,

    };
  }

}