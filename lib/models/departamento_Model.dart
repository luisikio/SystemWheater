class DepartamentoModel {
  String? departamento;

  DepartamentoModel({
    this.departamento,
  });
  factory DepartamentoModel.fromMap(map) {
    return DepartamentoModel(
      departamento: map?['departamento'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'departamento': departamento,
    };
  }

  static DepartamentoModel fromJson(Map<String, dynamic> json) =>
      DepartamentoModel(
        departamento: json['departamento'],
      );
}
