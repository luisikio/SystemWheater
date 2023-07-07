import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? uid;
  String? name;
  String? apellido;
  String? telefono;
  String? email;
  String? rool;
  String? jass;
  //JassModel? jassModel;

  UserModel(
      {this.uid,
      this.name,
      this.apellido,
      this.telefono,
      this.email,
      this.rool,
      this.jass
      //this.jassModel,
      });
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map?['uid'],
      name: map?['name'],
      apellido: map?['apellido'],
      telefono: map?['telefono'],
      email: map?['email'],
      rool: map?['rool'],
      jass: map?['jass'],
      // jassModel: map?['jassModel'],
      // jassModel: map?['jassModel'],
      // jassModel: JassModel.fromMap(map['provincia']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'apellido': apellido,
      'telefono': telefono,
      'email': email,
      'rool': rool,
      'jass': jass,
      //'jassModel': jassModel,
    };
  }

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        name: json['name'],
        apellido: json['apellido'],
        telefono: json['telefono'],
        email: json['email'],
        rool: json['rool'],
        jass: json['jass'],
        //jassModel: json['jassModel'],
      );
}

Future<List<UserModel>> getObjectListUsers() async {
  List<UserModel> objectList = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('user').get();
  List<QueryDocumentSnapshot> documentList = querySnapshot.docs;

  for (var document in documentList) {
    UserModel object = UserModel(
      name: document.get('name'),
      apellido: document.get('apellido'),
      telefono: document.get('telefono'),
      email: document.get('email'),
      rool: document.get('rool'),
      jass: document.get('jass'),
    );
    objectList.add(object);
  }

  return objectList;
}
