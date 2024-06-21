// ignore_for_file: file_names

import 'package:JuaGPT/backend/FirebaseAuth.dart';
import 'package:JuaGPT/backend/hive.dart';
import 'package:JuaGPT/components/chatText.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  AuthFirebase _authFirebase = AuthFirebase();
  

  late Future<String?> savedInfoFuture;
  late Future<String?> getName;

  @override
  void initState() {
    super.initState();
    savedInfoFuture = _authFirebase.getSavedInfo(FirebaseAuth.instance.currentUser!.email.toString());
    getName = getNameByEmail(FirebaseAuth.instance.currentUser!.email.toString());
  }

  void _showOptions(String data) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.cloud),
            title: const Text('Online'),
            onTap: () async {
              await _authFirebase.updateDatabaseMethod('online', FirebaseAuth.instance.currentUser!.email.toString());
              setState(() {
                savedInfoFuture = _authFirebase.getSavedInfo(FirebaseAuth.instance.currentUser!.email.toString());
              });
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage),
            title: const Text('Lokal (now cant use)'),
            onTap: () async {
              await _authFirebase.updateDatabaseMethod('online', FirebaseAuth.instance.currentUser!.email.toString());
              setState(() {
                savedInfoFuture = _authFirebase.getSavedInfo(FirebaseAuth.instance.currentUser!.email.toString());
              });
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

void changEmail() {
  final TextEditingController _textController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextInput(
                    controller: _textController,
                    
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    String? data = await updateNameByEmail(FirebaseAuth.instance.currentUser!.email.toString(), _textController.text);
                    print(data);
                    if (data == 'null') {
                      String? veri = await addNewRecord(FirebaseAuth.instance.currentUser!.email.toString(), _textController.text);
                      print('veri: $veri ');
                    }
                    setState(() {
                      getName = getNameByEmail(FirebaseAuth.instance.currentUser!.email.toString());
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayrıntılar'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/icon/gemini.png', // Logonuzun yolu
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 20),
              const Text(
                'JuaGPT',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Uygulama Bilgileri',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('Uygulama Adı: JuaGPT'),
              ),
              const ListTile(
                leading: Icon(Icons.info),
                title: Text('Sürüm: 1.0.1 Beta'),
              ),
              FutureBuilder<String?>(
                future: getName,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      leading: Icon(Icons.person_2),
                      title: Text('Kullanıcı Adı: Yükleniyor...'),
                    );
                  } else if (snapshot.hasError) {
                    return const ListTile(
                      leading: Icon(Icons.person_2),
                      title: Text('Kullanıcı Adı: Hata oluştu'),
                    );
                  } else if (snapshot.hasData) {
                    return ListTile(
                      leading: const Icon(Icons.person_2),
                      title: Text('Kullanıcı Adı: ${snapshot.data}'),
                      onTap: () => changEmail(),
                    );
                  } else {
                    return const ListTile(
                      leading: Icon(Icons.warning),
                      title: Text('Kullanıcı Adı: Bilinmiyor'),
                    );
                  }
                },
              ),
              FutureBuilder<String?>(
                future: savedInfoFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ListTile(
                      leading: FaIcon(FontAwesomeIcons.database),
                      title: Text('Verilerin depolanma şekli: Yükleniyor...'),
                    );
                  } else if (snapshot.hasError) {
                    return const ListTile(
                      leading: Icon(Icons.error),
                      title: Text('Verilerin depolanma şekli: Hata oluştu'),
                    );
                  } else if (snapshot.hasData) {
                    return ListTile(
                      leading: const FaIcon(FontAwesomeIcons.database),
                      title: Text('Verilerin depolanma şekli: ${snapshot.data}'),
                      onTap: () => _showOptions(snapshot.data!),
                    );
                  } else {
                    return const ListTile(
                      leading: Icon(Icons.warning),
                      title: Text('Verilerin depolanma şekli: Bilinmiyor'),
                    );
                  }
                },
              ),
              const ListTile(
                leading: Icon(Icons.developer_mode),
                title: Text('Geliştirici: Marijua'),
              ),
              const ListTile(
                leading: Icon(Icons.support),
                title: Text('Geliştirme Desteği: Schweis INC.'),
              ),
              const ListTile(
                leading: Icon(Icons.link),
                title: Text('GitHub: github.com/enderjua/JuaGPT'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
