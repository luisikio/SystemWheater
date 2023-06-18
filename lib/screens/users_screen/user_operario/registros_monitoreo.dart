import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistroMonitoreoScreen extends StatefulWidget {
  const RegistroMonitoreoScreen({Key? key}) : super(key: key);

  @override
  State<RegistroMonitoreoScreen> createState() =>
      _RegistroMonitoreoScreenState();
}

class _RegistroMonitoreoScreenState extends State<RegistroMonitoreoScreen> {
  final Stream<QuerySnapshot> _usersStream2 =
      FirebaseFirestore.instance.collection('monitoreo').snapshots();

  String? uidFinal;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    print(wid);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 18, 21, 29),
        appBar: AppBar(
          title: const Text('Registros de Cloración'),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                height: 200,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                margin: wid > 900 && wid < 1300
                    ? const EdgeInsets.symmetric(horizontal: 200)
                    : wid > 1300 && wid < 1600
                        ? const EdgeInsets.symmetric(horizontal: 220)
                        : wid > 1600
                            ? const EdgeInsets.symmetric(horizontal: 500)
                            : const EdgeInsets.symmetric(horizontal: 15)
                                .copyWith(bottom: 10),
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

                          if (document.id.substring(document.id.length - 28) ==
                              uid) {
                            String nameJass = data['nameJass'];
                            String responsable = data['responsable'].toString();
                            String autoridad = data['autoridad'].toString();
                            String reservorio = data['reservorio'].toString();
                            String primeraVivenda =
                                data['primeraVivenda'].toString();
                            String viviendaIntermedia =
                                data['viviendaIntermedia'].toString();
                            String viviendaFinal =
                                data['viviendaFinal'].toString();

                            Timestamp date = data['fecha'];
                            DateTime datatime = date.toDate();

                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: const Color(0xff1F2432),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                children: [
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Expanded(
                                          child: Text('Nombre de la Jass')),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            nameJass,
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
                                        child: Text('Responsable'),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            responsable,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Expanded(
                                          child:
                                              Text('Autoridad que acompaña')),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            autoridad,
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Expanded(child: Text('Reservorio')),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            '$reservorio mg/L',
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
                                          child: Text('Primera vivienda')),
                                      Text(
                                        '$primeraVivenda mg/L',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Expanded(
                                          child: Text('Vivienda Intermedia')),
                                      Text(
                                        '$viviendaIntermedia mg/L',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Expanded(
                                          child: Text('Vivienda Final')),
                                      Text(
                                        '$viviendaFinal mg/L',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
                                      Text(
                                        '$datatime',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
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
        ));
  }
}
