import 'package:JuaGPT/backend/hive.dart';
import 'package:JuaGPT/screens/homeScreen.dart';
import 'package:JuaGPT/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_flutter/hive_flutter.dart';


void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonalInformationAdapter());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: 'Firebase API Key',
        appId: 'App ID',
        messagingSenderId: 'senderID',
        projectId: 'projectID'),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JuaGPT',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      home: const AuthWrapper(),
    );
  }
}


class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Eğer hala bağlantı bekleniyorsa bir yükleme göstergesi gösterebiliriz
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // Eğer kullanıcı giriş yaptıysa ana sayfaya yönlendir
          // return const ChatScreen();
          
          return HomeScreen(email: snapshot.data!.email!);
        } else {
          // Eğer kullanıcı giriş yapmadıysa login sayfasına yönlendir
          
          return const LoginScreen();
          // return const ChatScreen();
        }
      },
    );
  }
}