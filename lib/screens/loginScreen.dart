// ignore_for_file: file_names, unnecessary_const, unused_import, prefer_final_fields, use_build_context_synchronously

import 'package:JuaGPT/backend/FirebaseAuth.dart';
import 'package:JuaGPT/screens/forgotPassword.dart';
import 'package:JuaGPT/screens/homeScreen.dart';
import 'package:JuaGPT/screens/registerScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toastification/toastification.dart';

import '../components/textInput.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthFirebase _authFirebase = AuthFirebase();

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
              flex: 1,
              child: Container(),
            ),
            const Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Bu özelliği ekleyin
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 11.0),
                  child: Text(
                    'Log in to your account ✨',
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
                      'Welcome back! Please enter your details.',
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
            TextInput(
                width: double.infinity,
                height: 50,
                hinText: '•••••••',
                icon: FontAwesomeIcons.lock,
                controller: _passwordController,
                obscureText: true),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const ForgotPassword()));
                },
                child: const Align(
                  alignment: Alignment.topRight, // Sağ üst köşeye hizala
                  child: Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.0,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
              child: InkWell(
                onTap: () async {
                  String? login = await _authFirebase.loginWithEmail(
                      _emailController.text, _passwordController.text);
                  if (login == 'giriş başarılı') {
                    toastification.show(
                        type: ToastificationType.success,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text('Tebrikler, giriş başarılı!'),
                        autoCloseDuration: const Duration(seconds: 2));
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => HomeScreen(email: _emailController.text,)));
                    });
                  } else if (login ==
                      '"dev.flutter.pigeon.firebase_auth_platform_interface.FirebaseAuthHostApi.signInWithEmailAndPassword".') {
                    toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text(
                            'Lütfen tüm boşlukları doldurduğunuzdan emin olun!'),
                        autoCloseDuration: const Duration(seconds: 5));
                  } else if (login == 'The email address is badly formatted.') {
                    toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text(
                            'Lütfen geçerli bir email adresi giriniz!'),
                        autoCloseDuration: const Duration(seconds: 5));
                  } else if (login ==
                      'The supplied auth credential is incorrect, malformed or has expired.') {
                    toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text(
                            'Email adresi veya şifrenizin doğru olduğundan emin olun!'),
                        autoCloseDuration: const Duration(seconds: 5));
                  } else {
                    toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text(
                            'İnternet bağlantınızı kontrol edin. Eğer sorun bizden kaynaklıysa lütfen bunu bize bildirin!'),
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
                      'Log In',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20.0),
              child: InkWell(
                onTap: () async {
                  String? google = await _authFirebase.signInWithGoogle();
                  if (google == '1') {
                    toastification.show(
                        type: ToastificationType.success,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text('Tebrikler, kayıt işlemi başarılı!'),
                        autoCloseDuration: const Duration(seconds: 2));
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => HomeScreen(email: _emailController.text,)));
                    });
                  } else {
                    toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        context: context,
                        title: const Text(
                            'İnternet bağlantınızı kontrol edin. Eğer sorun bizden kaynaklıysa lütfen bunu bize bildirin!'),
                        autoCloseDuration: const Duration(seconds: 5));
                  }
                },
                child: Container(
                  height: 60,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    color: const Color(0xFF151515),
                    border: Border.all(
                      color: const Color(0xFFFFFFFF), // Beyaz renk
                      width: 0.5, // İnce kenarlık
                    ),
                  ),
                  child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.google),
                        Text(
                          '  Log in with Google',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ]),
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 17.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(
                      color: Color(0xFF777777),
                      fontSize: 18.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Text(
                      ' Sign up',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
