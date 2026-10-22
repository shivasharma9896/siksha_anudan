import 'package:flutter/material.dart';
import 'constants.dart';

class DonerViewStudent_Page extends StatelessWidget {
  const DonerViewStudent_Page({Key? key, required this.studentProfile})
      : super(key: key);
  final Map<String, dynamic> studentProfile;

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        physics: const BouncingScrollPhysics(),
        children: [
          SizedBox(height: size.height * 0.05),
          CircleAvatar(
            minRadius: 60,
            maxRadius: 70,
            backgroundImage: NetworkImage(studentProfile['photourl']),
          ),
          SizedBox(height: size.height * 0.03),
          const Text(
            "Personal Information",
            style: bigTextGreenHeading,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: limeCard,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Name : ",
                      style: bigTextGreenHeading,
                    ),
                    Text(
                      studentProfile['name'],
                      style: mainBlackHeading,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const Text(
            "Educational Qualification",
            style: bigTextGreenHeading,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: limeCard,
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "SSC Details",
                  style: headingInCard,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical, //Vertical || Horizontal
                      children: <Widget>[
                        const Text(
                          "School Name : ",
                          style: bigTextGreenHeading,
                        ),
                        Text(
                          studentProfile['highschoolcollegename'],
                          style: mainBlackHeading,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Board : ",
                      style: bigTextGreenHeading,
                    ),
                    Text(
                      studentProfile['highschoolboard'],
                      style: mainBlackHeading,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Percentage : ",
                      style: bigTextGreenHeading,
                    ),
                    Text(
                      studentProfile['highschoolpercent'],
                      style: mainBlackHeading,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  "HSC Details",
                  style: headingInCard,
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Wrap(
                      direction: Axis.vertical, //Vertical || Horizontal
                      children: <Widget>[
                        const Text(
                          "School Name : ",
                          style: bigTextGreenHeading,
                        ),
                        Text(
                          studentProfile['intermediatecollegename'],
                          style: mainBlackHeading,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Board : ",
                      style: bigTextGreenHeading,
                    ),
                    Text(
                      studentProfile['intermediateboard'],
                      style: mainBlackHeading,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Percentage : ",
                      style: bigTextGreenHeading,
                    ),
                    Text(
                      studentProfile['intermediatepercent'],
                      style: mainBlackHeading,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const Text(
            "Aid Information",
            style: bigTextGreenHeading,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: limeCard,
            child: Column(
              children: [
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Degree : ",
                      style: bigTextGreenHeading,
                    ),
                    Text(
                      studentProfile['appFor'],
                      style: mainBlackHeading,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Total ₹:   ",
                      style: bigTextGreenHeading,
                    ),
                    Text(
                      studentProfile['amountReq'].toString(),
                      style: mainBlackHeading,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Received ₹:   ",
                      style: bigTextGreenHeading,
                    ),
                    Text(
                      studentProfile['amountRec'].toString(),
                      style: mainBlackHeading,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          const SizedBox(height: 24),
          const Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(
                'Donations are temporarily unavailable while secure payment '
                'verification is being set up.',
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
