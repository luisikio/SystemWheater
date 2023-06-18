class DistritoModel {
  String? uid;
  String? provincia;
  String? departamento;
  String? distrito;

  DistritoModel({
    this.uid,
    this.provincia,
    this.departamento,
    this.distrito,
  });
  factory DistritoModel.fromMap(map) {
    return DistritoModel(
      uid: map?['uid'],
      provincia: map?['provincia'],
      departamento: map?['departamento'],
      distrito: map?['distrito'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'provincia': provincia,
      'departamento': departamento,
      'distrito': distrito,
    };
  }

  static DistritoModel fromJson(Map<String, dynamic> json) => DistritoModel(
        uid: json['uid'],
        provincia: json['provincia'],
        departamento: json['departamento'],
        distrito: json['distrito'],
      );
}
