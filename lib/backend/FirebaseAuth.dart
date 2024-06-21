import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthFirebase {
  Future<String?> createWithEmail(
      String name, String email, String password) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      int verificationCode = Random().nextInt(999999);
      await FirebaseFirestore.instance
          .collection('verifactionCodes')
          .doc(userCredential.user!.uid)
          .set(
              {'code': verificationCode, 'email': email, 'verifaction': false});

      await FirebaseFirestore.instance.collection('personal').doc(userCredential.user!.uid).set(
        {
          'email' : email,
          'saved': 'null',
        }
      );

      sendEmail(email, verificationCode.toString(), name);
      return name;
    } on FirebaseAuthException catch (error) {
      return error.message;
    } catch (error) {
      return error.toString();
    }
  }

  Future<String?> loginWithEmail(String email, String password) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return 'giriş başarılı';
    } on FirebaseAuthException catch (error) {
      return error.message;
    } catch (error) {
      return error.toString();
    }
  }

  Future<int> getVerifactionInfoByEmail(String email) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('verifactionCodes')
              .where('email', isEqualTo: email)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data();
          if (data['verifaction'] == true) {
            return 1; // Doğrulama başarılı
          } else if (data['verifaction'] == false) {
            return 0; // Doğrulama başarısız
          }
        }
      } else {
        // print('Eşleşen belge bulunamadı.');
        return 2; // Hata durumu
      }
    } catch (e) {
      // print('Veri çekme hatası: $e');
      return 2; // Hata durumu
    }
    return 2; // Herhangi bir durumda hata durumu
  }

  Future<int> verifyEmailAddress(String email, String one, String two,
      String three, String four, String five, String six) async {
    try {
      // Verilen Stringleri birleştirip bir sayı oluşturma
      String comboText = one + two + three + four + five + six;
      int newComtoNumber = int.parse(comboText);

      // Firestore'dan verileri çekme
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('verifactionCodes')
              .where('email', isEqualTo: email)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> data = doc.data();
          if (data['code'] == newComtoNumber) {
            // Doğrulama başarılı, 'verifaction' alanını güncelle
            await FirebaseFirestore.instance
                .collection('verifactionCodes')
                .doc(doc.id)
                .update({'verifaction': true});
            return 1; // Doğrulama başarılı
          } else if (data['verifaction'] == false) {
            return 0; // Doğrulama başarısız
          }
        }
      } else {
        print('Eşleşen belge bulunamadı.');
        return 2; // Hata durumu
      }
    } catch (e) {
      print('Veri çekme hatası: $e');
      return 2; // Hata durumu
    }
    return 2; // Herhangi bir durumda hata durumu
  }

  resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return '1';
    } on FirebaseAuthException {
      return 'firebase';
    } catch (error) {
      return 'connection';
    }
  }

  Future<String?> getSavedInfo(String email) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('personal').where('email', isEqualTo: email).get();
    if(querySnapshot.docs.isNotEmpty) {
      for (var docs in querySnapshot.docs) {
        return docs['saved'];
      }
    }
    return null;
  }



Future<String> receiveEmail(String email) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await FirebaseFirestore.instance
            .collection('verifactionCodes')
            .where('email', isEqualTo: email)
            .get();

    if (querySnapshot.docs.isNotEmpty) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        print('Veri bulundu: ${data['code']}');
        // Eğer sendEmail fonksiyonu asenkron ise await kullanın
        await sendEmail(email, data['code'].toString(), 'Kullanıcı');
        print('Email gönderildi');
        return '1';
      }
    } else {
      print('Veri bulunamadı');
      return '2';
    }
  } catch (error) {
    print('Hata: $error');
    return '2';
  }
  // Herhangi bir sebeple yukarıdaki kodlar çalışmazsa
  return '2';
}


 Future<void> updateDatabaseMethod(String data, String email) async {
  if(data == 'online') {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('personal').where('email', isEqualTo: email).get();
    if(querySnapshot.docs.isNotEmpty) {
      for(var doc in querySnapshot.docs) {
       // Map<String, dynamic> data = doc.data();
        await FirebaseFirestore.instance.collection('personal').doc(doc.id).update({'saved' : 'online'});
      }
    }

  } else if(data == 'lokal') {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection('personal').where('email', isEqualTo: email).get();
    if(querySnapshot.docs.isNotEmpty) {
      for(var doc in querySnapshot.docs) {
       //  Map<String, dynamic> data = doc.data();
        await FirebaseFirestore.instance.collection('personal').doc(doc.id).update({'saved' : 'lokal'});
      }
    }
  }
 }


Future<List<String>> getChatInfo(String email) async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(email).get();
  List<String> documentNames = [];

  if (querySnapshot.docs.isNotEmpty) {
    for (var doc in querySnapshot.docs) {
      documentNames.add(doc.id);
    }
    // print(documentNames);
    return documentNames;
  }
  
  print('No documents found.');
  return [];
}


Future<List<List<dynamic>>> getFieldsInfo(String docID, String email) async {
  // Belirli bir koleksiyondan belirli bir dokümanı çekiyoruz
  DocumentSnapshot<Map<String, dynamic>> documentSnapshot = 
      await FirebaseFirestore.instance.collection(email).doc(docID).get();
  
  List<List<dynamic>> values = []; // Döndüreceğimiz değerleri saklamak için liste oluşturuyoruz

  // Doküman verilerini kontrol edip işliyoruz
  if (documentSnapshot.exists) {
    Map<String, dynamic>? data = documentSnapshot.data(); // Map<String, dynamic> olarak verileri alıyoruz

    if (data != null) {
      data.forEach((key, value) {
        if (value is List) {
          values.add(value); // Array olan değerleri listeye ekliyoruz
        }
      });
    }
  }

  return values; // Listeyi döndürüyoruz
}








  sendEmail(String email, String text, String name) async {
    const url = 'yourAPILink';

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'subject': 'JuaGPT’de hesap oluşturmak için doğrulama kodunuz',
        'text': text,
        'name': name,
      }),
    );

    if (response.statusCode == 200) {
      // print('E-posta gönderildi!');
    } else {
      // print('E-posta gönderme hatası: ${response.body}');
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      GoogleSignIn signIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await signIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleSignInAccount?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      return '1';
    } catch (error) {
      return error.toString();
    }
  }
}
