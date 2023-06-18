import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? cloro;
  String? reactivo;
  String? epp;
  String? balde;
  String? balde20;
  String? mangueras;
  String? carretilla;
  String? equiComp;
  DateTime? fecha;
  DateTime? fecVenCloro;
  DateTime? fecVenReactivo;

  String? uid;

  ProductModel({
    this.cloro,
    this.reactivo,
    this.epp,
    this.balde,
    this.balde20,
    this.mangueras,
    this.carretilla,
    this.equiComp,
    this.fecha,
    this.fecVenCloro,
    this.fecVenReactivo,
    this.uid,
  });
  factory ProductModel.fromMap(map) {
    return ProductModel(
      cloro: map?['cloro'],
      reactivo: map?['reactivo'],
      epp: map?['epp'],
      balde: map?['balde'],
      balde20: map?['balde20'],
      mangueras: map?['mangueras'],
      carretilla: map?['carretilla'],
      equiComp: map?['equiComp'],
      fecha: map?['fecha'],
      fecVenCloro: map?['fecVenCloro'],
      fecVenReactivo: map?['fecVenReactivo'],
      uid: map?['uid'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cloro': cloro,
      'reactivo': reactivo,
      'epp': epp,
      'balde': balde,
      'balde20': balde20,
      'mangueras': mangueras,
      'carretilla': carretilla,
      'equiComp': equiComp,
      'fecha': fecha,
      'fecVenCloro': fecVenCloro,
      'fecVenReactivo': fecVenReactivo,
      'uid': uid,
    };
  }

  static ProductModel fromJson(Map<String, dynamic> json) => ProductModel(
        cloro: json['cloro'],
        reactivo: json['reactivo'],
        epp: json['epp'],
        balde: json['balde'],
        balde20: json['balde20'],
        mangueras: json['mangueras'],
        carretilla: json['carretilla'],
        equiComp: json['equiComp'],
        fecha: json['fecha'],
        fecVenCloro: json['fecVenCloro'],
        fecVenReactivo: json['fecVenReactivo'],
        uid: json['uid'],
      );
}

Future<List<ProductModel>> getObjectListP() async {
  List<ProductModel> objectList = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('producto').get();
  List<QueryDocumentSnapshot> documentList = querySnapshot.docs;

  for (var document in documentList) {
    Timestamp timestamp = document.get('fecha');
    DateTime dateTime = timestamp.toDate();

    Timestamp timestampCloro = document.get('fecVenCloro');
    DateTime dateTimeCloro = timestampCloro.toDate();

    Timestamp timestampReac = document.get('fecVenReactivo');
    DateTime dateTimeReac = timestampReac.toDate();
    ProductModel object = ProductModel(
      cloro: document.get('cloro'),
      reactivo: document.get('reactivo'),
      epp: document.get('epp'),
      balde: document.get('balde'),
      balde20: document.get('balde20'),
      mangueras: document.get('mangueras'),
      carretilla: document.get('carretilla'),
      equiComp: document.get('equiComp'),
      fecha: dateTime,
      fecVenCloro: dateTimeCloro,
      fecVenReactivo: dateTimeReac,
      uid: document.get('uid'),
    );
    objectList.add(object);
  }

  return objectList;
}
