import 'package:flutter/material.dart';
import 'package:siksha_anudan/Doner%20Home.dart';
import 'package:siksha_anudan/Doner_ViewStudent_Page.dart';
import 'package:siksha_anudan/Home_Page.dart';
import 'package:siksha_anudan/Login_Page.dart';
import 'package:siksha_anudan/Registration_Donar_Page.dart';
import 'Login_Page.dart';
import 'ForgetPassword.dart';
import 'Registration_Student_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'DonerProfile_Page.dart';
import 'StudentHome_Page.dart';
import 'StudentLogin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //initialRoute: '/',
      routes: {
        '/login': (context) =>  const Login_Page(),
        '/s-login': (context) =>  const SLogin_Page(),
        '/s-registration': (context) =>  const Registration_Student(),
        '/d-registration': (context) =>  const Registration_Donor(),
        '/profile': (context) =>  const DonerProfile_Page(),
        '/d-home': (context) =>  const DonerHome(),
        '/s-home':(context) =>  const StudentHome(),
        '/forgot-pass': (context) =>  const ForgetPass_Page(),
        '/student-profile': (context) =>  const DonerViewStudent_Page(),
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Home_Page(),
    );
  }
}
