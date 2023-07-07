import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/productos_controller.dart';

class RegistroCloracionScreen extends StatefulWidget {
  const RegistroCloracionScreen({Key? key}) : super(key: key);

  @override
  State<RegistroCloracionScreen> createState() =>
      _RegistroCloracionScreenState();
}

class _RegistroCloracionScreenState extends State<RegistroCloracionScreen> {
  final Stream<QuerySnapshot> _usersStream2 =
      FirebaseFirestore.instance.collection('cloracion').snapshots();

  String? uidFinal;
  final user = FirebaseAuth.instance.currentUser;
  final calcProducts = Get.put(ProductosController());
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 21, 29),
        appBar: AppBar(
          title: const Text('Registros de Cloración'),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          margin: wid > 900 && wid < 1300
              ? const EdgeInsets.symmetric(horizontal: 200)
              : wid > 1300 && wid < 1600
                  ? const EdgeInsets.symmetric(horizontal: 220)
                  : wid > 1600
                      ? const EdgeInsets.symmetric(horizontal: 500)
                      : const EdgeInsets.symmetric(horizontal: 15)
                          .copyWith(bottom: 10),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  height: 200,
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: StreamBuilder<QuerySnapshot>(
                    stream: _usersStream2,
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return ListView(
                        children: snapshot.data!.docs.map(
                          (DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            String uid = user!.uid;

                            if (document.id
                                    .substring(document.id.length - 28) ==
                                uid) {
                              String nameO = data['nameOperador'].toString();
                              String nameJ = data['nameJas'].toString();
                              String caudal = data['caudal'].toString();
                              String tiempo = data['tiempoRecarga'].toString();
                              String vol = data['volCloracion'].toString();
                              String clorResidual =
                                  data['residualReservorio'].toString();
                              String clorComercial =
                                  data['cloroComercial'].toString();
                              String pgr = data['pGr'].toString();
                              String qg = data['qg'].toString();

                              Timestamp date = data['fecha'];
                              DateTime datatime = date.toDate();

                              calcProducts.addTotalCloracion(pgr);

                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 15),
                                decoration: BoxDecoration(
                                  color: const Color(0xff1F2432),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  children: [
                                    const Divider(),
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Text('Nombre de Operador'),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              nameO,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Text('Nombre de Jass'),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              nameJ,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Text('Caudal'),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '$caudal L/S',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Expanded(
                                            child: Text('Tiempo Recarga')),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '$tiempo Dias',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Expanded(
                                            child:
                                                Text('Volumen de Cloracion')),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '$vol L',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Expanded(
                                          child: Text(
                                              'Concentracion de cloro residual'),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '$clorResidual ppm',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Expanded(
                                          child: Text('Cloro Comercial'),
                                        ),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '$clorComercial %',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Expanded(child: Text('P(gr)')),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '$pgr gr',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Expanded(child: Text('qg')),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '$qg Mi/min',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Expanded(
                                            child: Text('Fecha de Registro')),
                                        Expanded(
                                          child: Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              '$datatime',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                              );
                            }
                            return const SizedBox(); // Si no es el UID específico, retorna un SizedBox vacío
                          },
                        ).toList(),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
