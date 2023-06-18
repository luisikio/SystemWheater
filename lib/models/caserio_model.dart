class CaserioModel {
  String? uid;
  String? provincia;
  String? departamento;
  String? distrito;
  String? caserio;

  CaserioModel({
    this.uid,
    this.provincia,
    this.departamento,
    this.distrito,
    this.caserio,
  });
  factory CaserioModel.fromMap(map) {
    return CaserioModel(
      uid: map?['uid'],
      provincia: map?['provincia'],
      departamento: map?['departamento'],
      distrito: map?['distrito'],
      caserio: map?['caserio'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'provincia': provincia,
      'departamento': departamento,
      'distrito': distrito,
      'caserio': caserio,
    };
  }

  static CaserioModel fromJson(Map<String, dynamic> json) => CaserioModel(
        uid: json['uid'],
        provincia: json['provincia'],
        departamento: json['departamento'],
        distrito: json['distrito'],
        caserio: json['caserio'],
      );
}
