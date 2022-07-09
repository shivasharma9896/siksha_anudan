import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:siksha_anudan/Doner_ViewStudent_Page.dart';
import 'constants.dart';
class Search_Profile_Card extends StatefulWidget {
  const Search_Profile_Card( {Key? key, required this.studentProfileList}) : super(key: key);
  final Map<String,dynamic>studentProfileList;
  @override
  State<Search_Profile_Card> createState() => _Search_Profile_CardState();
}

class _Search_Profile_CardState extends State<Search_Profile_Card> {
  @override
  Widget build(BuildContext context) {
    double percent=(widget.studentProfileList['amountRec']/widget.studentProfileList['amountReq'] *100) ;
    int per=percent.round();
    return GestureDetector(
      onTap: (){
        Navigator.push(this.context, MaterialPageRoute(builder: (context) => DonerViewStudent_Page(studentProfile: widget.studentProfileList,)));
      },
      child: Container(
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
                        backgroundImage: NetworkImage(widget.studentProfileList['photourl'].toString()),
                      ),
                      const SizedBox(height: 10,),
                      LinearPercentIndicator(
                        width: 100,
                        lineHeight: 20,
                        center: Text ("$per%"),
                        progressColor: Colors.lightGreen,
                        percent:per/100,
                        barRadius: const Radius.elliptical(10, 10),
                        animation: true,
                        animationDuration: 5000,
                      ),
                    ],
                  ),
                  const SizedBox(width: 70,),
                  Column(
                    children: [
                       Text(widget.studentProfileList['name'],style:mainBlackHeading),
                      const SizedBox(height: 15,),
                      Row(
                        children:  [
                          Text("Applied For : ",style: smallBlackHeading),
                          Text(widget.studentProfileList['appFor']),
                        ],
                      ),
                      Row(
                        children:  [
                          Text("Aid Amount : ", style: smallBlackHeading),
                          Text(widget.studentProfileList['amountReq'].toString()),
                        ],
                      ),
                      Row(
                        children:  [
                          Text("Aid Received : ", style: smallBlackHeading),
                          Text(widget.studentProfileList['amountRec'].toString()),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
    );
  }
}

