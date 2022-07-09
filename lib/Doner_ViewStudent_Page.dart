import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:siksha_anudan/Doner%20Home.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:siksha_anudan/model/transaction.dart';

import 'model/Donor_model.dart';
class DonerViewStudent_Page  extends StatefulWidget {

  const DonerViewStudent_Page ({Key? key, required this.studentProfile}) : super(key: key);
  final Map<String,dynamic>studentProfile;
  @override
  State<DonerViewStudent_Page> createState() => _DonerViewStudent_Page();
}

class _DonerViewStudent_Page extends State<DonerViewStudent_Page> {
  final _auth=FirebaseAuth.instance;
  late User loggedUser;
  List donerProfile=[];

  Future<List> fetchDoner()async{
    dynamic resultant=await DonorModel().getDoner(loggedUser.email.toString());
    if(resultant==null){
      print("unable to retrieve");
    }
    else{
      setState((){
        donerProfile=resultant;
      });
    }
    return donerProfile;
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser!;
      loggedUser = user;
      print("user email");
      print(loggedUser.email);
    }
    catch (e) {
      print(e);
    }
  }

  late Razorpay razorpay;
  TextEditingController textEditingController=TextEditingController();
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    fetchDoner();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }
  void dispose(){

    super.dispose();
    razorpay.clear();
  }
  void openCheckout(){
    var options={
      "key":"rzp_test_yFfqxNtxEQubn7",
      "amount":num.parse(textEditingController.text)*100,
      "name":"Shiksha Anudaan",
      "description":"Donation for the Student Education",
      "prefill":{
        "contact":donerProfile[0]['phonenum'],
        "email":donerProfile[0]['email']
      },
      "external":{
        "wallet":["paytm"]
      }
    };
    try{
      razorpay.open(options);
    }catch(e){
      print(e.toString());
    }
  }
  void handlerPaymentSuccess(PaymentSuccessResponse response){
    print("Payment Success:$response");
    postDetailsToFirestore(response);
    Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT);
  }
  void handlerErrorFailure(){
    print("Payment Failure");
  }
  void handlerExternalWallet(){
    print("External Wallet");
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 50),
           CircleAvatar(
            minRadius: 60,
            maxRadius: 70,
            backgroundImage: NetworkImage(widget.studentProfile['photourl']),
          ),
          const SizedBox(height: 24,),
          const Text("Personal Information",style: bigTextGreenHeading,),
          Container(
            margin: const EdgeInsets.all(10),
            padding:  EdgeInsets.all(10),
            decoration: limeCard,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Name : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['name'],style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("DOB : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['dob'],style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Phone Number : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['phonenum'],style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Address : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['address'],style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 24,),
          const Text("Educational Qualification",style: bigTextGreenHeading,),
          Container(
            margin: const EdgeInsets.all(10),
            padding:  EdgeInsets.all(10),
            decoration: limeCard,
            child: Column(
              children: [
                const SizedBox(height: 24,),
                const Text("SSC Details",style: headingInCard,),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical, //Vertical || Horizontal
                      children: <Widget>[
                        const Text("School Name : ",style: bigTextGreenHeading,),
                        Text(widget.studentProfile['highschoolcollegename'],style: mainBlackHeading,),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Board : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['highschoolboard'],style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Percentage : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['highschoolpercent'],style: mainBlackHeading,),
                  ],
                ),

                const SizedBox(height: 24,),
                const Text("HSC Details",style: headingInCard,),
                const SizedBox(height: 24,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical, //Vertical || Horizontal
                      children: <Widget>[
                        const Text("School Name : ",style: bigTextGreenHeading,),
                        Text(widget.studentProfile['intermediatecollegename'],style: mainBlackHeading,),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Board : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['intermediateboard'],style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Percentage : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['intermediatepercent'],style: mainBlackHeading,),
                  ],
                ),
                // const SizedBox(height: 24,),
                // const Text("UG Details",style: headingInCard,),
                // const SizedBox(height: 24,),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Wrap(
                //       direction: Axis.vertical, //Vertical || Horizontal
                //       children: <Widget>[
                //         const Text("College Name : ",style: bigTextGreenHeading,),
                //         Text(colName,style: mainBlackHeading,),
                //       ],
                //     ),
                //   ],
                // ),
                //
                // const SizedBox(height: 24),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Text("University : ",style: bigTextGreenHeading,),
                //     Text(colUni,style: mainBlackHeading,),
                //   ],
                // ),
                //
                // const SizedBox(height: 24),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Text("Passing Year : ",style: bigTextGreenHeading,),
                //     Text(colPassingYear,style: mainBlackHeading,),
                //   ],
                // ),
                // const SizedBox(height: 24),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Text("Percentage : ",style: bigTextGreenHeading,),
                //     Text(colPercentage,style: mainBlackHeading,),
                //   ],
                // ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 24,),
          GestureDetector(
            onTap: (){
               var imageProvider = NetworkImage(widget.studentProfile['aadharurl'].toString());
              showImageViewer(context, imageProvider, onViewerDismissed: () {
                print("dismissed");
              });
            },
            child: Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(child: Text("SOP",style: bigTextGreenHeading,)),
            ),
          ),
          GestureDetector(
            onTap: (){
              var imageProvider = NetworkImage(widget.studentProfile['signurl'].toString());
              showImageViewer(context, imageProvider, onViewerDismissed: () {
                print("dismissed");
              });
            },
            child:Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: const Center(child: Text("Bonafied Letter",style: bigTextGreenHeading,)),
            ),
          ),
          const Text("Aid Information",style: bigTextGreenHeading,),
          Container(
            margin: const EdgeInsets.all(10),
            padding:  EdgeInsets.all(10),
            decoration: limeCard,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Degree : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['appFor'],style: mainBlackHeading,),
                  ],
                ),
                //const SizedBox(height: 24),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     const Text("College Name : ",style: bigTextGreenHeading,),
                //     Text(college,style: mainBlackHeading,),
                //   ],
                // ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Total Amount : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['amountReq'].toString(),style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text("Received Amount : ",style: bigTextGreenHeading,),
                    Text(widget.studentProfile['amountRec'].toString(),style: mainBlackHeading,),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),

          const SizedBox(height: 24),
          Center(
            child:ElevatedButton(onPressed: (){
              opendialog();
            },

              style: ElevatedButton.styleFrom(
                primary: const Color(0xFFFFE9EF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child:  Text('Donate',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
  Future opendialog()=> showDialog(
    context:context,
    builder:(context)=> AlertDialog(
      title:Center(child: Text('Donate')),
      content:
        TextFormField(
        controller: textEditingController,
        decoration: const InputDecoration(hintText: 'Enter Amount'),
          keyboardType: TextInputType.number,
      ),
      actions: [
        TextButton(
          child: Text('Pay'),
          onPressed: () {
            openCheckout();
          },
        ),
      ],
    ),
  );
  postDetailsToFirestore(PaymentSuccessResponse response) async{
    //calling our firestore
    //calling our model
    //sending these values
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DateTime dateTime = DateTime.now();
    String day = dateTime.toIso8601String().split('T').first;

    transaction tr = transaction(
      donoremail:donerProfile[0]['email'] ,
      studemail: widget.studentProfile['email'],
      donatedamt: textEditingController.text,
      tranid: response.paymentId,
      sname: widget.studentProfile['name'],
      dname: donerProfile[0]['name'],
      date: day
    );
    await firebaseFirestore
        .collection("transaction")
        .doc(tr.tranid)
        .set(tr.toMap());
    Fluttertoast.showToast(msg: "Account created successfully!");
    var db = FirebaseFirestore.instance;
    db.collection("Student").doc(widget.studentProfile['uid']).update({'amountRec':widget.studentProfile['amountRec']+int.parse(textEditingController.text)
    });
    Navigator.pop(context);
    setState((){

    });
    //Navigator.pushNamed(this.context,'/d-home');
    // Navigator.push(this.context, MaterialPageRoute(builder: (context) => DonerHome()));
    //Navigator.pushAndRemoveUntil((context), MaterialPageRoute(builder: (context) => DonerHome()), (route) => false);
  }

}



