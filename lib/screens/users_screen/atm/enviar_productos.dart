import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sistem_weatherv2/controller/productos_controller.dart';

class EnviarProductosScreen extends StatefulWidget {
  const EnviarProductosScreen({Key? key}) : super(key: key);

  @override
  State<EnviarProductosScreen> createState() => _EnviarProductosScreenState();
}

class _EnviarProductosScreenState extends State<EnviarProductosScreen> {
  final _cloroController = TextEditingController();
  final _reactivoController = TextEditingController();
  final _eppController = TextEditingController();
  final _balde5lController = TextEditingController();
  final _balde20Controller = TextEditingController();
  final _mangerasController = TextEditingController();
  final _carretillaController = TextEditingController();
  final _equiCompController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;

    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final String cloro = arguments?['cloro'];
    final String reactivo = arguments?['reactivo'];
    final String epp = arguments?['epp'];
    final String balde5l = arguments?['balde5l'];
    final String balde20l = arguments?['balde20l'];
    final String mangeras = arguments?['mangeras'];
    final String carretillas = arguments?['carretillas'];
    final String eqComp = arguments?['eqComp'];

    final String uid = arguments?['uid'];
    final calcProducts = Get.put(ProductosController());
    return Scaffold(
        backgroundColor: const Color(0xff1F2432),
        appBar: AppBar(
          title: const Text('Asignando Productos'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            margin: wid > 900 && wid < 1300
                ? const EdgeInsets.symmetric(horizontal: 300)
                : wid > 1300 && wid < 1600
                    ? const EdgeInsets.symmetric(horizontal: 320)
                    : wid > 1600
                        ? const EdgeInsets.symmetric(horizontal: 500)
                        : const EdgeInsets.symmetric(horizontal: 15)
                            .copyWith(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Divider(),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text('Cloro: '),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('${calcProducts.cloro} kg'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text('Reactivo Dpd: '),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('${calcProducts.reactivo} u'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text('Epp: '),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('${calcProducts.epp} gl'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text('Balde 5L: '),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text('${calcProducts.balde5} u'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: Text('Balde 20L: '),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text('${calcProducts.balde20} u'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text('Mangeras: '),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text('${calcProducts.mangera} u'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text('Carretillas: '),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text('${calcProducts.carretilla} u'),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Expanded(
                                  child: Text('Eq.Comp C.: '),
                                ),
                                Expanded(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        '${calcProducts.equiComparador} u'),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                //////Cloro
                const Divider(),
                asignarPorItem(
                  calcProducts,
                  cloro,
                  uid,
                  context,
                  _cloroController,
                  'cloro',
                  calcProducts.cloro,
                ),
                const Divider(),
                asignarPorItem(
                  calcProducts,
                  reactivo,
                  uid,
                  context,
                  _reactivoController,
                  'reactivo',
                  calcProducts.reactivo,
                ),
                const Divider(),
                asignarPorItem(
                  calcProducts,
                  epp,
                  uid,
                  context,
                  _eppController,
                  'epp',
                  calcProducts.epp,
                ),
                const Divider(),
                asignarPorItem(
                  calcProducts,
                  balde5l,
                  uid,
                  context,
                  _balde5lController,
                  'balde',
                  calcProducts.balde5,
                ),
                const Divider(),
                asignarPorItem(
                  calcProducts,
                  balde20l,
                  uid,
                  context,
                  _balde20Controller,
                  'balde20',
                  calcProducts.balde20,
                ),
                const Divider(),
                asignarPorItem(
                  calcProducts,
                  mangeras,
                  uid,
                  context,
                  _mangerasController,
                  'mangueras',
                  calcProducts.mangera,
                ),
                const Divider(),
                asignarPorItem(
                  calcProducts,
                  carretillas,
                  uid,
                  context,
                  _carretillaController,
                  'carretilla',
                  calcProducts.carretilla,
                ),
                const Divider(),
                asignarPorItem(
                  calcProducts,
                  eqComp,
                  uid,
                  context,
                  _equiCompController,
                  'equiComp',
                  calcProducts.equiComparador,
                ),
                // const Divider(),
                // asignarPorItem(calcProducts, reactivo, uid, context,
                //     _reactivoController, 'reactivo'),
              ],
            ),
          ),
        ));
  }

  Form asignarPorItem(
    ProductosController calcProducts,
    String arguments,
    String uid,
    BuildContext context,
    TextEditingController controller,
    String name,
    RxString itemGtx,
  ) {
    return Form(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color(0xffb4b4b4).withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: name,
                  hintText: '0',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingresa un número';
                  }
                  final number = int.tryParse(value);
                  if (number == null || number <= 0) {
                    return 'Por favor ingresa un número positivo';
                  }
                  if (number > int.parse(itemGtx.toString())) {
                    return 'Por favor ingresa una cantidad menor al total';
                  }
                  return null; // La validación es exitosa
                },
              ),
            ),
          ),
          Expanded(
            child: MaterialButton(
              onPressed: () async {
                ///////////////Asignando Jass
                String value =
                    (int.parse(arguments) + int.parse(controller.text))
                        .toString();

                if (int.parse(controller.text) > 0 &&
                    int.parse(controller.text) <=
                        int.parse(itemGtx.toString()) &&
                    controller.text.isNotEmpty) {
                  controller.text.isEmpty
                      ? value = '0'
                      : value =
                          (int.parse(arguments) + int.parse(controller.text))
                              .toString();

                  await FirebaseFirestore.instance
                      .collection('JasRegistration')
                      .doc(uid)
                      .update(
                    {
                      name: value,
                      'uid': uid,
                    },
                  ).then(
                    (value) => ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Datos actualizados.'),
                        backgroundColor: Colors.green,
                      ),
                    ),
                  );
                }
                ///////////TOTAL PRODUCTOS
                String c = itemGtx.toString();

                var valueResult = int.parse(c) - int.parse(controller.text);

                if (valueResult >= 0 &&
                    int.parse(controller.text) > 0 &&
                    int.parse(controller.text) <=
                        int.parse(itemGtx.toString()) &&
                    controller.text.isNotEmpty) {
                  await FirebaseFirestore.instance
                      .collection('totalProductos')
                      .doc('total2')
                      .update(
                    {
                      name: valueResult.toString(),
                    },
                  ).then((value) {
                    setState(() {
                      itemGtx;
                    });
                  });
                } else {
                  const SnackBar(
                    content: Text('Tienes 0kg de Cloro'),
                    backgroundColor: Colors.red,
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color(0xff4861FF),
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  'Asignar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
