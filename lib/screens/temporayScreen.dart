// ignore_for_file: file_names, use_build_context_synchronously

import 'package:JuaGPT/backend/FirebaseAuth.dart';
import 'package:JuaGPT/backend/hive.dart';
import 'package:JuaGPT/backend/temporaryTalk.dart';
import 'package:JuaGPT/screens/chatScreen.dart';
import 'package:JuaGPT/screens/infoScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:JuaGPT/components/chatText.dart';
import 'package:flutter_syntax_view/flutter_syntax_view.dart';
import 'package:toastification/toastification.dart';

class TemporaryChatScreen extends StatefulWidget {
  const TemporaryChatScreen({super.key});

  @override
  State<TemporaryChatScreen> createState() => _TemporaryChatScreenState();
}

class _TemporaryChatScreenState extends State<TemporaryChatScreen> {
  final AuthFirebase _authFirebase = AuthFirebase();
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _formController = TextEditingController();
  bool _isTyping = false;
  bool _isEnabled = false;
  bool? isFormVisible;
  String? name;
  late Future<int> _futureData; // Gelecekteki veriyi tutacak

  List<Map<String, String>> messages = []; // Mesajları saklayacağımız liste

  Future<int> _fetchGetSavedInfo() async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('personal')
        .where('email', isEqualTo: FirebaseAuth.instance.currentUser!.email)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        if (doc['saved'] == 'null') {
          return 1;
        }
        return 0;
      }
    }
    return 0;
  }

  Future<String?> _fetchGetName() async {
    return await getNameByEmail(
        FirebaseAuth.instance.currentUser!.email.toString());
  }

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _isTyping = _textController.text.isNotEmpty;
      });
    });
    _fetchGetName().then((fetchedName) {
      setState(() {
        name = fetchedName;
      });
    });
    _futureData = _fetchGetSavedInfo();
  }

  void _saveForm() async {
    if (_formController.text != 'online' && _formController.text != 'lokal') {
      toastification.show(
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        context: context,
        title: const Text(
            'Lütfen yalnızca online veyahut lokal yazarak tercihinizi belirtiniz!'),
        autoCloseDuration: const Duration(seconds: 5),
      );
    } else if (_formController.text == 'online') {
      await _authFirebase.updateDatabaseMethod(
          'online', FirebaseAuth.instance.currentUser!.email.toString());
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        context: context,
        title: const Text(
            'Tercihiniz başarıyla kaydedildi! Dilerseniz ayarlardan değişiklik yapabilirsiniz'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      setState(() {
        isFormVisible = false; // Formu kaydettikten sonra görünmez yap
      });
    } else if (_formController.text == 'lokal') {
      await _authFirebase.updateDatabaseMethod(
          'lokal', FirebaseAuth.instance.currentUser!.email.toString());
      toastification.show(
        type: ToastificationType.success,
        style: ToastificationStyle.fillColored,
        context: context,
        title: const Text(
            'Tercihiniz başarıyla kaydedildi! Dilerseniz ayarlardan değişiklik yapabilirsiniz'),
        autoCloseDuration: const Duration(seconds: 2),
      );
      setState(() {
        isFormVisible = false; // Formu kaydettikten sonra görünmez yap
      });
    }
  }

  void _sendMessage() async {
  if (_textController.text.isNotEmpty) {
    setState(() {
      messages.add({
        'sender': 'user',
        'text': _textController.text,
      });
      _isEnabled = true;
    });

    String? botResponse = await textToText(_textController.text);

    setState(() {
      messages.add({
        'sender': 'bot',
        'text': botResponse!,
      });
      _isEnabled = false;
    });

    _textController.clear();
  }
}

  Widget _buildMessage(Map<String, String> message) {
    bool isUser = message['sender'] == 'user';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isUser) ...[
            
            const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/img/marijua.jpg'), // Kullanıcı avatarı
              radius: 15,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name!, // Kullanıcı ismi
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message['text']!,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ... [

            const CircleAvatar(
              backgroundImage:
                  AssetImage('assets/icon/gemini.png'), // Bot avatarı
              radius: 15,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'JuaGPT', // Bot ismi
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        
                        ..._extractCodeBlocks(message['text']!),
                      ],
                    ))
                  
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }

  void _navigateToInfoScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const InfoScreen()),
    );
  }

  void _navigateToChatScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ChatScreen()),
    );
  }

