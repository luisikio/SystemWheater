import 'package:cloud_firestore/cloud_firestore.dart';

class CloracionModel {
  String? nameOperador;
  String? nameJas;
  String? caudal;
  String? tiempoRecarga;
  String? volCloracion;
  String? residualReservorio;
  String? cloroComercial;
  String? pGr;
  String? qg;
  DateTime? fecha;
  String? iud;

  CloracionModel({
    this.nameOperador,
    this.nameJas,
    this.caudal,
    this.tiempoRecarga,
    this.volCloracion,
    this.residualReservorio,
    this.cloroComercial,
    this.pGr,
    this.qg,
    this.fecha,
    this.iud,
  });
  factory CloracionModel.fromMap(map) {
    return CloracionModel(
      nameOperador: map?['nameOperador'],
      nameJas: map?['nameJas'],
      caudal: map?['caudal'],
      tiempoRecarga: map?['tiempoRecarga'],
      volCloracion: map?['volCloracion'],
      residualReservorio: map?['residualReservorio'],
      cloroComercial: map?['cloroComercial'],
      pGr: map?['pGr'],
      qg: map?['qg'],
      fecha: map?['fecha'],
      iud: map?['iud'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameOperador': nameOperador,
      'nameJas': nameJas,
      'caudal': caudal,
      'tiempoRecarga': tiempoRecarga,
      'volCloracion': volCloracion,
      'residualReservorio': residualReservorio,
      'cloroComercial': cloroComercial,
      'pGr': pGr,
      'qg': qg,
      'fecha': fecha,
      'iud': iud,
    };
  }

  static CloracionModel fromJson(Map<String, dynamic> json) => CloracionModel(
        nameOperador: json['nameOperador'],
        nameJas: json['nameJas'],
        caudal: json['caudal'],
        tiempoRecarga: json['tiempoRecarga'],
        volCloracion: json['volCloracion'],
        residualReservorio: json['residualReservorio'],
        cloroComercial: json['cloroComercial'],
        pGr: json['pGr'],
        qg: json['qg'],
        fecha: json['fecha'],
        iud: json['iud'],
      );
}

Future<List<CloracionModel>> getObjecClor() async {
  List<CloracionModel> objectList = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('cloracion').get();
  List<QueryDocumentSnapshot> documentList = querySnapshot.docs;

  for (var document in documentList) {
    Timestamp timestamp = document.get('fecha');
    DateTime dateTime = timestamp.toDate();
    CloracionModel object = CloracionModel(
      nameOperador: document.get('nameOperador'),
      nameJas: document.get('nameJas'),
      caudal: document.get('caudal'),
      tiempoRecarga: document.get('tiempoRecarga'),
      volCloracion: document.get('volCloracion'),
      residualReservorio: document.get('residualReservorio'),
      cloroComercial: document.get('cloroComercial'),
      pGr: document.get('pGr'),
      qg: document.get('qg'),
      fecha: dateTime,
      iud: document.get('iud'),
      // fecVenCloro: document.get('fecVenCloro'),
      // fecVenReactivo: document.get('fecVenReactivo'),
    );
    objectList.add(object);
  }

  return objectList;
}
