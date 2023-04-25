class UserModel {
  final String name;
  final String apellido;
  final String telefono;
  final String email;
  final String rool;
  final String uid;

  UserModel({
    required this.email,
    required this.name,
    required this.apellido,
    required this.telefono,
    required this.rool,
    required this.uid,
  });

  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map?['uid'],
      name: map?['name'],
      apellido: map?['apellido'],
      email: map?['email'],
      telefono: map?['telefono'],
      rool: map?['rool'],
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
    };
  }
}