List<Widget> _extractCodeBlocks(String text) {
    final codeBlockRegExp = RegExp(r'```(\w+)\n([\s\S]*?)```', multiLine: true);
    final matches = codeBlockRegExp.allMatches(text);
    List<Widget> codeBlocks = [];

    String cleanedText = text;

    for (final match in matches) {
      final language = match.group(1);
      final code = match.group(2);

      if (language != null && code != null) {
        // print('Dil: $language');
        // print('Kod: $code');
        cleanedText = cleanedText.replaceFirst(match.group(0)!, '');
        

        final syntax = _getSyntax(language);
        codeBlocks.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: SyntaxView(
            code: code,
            syntax: syntax,
            syntaxTheme: SyntaxTheme.vscodeDark(),
            fontSize: 12.0,
            withZoom: true,
            withLinesCount: true,
            expanded: false,
            selectable: true,
          ),
        ));
      }
    }

    // Add the remaining text without code blocks
    if (cleanedText.trim().isNotEmpty) {
      codeBlocks.insert(0, Text(
        cleanedText,
        style: const TextStyle(
          color: Colors.black,
        ),
      ));
    }

    return codeBlocks;
  }

  Syntax _getSyntax(String language) {
    switch (language.toLowerCase()) {
      case 'dart':
        return Syntax.DART;
      case 'python':
        return Syntax.JAVA;
      case 'javascript':
        return Syntax.JAVASCRIPT;
      // Add more cases for other languages as needed
      default:
        return Syntax.DART; // Default to Dart if language is not recognized
    }
}



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: _futureData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Bir hata oluştu: ${snapshot.error}'),
            ),
          );
        } else {
          bool isFormVisible = snapshot.data == 1;
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => const ChatScreen()));
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Plus Abonesi Ol ✨',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ],
              ),
              actions: [
                PopupMenuButton<int>(
                  icon: const Icon(Icons.more_vert),
                  onSelected: (value) {
                    if (value == 1) {
                      _navigateToChatScreen();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 1,
                      child: Row(
                        children: [
                          Icon(Icons.check),
                          SizedBox(width: 10),
                          Text('Geçici Sohbet'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
              centerTitle: true,
            ),
            body: Stack(
              children: [
                GestureDetector(
                  onTap: _navigateToInfoScreen,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.visibility_off, color: Colors.blue),
                      SizedBox(width: 5),
                      Text(
                        'Geçici Sohbet',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.info_outline, color: Colors.blue),
                    ],
                  ),
                ),
                Center(
                  child: Image.asset(
                    'assets/icon/gemini.png', // Burada logo resminizin yolunu belirtin
                    width: 100, // Logonun genişliği
                    height: 100, // Logonun yüksekliği
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      if (isFormVisible) ...[
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Sohbet türünü seçin:',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              TextFormField(
                                controller: _formController,
                                decoration: const InputDecoration(
                                  labelText: 'online veya lokal yazın',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: _saveForm,
                                child: const Text('Kaydet'),
                              ),
                            ],
                          ),
                        ),
                      ] else ...[
                        const SizedBox(height: 20.0,),
                        Expanded(
                          child: ListView.builder(
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              return _buildMessage(messages[index]);
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomTextInput(
                                    controller: _textController,
                                    enable: !_isEnabled,),
                              ),
                              IconButton(
                                icon: Icon(
                                    _isTyping ? !_isEnabled ? Icons.send : Icons.headset : Icons.headset),
                                onPressed: !_isEnabled ? _sendMessage : () {},
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
