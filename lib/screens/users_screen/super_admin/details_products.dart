import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/product_model.dart';
import '../../../routes/routes.dart';
import '../../../widgets/sliverbar_products.dart';
import '../../../widgets/sliverlis_registerPro.dart';

class ProductsDetailsScreen extends StatefulWidget {
  const ProductsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsDetailsScreen> createState() => _ProductsDetilsScreenState();
}

class _ProductsDetilsScreenState extends State<ProductsDetailsScreen> {
  var comFech = ' ';
  final _nameController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('producto').snapshots();
  List<int> cloroList = [];

  int suma = 0;
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
            const SliberAppBarProducts(),
            const SliverListRegisterProducts(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => SizedBox(
                  height: 450,
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
                                    comFech = _nameController.text;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Buscar',
                                ),
                              ),
                            ),
                            const Text(
                              'Productos',
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
                                  Text('Fecha'),
                                  Text('Hora'),
                                  Text('Editar'),
                                ],
                              ),
                            ),
                            StreamBuilder<QuerySnapshot>(
                              stream: _usersStream,
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData ||
                                    snapshot.data == null) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                return Expanded(
                                  child: ListView(
                                    scrollDirection: Axis.vertical,
                                    children: snapshot.data!.docs.map(
                                      (
                                        DocumentSnapshot document,
                                      ) {
                                        Map<String, dynamic> data = document
                                            .data()! as Map<String, dynamic>;
                                        Timestamp date = data['fecha'];
                                        DateTime datatime = date.toDate();

                                        String documentId = document.id;

                                        suma = suma + int.parse(data['cloro']);

                                        final year = datatime.year;
                                        final month = datatime.month;
                                        final day = datatime.day;

                                        final hora = datatime.hour;
                                        final min = datatime.minute;

                                        String fech =
                                            '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';
                                        String minutos = min.toString();
                                        String hrs = hora.toString();

                                        hrs.length == 1
                                            ? hrs = '0$hrs'
                                            : hrs = hrs;
                                        minutos.length == 1
                                            ? minutos = '0$minutos'
                                            : minutos = minutos;

                                        String horas = '$hrs:$minutos';
                                        String a = datatime.toString();
                                        String firstTenCharacters =
                                            a.substring(0, 10);
                                        if (_nameController.text
                                            .contains(firstTenCharacters)) {
                                          return itemProduct(data, fech,
                                              documentId, horas, context);
                                        }
                                        if (!data['uid'].isNotEmpty) {
                                          return itemProduct(data, fech,
                                              documentId, horas, context);
                                        }
                                        if (_nameController.text.isEmpty) {
                                          return itemProduct(data, fech,
                                              documentId, horas, context);
                                        } else {
                                          return const SizedBox();
                                        }
                                      },
                                    ).toList(),
                                  ),
                                );
                              },
                            ),
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

  GestureDetector itemProduct(Map<String, dynamic> data, String fech,
      String documentId, String horas, BuildContext context) {
    return GestureDetector(
      onTap: () {
        String uid = data['uid'];

        showDialogWithList(uid, fech);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: const Color(0xff1F2432),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Dismissible(
          key: Key(documentId),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Aquí puedes realizar la eliminación del dato de Firestore
            FirebaseFirestore.instance
                .collection('producto')
                .doc(documentId)
                .delete();
          },
          background: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          secondaryBackground: Container(
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: ListTile(
            leading: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 600,
              height: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      fech,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      horas,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.editproductsDetails,
                          arguments: {
                            'cloro': data['cloro'].toString(),
                            'reactivo': data['reactivo'].toString(),
                            'epp': data['epp'].toString(),
                            'balde': data['balde'].toString(),
                            'balde20': data['balde20'].toString(),
                            'mangeras': data['mangueras'].toString(),
                            'carretilla': data['carretilla'].toString(),
                            'equiComp': data['equiComp'].toString(),
                            'fecVenCloro': data['fecVenCloro'],
                            'fecVenReactivo': data['fecVenReactivo'],
                            'uid': data['uid'].toString(),
                          },
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showDialogWithList(String uid, String fehc) async {
    List<ProductModel> objectList = await getObjectListP();
    final currentContext = context;

    // ignore: use_build_context_synchronously
    await showDialog(
      context: currentContext,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: AlertDialog(
            backgroundColor: const Color(0xff1F2432),
            title: const Text(
              'Producto(s)',
              style: TextStyle(color: Colors.white),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: objectList.map((obj) {
                  DateTime feAnio = obj.fecha!;

                  final year = feAnio.year;
                  final month = feAnio.month;
                  final day = feAnio.day;

                  final min = feAnio.minute;
                  final horas = feAnio.hour;

                  String fech =
                      '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}';

                  DateTime feAnio2 = obj.fecVenCloro!;

                  final year2 = feAnio2.year;
                  final month2 = feAnio2.month;
                  final day2 = feAnio2.day;

                  String fechCloroVenc =
                      '$year2-${month2.toString().padLeft(2, '0')}-${day2.toString().padLeft(2, '0')}';
                  DateTime feAnio3 = obj.fecVenReactivo!;

                  final year3 = feAnio3.year;
                  final month3 = feAnio3.month;
                  final day3 = feAnio3.day;

                  String fechReactVenc =
                      '$year3-${month3.toString().padLeft(2, '0')}-${day3.toString().padLeft(2, '0')}';

                  if (uid == obj.uid.toString() && fech == fech) {
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
                        Text(
                          fech,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '$horas:$min',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        //////CLORO
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Cloro'),
                            Text(
                              obj.cloro!.toLowerCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),

                        ///CLORO VENCIMIENTO
                        ///
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Caducidad'),
                            Text(
                              fechCloroVenc,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        ////Reactivo
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Reactivo'),
                            Text(
                              obj.reactivo!.toLowerCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        //Reactivo vencimiento
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Caducidad'),
                            Text(
                              fechReactVenc,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Epp'),
                            Text(
                              obj.epp!.toLowerCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        //balde5
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Balde'),
                            Text(
                              obj.balde!.toLowerCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        //balde20
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Balde 20L'),
                            Text(
                              obj.balde20!.toLowerCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Mangeras'),
                            Text(
                              obj.mangueras!.toLowerCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Carretillas'),
                            Text(
                              obj.carretilla!.toLowerCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Equipo Comparar de Cloro'),
                            Text(
                              obj.equiComp!.toLowerCase(),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const Divider(
                          color: Colors.white,
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
          ),
        );
      },
    );
  }
}
