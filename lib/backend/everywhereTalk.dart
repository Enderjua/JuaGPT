// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';

newChatCreate(String email, String chat, String prompt, String output) async {
  await FirebaseFirestore.instance.collection(email).doc(chat).set({
    '1': [
      prompt,
      output
    ]
  });
  return 'basari';
}

addChatPrompt(String email, String chat, String prompt, String output ) async {
  int number = await findMaxField(email, chat);
  number = number + 1;
  String realNumber = number.toString();
  await FirebaseFirestore.instance.collection(email).doc(chat).update({
    realNumber: [
      prompt,
      output
    ]
  });
}


Future<int> findMaxField(String email, String doc) async {
  // Firestore instance oluştur
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  
  // İlgili koleksiyon ve dokümanı seç
  CollectionReference collection = firestore.collection(email);
  DocumentReference document = collection.doc(doc);

  // Dokümanı al
  DocumentSnapshot snapshot = await document.get();

  // Dokümanın verilerini al
  Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

  // Veri null ise 0 döner
  if (data == null) return 0;

  // Field isimlerini al
  List<String> fieldNames = data.keys.toList();

  // Sayısal alan adlarını filtrele ve en büyüğünü bul
  int maxField = 0;
  for (String fieldName in fieldNames) {
    int? fieldNumber = int.tryParse(fieldName);
    if (fieldNumber != null && fieldNumber > maxField) {
      maxField = fieldNumber;
    }
  }

  // En büyük sayısal alan adını döner
  return maxField;
}


String getFirstThreeWords(String text) {
  // Metni boşluklara göre ayırarak kelimeler listesi oluştur
  List<String> words = text.split(' ');

  // Eğer kelime sayısı üçten azsa mevcut kelimeleri döner
  if (words.length <= 3) {
    return words.join(' ');
  }

  // Eğer kelime sayısı üçten fazla ise ilk üç kelimeyi döner
  return words.sublist(0, 3).join(' ');
}