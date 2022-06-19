import 'package:flutter/material.dart';
import 'package:siksha_anudan/Doner%20Home.dart';
import 'package:siksha_anudan/History_Page.dart';
import 'package:siksha_anudan/Login_Page.dart';
import 'package:siksha_anudan/StudentCurrentProgress_Page.dart';
import 'Login_Page.dart';
import 'Search_Student_Page.dart';
import 'BottomNav.dart';
import 'Home_Page.dart';
import 'ForgetPassword.dart';
import 'Registration_Student_Page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'DonerProfile_Page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
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
        '/login': (context) =>  Login_Page(),
        '/registration': (context) =>  Registration_Student(),
        '/profile': (context) =>  DonerProfile_Page(),
        '/d-home': (context) =>  DonerHome(),
        '/forgot-pass': (context) =>  ForgetPass_Page(),
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: StudentCurrentPage(),
    );
  }
}
