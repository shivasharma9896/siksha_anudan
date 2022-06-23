import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'constants.dart';
class Search_Profile_Card extends StatefulWidget {
  const Search_Profile_Card({Key? key}) : super(key: key);

  @override
  State<Search_Profile_Card> createState() => _Search_Profile_CardState();
}

class _Search_Profile_CardState extends State<Search_Profile_Card> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/student-profile');
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
                      const CircleAvatar(
                        minRadius: 30,
                        maxRadius: 40,
                        backgroundImage: AssetImage('assets/images/profile.jpg'),
                      ),
                      const SizedBox(height: 10,),
                      LinearPercentIndicator(
                        width: 100,
                        lineHeight: 20,
                        center: const Text('50%'),
                        progressColor: Colors.lightGreen,
                        percent: .5,
                        barRadius: const Radius.elliptical(10, 10),
                        animation: true,
                        animationDuration: 5000,
                      ),
                    ],
                  ),
                  const SizedBox(width: 70,),
                  Column(
                    children: [
                      const Text("Kendal Jenner",style:mainBlackHeading),
                      const SizedBox(height: 15,),
                      Row(
                        children: const [
                          Text("Qualification : ",style:smallBlackHeading),
                          Text("BCA"),
                        ],
                      ),
                      Row(
                        children: const [
                          Text("Applied For : ",style: smallBlackHeading),
                          Text("BCA"),
                        ],
                      ),
                      Row(
                        children: const [
                          Text("Aid Amount : ", style: smallBlackHeading),
                          Text("Rs. 1,00,0000"),
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

