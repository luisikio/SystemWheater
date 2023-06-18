import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/widgets/total_products.dart';

import '../../../models/nombreJass_model.dart';
import '../../../routes/routes.dart';
import '../../../widgets/sliverbar_asignarPro.dart';

class AsignarProdcJassScreen extends StatefulWidget {
  const AsignarProdcJassScreen({Key? key}) : super(key: key);

  @override
  State<AsignarProdcJassScreen> createState() => _AsignarProdcJassScreenState();
}

class _AsignarProdcJassScreenState extends State<AsignarProdcJassScreen> {
  final _nameController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('JasRegistration').snapshots();
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    print(wid);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 21, 29),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        margin: wid > 900 && wid < 1300
            ? const EdgeInsets.symmetric(horizontal: 300)
            : wid > 1300 && wid < 1600
                ? const EdgeInsets.symmetric(horizontal: 320)
                : wid > 1600
                    ? const EdgeInsets.symmetric(horizontal: 500)
                    : const EdgeInsets.symmetric(horizontal: 15)
                        .copyWith(bottom: 10),
        child: CustomScrollView(
          slivers: [
            const SliberAppBarAsigPro(),
            const TotalProducts(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => SizedBox(
                  height: 400,
                  child: ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 15)
                            .copyWith(bottom: 10),
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
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Buscar',
                                  hintStyle: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ),
                            const Text(
                              'Jas',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: const [
                                  Text('Caserio'),
                                  Text('Nombre'),
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
        ),
      ),
    );
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

              if (_nameController.text.isEmpty) {
                return GestureDetector(
                  onTap: () {
                    String jasAsig = data['nombre'];

                    showDialogWithList(jasAsig);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F2432),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(data['caserio']),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  data['nombre'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.enviarProdsJass,
                                      arguments: {
                                        'cloro': data['cloro'].toString(),
                                        'reactivo': data['reactivo'].toString(),
                                        'epp': data['epp'].toString(),
                                        'balde5l': data['balde'].toString(),
                                        'balde20l': data['balde20'].toString(),
                                        'mangeras':
                                            data['mangueras'].toString(),
                                        'carretillas':
                                            data['carretilla'].toString(),
                                        'eqComp': data['equiComp'].toString(),

                                        // 'provincia':
                                        //     data['provincia'].toString(),
                                        // 'distrito': data['distrito'].toString(),
                                        // 'caserio': data['caserio'].toString(),
                                        // 'nombre': data['nombre'].toString(),
                                        // 'totalFam': data['totalFam'].toString(),
                                        // 'famSinCovertura':
                                        //     data['famSinCovertura'].toString(),
                                        // 'famCovertura':
                                        //     data['famCovertura'].toString(),
                                        // 'reconocimiento':
                                        //     data['reconocimiento'].toString(),
                                        'uid': data['uid'].toString(),
                                        // 'jassDetails':
                                        //     _jassDetails,
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.share,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (_nameController.text
                  .toString()
                  .toLowerCase()
                  .contains(data['nombre'].toString().toLowerCase())) {
                return GestureDetector(
                  onTap: () {
                    String jasAsig = data['nombre'];

                    showDialogWithList(jasAsig);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F2432),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(
                                data['caserio'],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  data['nombre'],
                                  style: const TextStyle(fontSize: 15),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Navigator.pushNamed(
                                    //   context,
                                    //   Routes.editjassDetails,
                                    //   arguments: {
                                    //     'departamento':
                                    //         data['departamento'].toString(),
                                    //     'provincia':
                                    //         data['provincia'].toString(),
                                    //     'distrito': data['distrito'].toString(),
                                    //     'caserio': data['caserio'].toString(),
                                    //     'nombre': data['nombre'].toString(),
                                    //     'totalFam': data['totalFam'].toString(),
                                    //     'famSinCovertura':
                                    //         data['famSinCovertura'].toString(),
                                    //     'famCovertura':
                                    //         data['famCovertura'].toString(),
                                    //     'reconocimiento':
                                    //         data['reconocimiento'].toString(),
                                    //     'uid': data['uid'].toString(),
                                    //     // 'jassDetails':
                                    //     //     _jassDetails,
                                    //   },
                                    // );
                                  },
                                  icon: const Icon(
                                    Icons.check,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
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

  Future<void> showDialogWithList(String jass) async {
    List<NameJassModel> objectList = await getObjectList();
    final currentContext = context;

    // ignore: use_build_context_synchronously
    await showDialog(
      context: currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1F2432),
          title: const Text(
            'Datos de la Jas',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: objectList.map((obj) {
              if (jass == obj.nombre.toString()) {
                return Column(
                  children: [
                    Text(
                      obj.nombre!.toLowerCase().toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Departamento'),
                        Text(
                          obj.departamento!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Provincia'),
                        Text(
                          obj.provincia!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Distrito'),
                        Text(
                          obj.distrito!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Caserio'),
                        Text(
                          obj.caserio!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Nombre'),
                        Text(
                          obj.nombre!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total de Familias'),
                        Text(
                          obj.totalFam!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Familias sin Convertura'),
                        Text(
                          obj.famSinCovertura!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Familias con Convertura'),
                        Text(
                          obj.famCovertura!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Reconocimiento de la Muni',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.reconocimiento!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.amber,
                    ),
                    const Divider(
                      thickness: 2,
                      color: Colors.amber,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Productos Asignados: ',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Cloro',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.cloro.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Reactivo Dpd',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.reactivo.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Epp',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.epp.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Balde 5L',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.balde.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Balde 20L',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.balde20.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mangeras',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.mangueras.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Carretilla(s)',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.carretilla.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Equipo Comparador C.',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.equiComp.toString(),
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
