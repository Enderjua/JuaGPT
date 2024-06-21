// ignore_for_file: file_names, unnecessary_const, unused_import, no_leading_underscores_for_local_identifiers

import 'package:JuaGPT/backend/FirebaseAuth.dart';
import 'package:JuaGPT/components/codeInput.dart';
import 'package:JuaGPT/screens/homeScreen.dart';
import 'package:JuaGPT/screens/loginScreen.dart';
import 'package:JuaGPT/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

import '../components/textInput.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  AuthFirebase _authFirebase = AuthFirebase();
  TextEditingController _emailController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xFF151515),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Container(),
            ),
            const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Bu özelliği ekleyin
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 11.0),
                  child: Text(
                    'Password reset to your account ✨',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 11.0, top: 5.0),
                    child: Text(
                      'Please enter your details.',
                      style: TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 19.0,
                      ),
                    )),
              ],
            ),
            TextInput(
                width: double.infinity,
                height: 50,
                hinText: 'Enter your email',
                icon: FontAwesomeIcons.envelope,
                controller: _emailController,
                obscureText: false),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
              child: InkWell(
                onTap: () async {
                  String data = await _authFirebase.resetPassword(_emailController.text);
                  if(data == '1') {
                    toastification.show(
                        type: ToastificationType.success,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text('Lütfen email adresinizi kontrol ediniz!'),
                        autoCloseDuration: const Duration(seconds: 2));
                  } else if(data == 'firebase') {
                    toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text('Sistemde böyle bir hesap bulunamadı!'),
                        autoCloseDuration: const Duration(seconds: 5));
                  } else {
                    toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text('Lütfen internet bağlantısını kontrol ediniz!'),
                        autoCloseDuration: const Duration(seconds: 5));
                  }
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFFC74C49), // #C74C49
                        Color(0xFF823F84), // #823F84
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Send Link',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 17.0, top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(FontAwesomeIcons.backward, color: Colors.white, size: 18.0,),
                  InkWell(
                    onTap: () {
                       Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      '  Back to log in',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            ),
             Flexible(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
    );
  }
}
