import 'package:cloud_firestore/cloud_firestore.dart';

class NameJassModel {
  String? uid;
  String? provincia;
  String? departamento;
  String? distrito;
  String? caserio;
  String? nombre;
  String? totalFam;
  String? famCovertura;
  String? famSinCovertura;
  String? reconocimiento;
  String? cloro;
  String? reactivo;
  String? epp;
  String? balde;
  String? balde20;
  String? mangueras;
  String? carretilla;
  String? equiComp;

  DateTime? fecVenCloro;
  DateTime? fecVenReactivo;

  NameJassModel({
    this.uid,
    this.provincia,
    this.departamento,
    this.distrito,
    this.caserio,
    this.nombre,
    this.totalFam,
    this.famCovertura,
    this.famSinCovertura,
    this.reconocimiento,
    this.cloro,
    this.reactivo,
    this.epp,
    this.balde,
    this.balde20,
    this.mangueras,
    this.carretilla,
    this.equiComp,
    this.fecVenCloro,
    this.fecVenReactivo,
  });
  factory NameJassModel.fromMap(map) {
    return NameJassModel(
      uid: map?['uid'],
      provincia: map?['provincia'],
      departamento: map?['departamento'],
      distrito: map?['distrito'],
      caserio: map?['caserio'],
      nombre: map?['nombre'],
      totalFam: map?['totalFam'],
      famCovertura: map?['famCovertura'],
      famSinCovertura: map?['famSinCovertura'],
      reconocimiento: map?['reconocimiento'],
      cloro: map?['cloro'],
      reactivo: map?['reactivo'],
      epp: map?['epp'],
      balde: map?['balde'],
      balde20: map?['balde20'],
      mangueras: map?['mangueras'],
      carretilla: map?['carretilla'],
      equiComp: map?['equiComp'],
      fecVenCloro: map?['fecVenCloro'],
      fecVenReactivo: map?['fecVenReactivo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'provincia': provincia,
      'departamento': departamento,
      'distrito': distrito,
      'caserio': caserio,
      'nombre': nombre,
      'totalFam': totalFam,
      'famCovertura': famCovertura,
      'famSinCovertura': famSinCovertura,
      'reconocimiento': reconocimiento,
      'cloro': cloro,
      'reactivo': reactivo,
      'epp': epp,
      'balde': balde,
      'balde20': balde20,
      'mangueras': mangueras,
      'carretilla': carretilla,
      'equiComp': equiComp,
      'fecVenCloro': fecVenCloro,
      'fecVenReactivo': fecVenReactivo,
    };
  }

  static NameJassModel fromJson(Map<String, dynamic> json) => NameJassModel(
        uid: json['uid'],
        provincia: json['provincia'],
        departamento: json['departamento'],
        distrito: json['distrito'],
        caserio: json['caserio'],
        nombre: json['nombre'],
        totalFam: json['totalFam'],
        famCovertura: json['famCovertura'],
        famSinCovertura: json['famSinCovertura'],
        reconocimiento: json['reconocimiento'],
        cloro: json['cloro'],
        reactivo: json['reactivo'],
        epp: json['epp'],
        balde: json['balde'],
        balde20: json['balde20'],
        mangueras: json['mangueras'],
        carretilla: json['carretilla'],
        equiComp: json['equiComp'],
        fecVenCloro: json['fecVenCloro'],
        fecVenReactivo: json['fecVenReactivo'],
      );
}

Future<List<NameJassModel>> getObjectList() async {
  List<NameJassModel> objectList = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('JasRegistration').get();
  List<QueryDocumentSnapshot> documentList = querySnapshot.docs;

  for (var document in documentList) {
    NameJassModel object = NameJassModel(
      provincia: document.get('provincia'),
      departamento: document.get('departamento'),
      distrito: document.get('distrito'),
      caserio: document.get('caserio'),
      nombre: document.get('nombre'),
      totalFam: document.get('totalFam'),
      famCovertura: document.get('famCovertura'),
      famSinCovertura: document.get('famSinCovertura'),
      reconocimiento: document.get('reconocimiento'),
      cloro: document.get('cloro'),
      reactivo: document.get('reactivo'),
      epp: document.get('epp'),
      balde: document.get('balde'),
      balde20: document.get('balde20'),
      mangueras: document.get('mangueras'),
      carretilla: document.get('carretilla'),
      equiComp: document.get('equiComp'),
      // fecVenCloro: document.get('fecVenCloro'),
      // fecVenReactivo: document.get('fecVenReactivo'),
    );
    objectList.add(object);
  }

  return objectList;
}
