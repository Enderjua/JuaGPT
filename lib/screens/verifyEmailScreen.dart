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

class VerifyEmailScreen extends StatefulWidget {
  final String email;

  const VerifyEmailScreen({
    super.key,
    required this.email,
  });

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {

  AuthFirebase _authFirebase = AuthFirebase();

  final TextEditingController _oneText = TextEditingController();
  final TextEditingController _twoText = TextEditingController();
  final TextEditingController _threeText = TextEditingController();
  final TextEditingController _fourText = TextEditingController();
  final TextEditingController _besText = TextEditingController();
  final TextEditingController _altiText = TextEditingController();

  final FocusNode _focusNode1 = FocusNode();
  final FocusNode _focusNode2 = FocusNode();
  final FocusNode _focusNode3 = FocusNode();
  final FocusNode _focusNode4 = FocusNode();
  final FocusNode _focusNode5 = FocusNode();
  final FocusNode _focusNode6 = FocusNode();

  Color _borderColor1 = const Color(0xFFFFFFFF);
  Color _borderColor2 = const Color(0xFFFFFFFF);
  Color _borderColor3 = const Color(0xFFFFFFFF);
  Color _borderColor4 = const Color(0xFFFFFFFF);
  Color _borderColor5 = const Color(0xFFFFFFFF);
  Color _borderColor6 = const Color(0xFFFFFFFF);

  @override
  void initState() {
    super.initState();

    void _updateBorderColor(FocusNode focusNode, TextEditingController controller, int index) {
      setState(() {
        Color color = focusNode.hasFocus || controller.text.isNotEmpty ? const Color(0xFF7B3A36) : const Color(0xFFFFFFFF);
        switch (index) {
          case 1:
            _borderColor1 = color;
            break;
          case 2:
            _borderColor2 = color;
            break;
          case 3:
            _borderColor3 = color;
            break;
          case 4:
            _borderColor4 = color;
            break;
          case 5:
            _borderColor5 = color;
            break;
          case 6:
            _borderColor6 = color;
            break;
        }
      });
    }

    _focusNode1.addListener(() => _updateBorderColor(_focusNode1, _oneText, 1));
    _focusNode2.addListener(() => _updateBorderColor(_focusNode2, _twoText, 2));
    _focusNode3.addListener(() => _updateBorderColor(_focusNode3, _threeText, 3));
    _focusNode4.addListener(() => _updateBorderColor(_focusNode4, _fourText, 4));
    _focusNode5.addListener(() => _updateBorderColor(_focusNode5, _besText, 5));
    _focusNode6.addListener(() => _updateBorderColor(_focusNode6, _altiText, 6));

    _oneText.addListener(() => _updateBorderColor(_focusNode1, _oneText, 1));
    _twoText.addListener(() => _updateBorderColor(_focusNode2, _twoText, 2));
    _threeText.addListener(() => _updateBorderColor(_focusNode3, _threeText, 3));
    _fourText.addListener(() => _updateBorderColor(_focusNode4, _fourText, 4));
    _besText.addListener(() => _updateBorderColor(_focusNode5, _besText, 5));
    _altiText.addListener(() => _updateBorderColor(_focusNode6, _altiText, 6));
  }



  @override
  void dispose() {
    _oneText.dispose();
    _twoText.dispose();
    _threeText.dispose();
    _fourText.dispose();
    _besText.dispose();
    _altiText.dispose();

    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    _focusNode4.dispose();
    _focusNode5.dispose();
    _focusNode6.dispose();

    super.dispose();
  }




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
            Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Bu özelliği ekleyin
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 11.0),
                  child: Text(
                    'Check Your Email ✨',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 11.0, top: 5.0),
                    child: Text(
                      'We sent a verifaction link to ${widget.email}',
                      style: const TextStyle(
                        color: Color(0xFF777777),
                        fontSize: 19.0,
                      ),
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CodeInput(
                  width: MediaQuery.of(context).size.width / 8 - 5,
                  height: 50,
                  controller: _oneText,
                  focusNode: _focusNode1,
                  borderColor: _borderColor1,
                ),
                CodeInput(
                  width: MediaQuery.of(context).size.width / 8 - 5,
                  height: 50,
                  controller: _twoText,
                  focusNode: _focusNode2,
                  borderColor: _borderColor2,
                ),
                CodeInput(
                  width: MediaQuery.of(context).size.width / 8 - 5,
                  height: 50,
                  controller: _threeText,
                  focusNode: _focusNode3,
                  borderColor: _borderColor3,
                ),
                CodeInput(
                  width: MediaQuery.of(context).size.width / 8 - 5,
                  height: 50,
                  controller: _fourText,
                  focusNode: _focusNode4,
                  borderColor: _borderColor4,
                ),
                CodeInput(
                  width: MediaQuery.of(context).size.width / 8 - 5,
                  height: 50,
                  controller: _besText,
                  focusNode: _focusNode5,
                  borderColor: _borderColor5,
                ),
                CodeInput(
                  width: MediaQuery.of(context).size.width / 8 - 5,
                  height: 50,
                  controller: _altiText,
                  focusNode: _focusNode6,
                  borderColor: _borderColor6,
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 30.0),
              child: InkWell(
                onTap: () async {
                  int data = await _authFirebase.verifyEmailAddress(widget.email, _oneText.text, _twoText.text, _threeText.text, _fourText.text, _besText.text, _altiText.text);
                    if(data == 1) {
                    toastification.show(
                        type: ToastificationType.success,
                        style: ToastificationStyle.fillColored,
                        // ignore: use_build_context_synchronously
                        context: context,
                        title: const Text('Tebrikler, doğrulama işlemi başarılı!'),
                        autoCloseDuration: const Duration(seconds: 2));
                    Future.delayed(const Duration(seconds: 2), () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (builder) => HomeScreen(email: widget.email,)));
                    });
                  } else if(data == 0) {
                    toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        // ignore: use_build_context_synchronously
                        context: context,
                        title: const Text('Lütfen doğrulama kodunu doğru girdinize emin olun!'),
                        autoCloseDuration: const Duration(seconds: 5));
                    
                  } else {
                    toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        // ignore: use_build_context_synchronously
                        context: context,
                        title: const Text('İnternet bağlantınızı kontrol ediniz!'),
                        autoCloseDuration: const Duration(seconds: 5));
                  }
                  
                },
                child: Container(
                  height: 55,
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
                      'Verify email',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
            ),
          
         
            Padding(
              padding: const EdgeInsets.only(bottom: 17.0, top: 20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't receive the email?",
                    style: TextStyle(
                      color: Color(0xFF777777),
                      fontSize: 18.0,
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      String data = await _authFirebase.receiveEmail(widget.email);
                      if(data == '1') {
                        toastification.show(
                        type: ToastificationType.success,
                        style: ToastificationStyle.fillColored,
                        // ignore: use_build_context_synchronously
                        context: context,
                        title: const Text('Lütfen email adresinizi kontrol ediniz!'),
                        autoCloseDuration: const Duration(seconds: 2));
                      } else {
                        toastification.show(
                        type: ToastificationType.error,
                        style: ToastificationStyle.fillColored,
                        // ignore: use_build_context_synchronously
                        context: context,
                        title: const Text('Bir hata oluştu!'),
                        autoCloseDuration: const Duration(seconds: 5));
                      }
                    },
                    child: const Text(
                      ' Click to resend',
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
