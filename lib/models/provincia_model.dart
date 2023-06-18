class ProvinciaModel {
  String? uid;
  String? provincia;
  String? departamento;

  ProvinciaModel({
    this.uid,
    this.provincia,
    this.departamento,
  });
  factory ProvinciaModel.fromMap(map) {
    return ProvinciaModel(
      uid: map?['uid'],
      provincia: map?['provincia'],
      departamento: map?['departamento'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'provincia': provincia,
      'departamento': departamento,
    };
  }

  static ProvinciaModel fromJson(Map<String, dynamic> json) => ProvinciaModel(
        uid: json['uid'],
        provincia: json['provincia'],
        departamento: json['departamento'],
      );
}
