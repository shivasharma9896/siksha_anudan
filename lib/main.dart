import 'package:flutter/material.dart';
import 'package:siksha_anudan/Doner%20Home.dart';
import 'package:siksha_anudan/home_page.dart';
import 'package:siksha_anudan/Login_Page.dart';
import 'package:siksha_anudan/Registration_Donar_Page.dart';
import 'ForgetPassword.dart';
import 'registration_student_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'DonerProfile_Page.dart';
import 'StudentHome_Page.dart';
import 'StudentLogin.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  const useFirebaseEmulators = bool.fromEnvironment('USE_FIREBASE_EMULATORS');
  if (useFirebaseEmulators) {
    const emulatorHost = '10.0.2.2';
    await FirebaseAuth.instance.useAuthEmulator(emulatorHost, 9099);
    FirebaseFirestore.instance.useFirestoreEmulator(emulatorHost, 8080);
    await FirebaseStorage.instance.useStorageEmulator(emulatorHost, 9199);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shiksha Anudan',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      //initialRoute: '/',
      routes: {
        '/login': (context) => const Login_Page(),
        '/s-login': (context) => const SLogin_Page(),
        '/s-registration': (context) => const RegistrationStudent(),
        '/d-registration': (context) => const Registration_Donor(),
        '/profile': (context) => const DonerProfile_Page(),
        '/d-home': (context) => const DonerHome(),
        '/s-home': (context) => const StudentHome(),
        '/forgot-pass': (context) => const ForgetPass_Page(),
        //'/student-profile': (context) =>  const DonerViewStudent_Page(),
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
    return const Scaffold(
      backgroundColor: Colors.white,
      body: HomePage(),
    );
  }
}
