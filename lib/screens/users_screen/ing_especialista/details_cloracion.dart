import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/cloracion_model.dart';

class DetailsCloracionScreen extends StatefulWidget {
  const DetailsCloracionScreen({Key? key}) : super(key: key);

  @override
  State<DetailsCloracionScreen> createState() => _DetailsCloracionScreenState();
}

class _DetailsCloracionScreenState extends State<DetailsCloracionScreen> {
  final _nameController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('cloracion').snapshots();
  var comFech = ' ';
  int suma = 0;

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Cloración'),
        ),
        body: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => SizedBox(
                  height: 450,
                  child: ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    children: [
                      Container(
                        margin: wid > 900 && wid < 1300
                            ? const EdgeInsets.symmetric(horizontal: 200)
                            : wid > 1300 && wid < 1600
                                ? const EdgeInsets.symmetric(horizontal: 220)
                                : wid > 1600
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 500)
                                    : const EdgeInsets.symmetric(horizontal: 15)
                                        .copyWith(bottom: 10),
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        height: 400,
                        decoration: BoxDecoration(
                          color: const Color(0xff272D3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff272D3D),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 70,
                              child: TextField(
                                controller: _nameController,
                                onChanged: (value) {
                                  setState(() {
                                    _nameController;
                                    comFech = _nameController.text;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Buscar: nombre - yyyy/mm/dd',
                                ),
                              ),
                            ),
                            const Text(
                              'Jas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text('Nombre'),
                                  Text('Fecha'),
                                ],
                              ),
                            ),
                            itemJass(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                childCount: 1,
              ),
            ),
          ],
        ));
  }

  StreamBuilder<QuerySnapshot<Object?>> itemJass() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return Expanded(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              ////
              Timestamp date = data['fecha'];
              DateTime datatime = date.toDate();

              final year = datatime.year;
              final month = datatime.month;
              final day = datatime.day;

              final hora = datatime.hour;
              final min = datatime.minute;

              String fech =
                  '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
              String minutos = min.toString();
              String hrs = hora.toString();

              hrs.length == 1 ? hrs = '0$hrs' : hrs = hrs;
              minutos.length == 1 ? minutos = '0$minutos' : minutos = minutos;

              String a = datatime.toString();
              String firstTenCharacters = a.substring(0, 10);
              //////

              if (_nameController.text.isEmpty) {
                return GestureDetector(
                  onTap: () {
                    String jasAsig = data['nameJas'];

                    showDialogWithListCloracion(jasAsig);
                  },
                  child: Container(
                    height: 50,
                    width: 300,
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F2432),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Container(
                        alignment: Alignment.center,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                                child: Text(
                              data['nameJas'].toString(),
                              textAlign: TextAlign.center,
                            )),
                            Expanded(
                                child: Text(
                              fech,
                              textAlign: TextAlign.center,
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }
              if (_nameController.text
                      .toString()
                      .toLowerCase()
                      .contains(data['nameJas'].toString().toLowerCase()) ||
                  _nameController.text.contains(firstTenCharacters)) {
                return GestureDetector(
                  onTap: () {
                    String jasAsig = data['nameJas'];

                    showDialogWithListCloracion(jasAsig);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F2432),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      leading: SizedBox(
                        height: 50,
                        width: 300,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              data['nameJas'],
                              textAlign: TextAlign.center,
                            )),
                            Text(fech),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> showDialogWithListCloracion(String jass) async {
    List<CloracionModel> objectList = await getObjecClor();
    final currentContext = context;

    // ignore: use_build_context_synchronously
    await showDialog(
      context: currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1F2432),
          title: const Text(
            'Datos de jass',
            style: TextStyle(color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: objectList.map((obj) {
                if (jass == obj.nameJas.toString()) {
                  return Column(
                    children: [
                      const Divider(
                        color: Colors.amber,
                        thickness: 3,
                      ),
                      const Divider(
                        color: Colors.amber,
                        thickness: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(child: Text('Nombres')),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                obj.nameOperador!.toLowerCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Jas'),
                          Text(
                            obj.nameJas!.toLowerCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Caudal'),
                          Text(
                            '${obj.caudal!} L/S',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Tiempo Recarga'),
                          Text(
                            '${obj.tiempoRecarga!.toLowerCase()} Dias',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Vol. Cloración'),
                          Text(
                            '${obj.volCloracion!} L',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              'Concentración de cloro residual',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${obj.residualReservorio!} ppm',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Cloro Comercial'),
                          Text(
                            '${obj.cloroComercial!} %',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('P(gr)'),
                          Text(
                            '${obj.pGr!} gr.',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('qg'),
                          Text(
                            '${obj.qg!} Mi/min',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const Text('Fecha de Ristro'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${obj.fecha!}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cerrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
