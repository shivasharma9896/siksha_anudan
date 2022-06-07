import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
class Search_Profile_Card extends StatefulWidget {
  const Search_Profile_Card({Key? key}) : super(key: key);

  @override
  State<Search_Profile_Card> createState() => _Search_Profile_CardState();
}

class _Search_Profile_CardState extends State<Search_Profile_Card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
        padding: EdgeInsets.only(top: 10),
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
                      backgroundImage: AssetImage('assets/images/profile.jpg'),
                    ),
                    SizedBox(height: 10,),
                    LinearPercentIndicator(
                      width: 100,
                      lineHeight: 20,
                      center: Text('50%'),
                      progressColor: Colors.lightGreen,
                      percent: .5,
                      barRadius: Radius.elliptical(10, 10),
                      animation: true,
                      animationDuration: 5000,
                    ),
                  ],
                ),
                const SizedBox(width: 70,),
                Column(
                  children: [
                    Text("Kendal Jenner",style:
                      TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700
                      ),),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Text("Qualification : ",
                          style:
                          TextStyle(
                            fontSize: 17,
                          fontWeight: FontWeight.w700
                          ),),
                        Text("BCA"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Applied For : ",
                          style:
                          TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700
                          ),),
                        Text("BCA"),
                      ],
                    ),
                    Row(
                      children: [
                        Text("Aid Amount : ",
                          style:
                          TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700
                          ),),
                        Text("Rs. 1,00,0000"),
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

