import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:siksha_anudan/constants.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ForgetPass_Page extends StatefulWidget {
  const ForgetPass_Page({Key? key}) : super(key: key);

  @override
  State<ForgetPass_Page> createState() => _ForgetPass_PageState();
}

class _ForgetPass_PageState extends State<ForgetPass_Page> {
  final _auth = FirebaseAuth.instance;
  String email = "";
  bool showspinner = false;
  static const String logo = 'assets/images/siksha_logo.svg';
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showspinner,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SvgPicture.asset(
                  logo,
                  width: 350,
                  height: 350,
                  semanticsLabel: 'Logo',
                ),
              ),
              const Center(
                child: Text("Forgot Password", style: bigTextGreenHeading),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Email", style: textLimeheading),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      onChanged: (value) {
                        email = value;
                      },
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        hintStyle: const TextStyle(color: Colors.green),
                        contentPadding: const EdgeInsets.all(15),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        fillColor: const Color(0xFFFFE9EF),
                        filled: true,
                      ),
                      style: const TextStyle(
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          setState(() {
                            showspinner = true;
                          });
                          try {
                            await _auth.sendPasswordResetEmail(
                                email: email.trim());
                            if (!mounted) {
                              return;
                            }
                            await showDialog<void>(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: const Text("Forgot Password"),
                                content: const Text(
                                  'Password reset instructions have been sent to email!',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text("OK"),
                                  ),
                                ],
                              ),
                            );
                          } on FirebaseAuthException catch (error) {
                            if (!mounted) {
                              return;
                            }
                            final message = error.code == 'user-not-found'
                                ? 'No account was found for this email.'
                                : 'Unable to send the password reset email.';
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } finally {
                            if (mounted) {
                              setState(() {
                                showspinner = false;
                              });
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: const Color(0xFFFFE9EF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Send Email',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 120,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.lime,
                ),
                width: 400.0,
                height: 80.0,
                alignment: Alignment.center, // align your child's position.
              ),
            ],
          ),
        ),
      ),
    );
  }
}
