// ignore_for_file: file_names

// import 'package:JuaGPT/backend/hive.dart';
import 'package:JuaGPT/screens/chatScreen.dart';
import 'package:flutter/material.dart';
import 'package:JuaGPT/backend/FirebaseAuth.dart';
import 'package:JuaGPT/screens/verifyEmailScreen.dart';

class HomeScreen extends StatefulWidget {
  final String email;

  const HomeScreen({
    super.key,
    required this.email,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthFirebase _authFirebase = AuthFirebase();

  late Future<int> _verificationFuture;

  @override
  void initState() {
    super.initState();
    _verificationFuture = _authFirebase.getVerifactionInfoByEmail(widget.email);
    // addNewRecord(widget.email, 'adad');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<int>(
        future: _verificationFuture,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Veri yüklenirken gösterilecek widget (örneğin yükleniyor göstergesi)
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Hata durumunda gösterilecek widget
            return Center(
              child: Text('Bir hata oluştu: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            // Veri yüklendiğinde gösterilecek widget
            if (snapshot.data == 0) {
              // Doğrulama gerektiren kullanıcı
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerifyEmailScreen(email: widget.email),
                  ),
                );
              });
            }
           return const ChatScreen();
          } else {
            // Veri yoksa gösterilecek widget
            return const Center(
              child: Text('Veri bulunamadı'),
            );
          }
        },
      ),
    );
  }
}
