import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:siksha_anudan/constants.dart';

import 'model/Student_model.dart';
class History_Profile_Card extends StatefulWidget {
  const History_Profile_Card({Key? key, required this.transdetail }) : super(key: key);
  final Map<String,dynamic> transdetail;
  @override
  State<History_Profile_Card> createState() => _History_Profile_CardState();
}

class _History_Profile_CardState extends State<History_Profile_Card> {
  List studentProfile=[];
  @override
  void initState() {
    super.initState();
    fetchStudent();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => (context));
  }
  Future<List> fetchStudent()async{
    dynamic resultant=await StudentModel().getStudent(widget.transdetail['StudentEmail']);
    if(resultant==null){
      print("unable to retrieve");
    }
    else{
      setState((){
        print(widget.transdetail['StudentEmail']);
        studentProfile=resultant;
      });
    }
    return studentProfile;
  }
  @override
  Widget build(BuildContext context) {
    double percent=(studentProfile[0]['amountRec']/studentProfile[0]['amountReq'] *100) ;
    int per=percent.round();
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.only(top: 10),
      height: 125,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey[200],
      ),
      child: Column(
        children:[
          Row(
            children:  [
              Column(
                children: [
                   CircleAvatar(
                    minRadius: 30,
                    maxRadius: 40,
                    backgroundImage: NetworkImage(studentProfile[0]['photourl'].toString()),
                  ),
                  const SizedBox(height: 10,),
                  LinearPercentIndicator(
                    width: 100,
                    lineHeight: 20,
                    center:  Text('$per%'),
                    progressColor: Colors.lightGreen,
                    percent: per/100,
                    barRadius: const Radius.elliptical(10, 10),
                    animation: true,
                    animationDuration: 5000,
                  ),
                ],
              ),
              const SizedBox(width: 50,),
              Column(
                children: [
                   Text(studentProfile[0]['name'],style:mainBlackHeading),
                  const SizedBox(height: 15,),
                  Row(
                    children:  [
                      Text("Total Donations : ", style: smallBlackHeading),
                      Text(studentProfile[0]['amountRec'].toString()),
                    ],
                  ),
                  Row(
                    children:  [
                      Text("Total Aid Required : ", style:smallBlackHeading),
                      Text(studentProfile[0]['amountReq'].toString()),
                    ],
                  ),
                  Row(
                    children:  [
                      Text("My Contribution : ", style:smallBlackHeading),
                      Text(widget.transdetail['DonatedAmount'].toString()),
                    ],
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

