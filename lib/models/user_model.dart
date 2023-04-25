class UserModel {
  String? uid;
  String? name;
  String? apellido;
  String? telefono;
  String? email;
  String? rool;

  UserModel(
      {this.uid,
      this.name,
      this.apellido,
      this.telefono,
      this.email,
      this.rool});
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map?['uid'],
      name: map?['name'],
      apellido: map?['apellido'],
      telefono: map?['telefono'],
      email: map?['email'],
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

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        name: json['name'],
        apellido: json['apellido'],
        telefono: json['telefono'],
        email: json['email'],
        rool: json['rool'],
      );
}
