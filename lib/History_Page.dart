import 'package:flutter/material.dart';
import 'History_Student_Card.dart';
void main() {
  runApp(const History_Page());
}

class History_Page extends StatelessWidget {
  const History_Page({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    bool isRunning = true;
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
            children: [
              Container(
                width: 400.0,
                height: 60.0,
                decoration: const BoxDecoration(
                  color: Colors.lime,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10)),
                ),
              ),
              const History_Profile_Card(),
              const History_Profile_Card(),
              const History_Profile_Card(),
              const History_Profile_Card(),
              const History_Profile_Card(),
              const History_Profile_Card()

            ]
        ),
      ),
    );
  }
}
