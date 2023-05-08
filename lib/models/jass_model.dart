class JassModel {
  String? uid;
  String? provincia;

  JassModel({
    this.uid,
    this.provincia,
  });
  factory JassModel.fromMap(map) {
    return JassModel(
      uid: map?['uid'],
      provincia: map?['provincia'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'provincia': provincia,
    };
  }

  static JassModel fromJson(Map<String, dynamic> json) => JassModel(
        uid: json['uid'],
        provincia: json['provincia'],
      );
}
