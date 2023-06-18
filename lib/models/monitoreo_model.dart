import 'package:cloud_firestore/cloud_firestore.dart';

class MonitoreoModel {
  String? nameJass;
  String? responsable;
  String? autoridad;
  String? reservorio;
  String? primeraVivenda;
  String? viviendaIntermedia;
  String? viviendaFinal;

  DateTime? fecha;
  String? iud;

  MonitoreoModel({
    this.nameJass,
    this.responsable,
    this.autoridad,
    this.reservorio,
    this.primeraVivenda,
    this.viviendaIntermedia,
    this.viviendaFinal,
    this.fecha,
    this.iud,
  });
  factory MonitoreoModel.fromMap(map) {
    return MonitoreoModel(
      nameJass: map?['nameJass'],
      responsable: map?['responsable'],
      autoridad: map?['autoridad'],
      reservorio: map?['reservorio'],
      primeraVivenda: map?['primeraVivenda'],
      viviendaIntermedia: map?['viviendaIntermedia'],
      viviendaFinal: map?['viviendaFinal'],
      fecha: map?['fecha'],
      iud: map?['iud'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nameJass': nameJass,
      'responsable': responsable,
      'autoridad': autoridad,
      'reservorio': reservorio,
      'primeraVivenda': primeraVivenda,
      'viviendaIntermedia': viviendaIntermedia,
      'viviendaFinal': viviendaFinal,
      'fecha': fecha,
      'iud': iud,
    };
  }

  static MonitoreoModel fromJson(Map<String, dynamic> json) => MonitoreoModel(
        nameJass: json['nameJass'],
        responsable: json['responsable'],
        autoridad: json['autoridad'],
        reservorio: json['reservorio'],
        primeraVivenda: json['primeraVivenda'],
        viviendaIntermedia: json['viviendaIntermedia'],
        viviendaFinal: json['viviendaFinal'],
        fecha: json['fecha'],
        iud: json['iud'],
      );
}

Future<List<MonitoreoModel>> getObjecMoni() async {
  List<MonitoreoModel> objectList = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('monitoreo').get();
  List<QueryDocumentSnapshot> documentList = querySnapshot.docs;

  for (var document in documentList) {
    Timestamp timestamp = document.get('fecha');
    DateTime dateTime = timestamp.toDate();
    MonitoreoModel object = MonitoreoModel(
      nameJass: document.get('nameJass'),
      responsable: document.get('responsable'),
      autoridad: document.get('autoridad'),
      reservorio: document.get('reservorio'),
      primeraVivenda: document.get('primeraVivenda'),
      viviendaIntermedia: document.get('viviendaIntermedia'),
      viviendaFinal: document.get('viviendaFinal'),
      fecha: dateTime,
      iud: document.get('iud'),
      // fecVenCloro: document.get('fecVenCloro'),
      // fecVenReactivo: document.get('fecVenReactivo'),
    );
    objectList.add(object);
  }

  return objectList;
}
