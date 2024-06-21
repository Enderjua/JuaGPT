// ignore_for_file: depend_on_referenced_packages

import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class PersonalInformation extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String email;

  // @HiveField(2)
  // late Map<dynamic, dynamic> promptsOutputs = {};
}

class PersonalInformationAdapter extends TypeAdapter<PersonalInformation> {
  @override
  final int typeId = 0;

  @override
  PersonalInformation read(BinaryReader reader) {
    return PersonalInformation()..name = reader.readString()
    ..email = reader.readString();
    // ..promptsOutputs = reader.readMap();
  }

  @override
  void write(BinaryWriter writer, PersonalInformation obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.email);
    // writer.writeMap(obj.promptsOutputs);
  }
}


Future<Box<PersonalInformation>> addName(String name, String email) async {
  await Hive.openBox<PersonalInformation>('personal');

  final box = Hive.box<PersonalInformation>('personal');

  final writeName = PersonalInformation()
  ..name = name
  ..email = email;

  box.add(writeName);
  return box;
}

Future<String?> getNameByEmail(String email) async {
  await Hive.openBox<PersonalInformation>('personal');
  
  final box = Hive.box<PersonalInformation>('personal');

  for (int i = 0; i  < box.length; i++) {
    PersonalInformation? info = box.getAt(i);
    if (info != null && info.email == email) {
      return info.name;
    }
  }

  return 'Kullanıcı';
}


Future<String?> addNewRecord(String email, String name) async {
  await Hive.openBox<PersonalInformation>('personal');

  // ignore: unused_local_variable
  final box = Hive.box<PersonalInformation>('personal');

  await addName(name, email);
  return name;
}

Future<String?> updateNameByEmail(String email, String name) async {
  await Hive.openBox<PersonalInformation>('personal');

  final box = Hive.box<PersonalInformation>('personal');

  for (int i = 0; i < box.length; i++) {
    PersonalInformation? info = box.getAt(i);
    if(info != null && info.email == email) {
      info.name = name;
      info.save();
      return name;
    }
  }
  return 'null';
}