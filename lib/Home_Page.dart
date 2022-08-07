import'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Home_Page extends StatelessWidget{
  static const String logo = 'assets/images/siksha_logo.svg';
  @override

  Widget build(BuildContext context) {
    final size=MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
         SizedBox(height: size.height*0.1,
        ),
      SvgPicture.asset(
      logo,
      semanticsLabel: 'Logo',
      ),
        SizedBox(height: size.height*0.1,
        ),
      Expanded(
      child: Container(
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      color: Colors.lime,
      ),
      child: Column(
      children:  [
      const Padding(
      padding: EdgeInsets.only(top: 20),
      child: Text("Welcome",style:
      TextStyle(
      color: Colors.green,
      fontSize: 40.0,
      fontWeight: FontWeight.w600,
      ),
      ),
      ),
      const Padding(
      padding: EdgeInsets.fromLTRB(100, 30, 100,20),
      child: Text("We connects Students with the Donor, which helps them to raise fund to continue their studies.",
      style: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Colors.green,
      ),
      ),
      ),
      Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      ElevatedButton(onPressed: () {
        Navigator.pushNamed(context, '/login');
      },
      style: ElevatedButton.styleFrom(
      primary: const Color(0xFFFFE9EF),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      ),
      ),
      child: const Padding(
      padding: EdgeInsets.all(10),
      child:  Text('Donor',
      style: TextStyle(
      color: Colors.green,
      fontSize: 20,
      ),
      ),
      ),
      ),
      const SizedBox(width: 30.0),
      ElevatedButton(onPressed: () {
        Navigator.pushNamed(context, '/s-login');
      },
      style: ElevatedButton.styleFrom(
      primary: const Color(0xFFFFE9EF),
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
      ),
      ),
      child: const Padding(
      padding: EdgeInsets.all(10),
      child: Text('Student',
      style: TextStyle(
      color: Colors.green,
      fontSize: 20,
      ),
      ),
      ),
      ),
      ],
      ),
      ],
      ),
      ),
      ),
      ],
      ),
    );
  }
}