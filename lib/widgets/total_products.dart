import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:sistem_weatherv2/controller/productos_controller.dart';

class TotalProducts extends StatefulWidget {
  const TotalProducts({
    super.key,
  });

  @override
  State<TotalProducts> createState() => _TotalProductsState();
}

class _TotalProductsState extends State<TotalProducts> {
  final calcProducts = Get.put(ProductosController());
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('totalProductos').snapshots();
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) => SizedBox(
          height: 210,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 15)
                    .copyWith(bottom: 10),
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xff272D3D),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text('Tipo'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text('Cantidad'),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: const Text('Unidad de Medida'),
                          ),
                        ),
                      ],
                    ),
                    itemUser(),
                  ],
                ),
              ),
            ],
          ),
        ),
        childCount: 1,
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> itemUser() {
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
            children: snapshot.data!.docs.map(
              (DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;

                // data['cloro'] = calcProducts.cloro;

                calcProducts.addCloro(data['cloro'].toString());
                calcProducts.addReactivo(data['reactivo']);
                calcProducts.addEpp(data['epp']);
                calcProducts.balde5(data['balde']);
                calcProducts.balde20(data['balde20']);
                calcProducts.addMangeras(data['mangueras']);
                calcProducts.carretilla(data['carretilla']);
                calcProducts.addEquiCompra(data['equiComp']);

                // print(calcProducts.cloro);

                return Container(
                  decoration: BoxDecoration(
                    color: const Color(0xff1F2432),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Column(
                      children: [
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.amber,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text('cloro'),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data['cloro'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const Text('Kg'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.amber,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text('reactivo dpd'),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data['reactivo'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const Text('Unidad'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.amber,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text('epp'),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data['epp'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const Text('Global'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.amber,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text('balde 5L'),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data['balde'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const Text('Unidad'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.amber,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text('balde 20L'),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data['balde20'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const Text('Unidad'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.amber,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text('mangeras'),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data['mangueras'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const Text('Unidad'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.amber,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text('carretilla'),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data['carretilla'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const Text('Unidad'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.amber,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Text('Equi. Comp. Cloro'),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  data['equiComp'].toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: const Text('Unidad'),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          height: 20,
                          thickness: 2,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ).toList(),
          ),
        );
      },
    );
  }
}
