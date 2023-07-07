// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sistem_weatherv2/models/product_model.dart';
import 'package:sistem_weatherv2/routes/routes.dart';

import 'package:uuid/uuid.dart';

class ProductosScreeen extends StatefulWidget {
  const ProductosScreeen({Key? key}) : super(key: key);

  @override
  State<ProductosScreeen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends State<ProductosScreeen> {
  //////
  ///bool showProgress = false;
  bool showProgress = false;
  // ignore:
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _cloroController = TextEditingController();
  final _reactivoController = TextEditingController();
  final _eppController = TextEditingController();
  final _baldeController = TextEditingController();
  final _balde20Controller = TextEditingController();
  final _mangerasController = TextEditingController();
  final _carretillaController = TextEditingController();
  final _comparadorController = TextEditingController();

  DateTime _date = DateTime.now();
  DateTime _date2 = DateTime.now();
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _date = value!;
      });
    });
  }

  void _showDatePicker2() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    ).then((value) {
      setState(() {
        _date2 = value!;
      });
    });
  }

  String valor = '0';

  @override
  Widget build(BuildContext context) {
    int dia;
    int mes;
    int anio;
    dia = _date.day;
    mes = _date.month;
    anio = _date.year;

    int dia2;
    int mes2;
    int anio2;
    dia2 = _date2.day;
    mes2 = _date2.month;
    anio2 = _date2.year;

    final wid = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 21, 29),
      appBar: AppBar(
        title: const Text("Registro Productos"),
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
            SingleChildScrollView(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //name

                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffb4b4b4).withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextFormField(
                                  controller: _cloroController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Cloro: kg',
                                    hintText: '0 kg',
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }

                                    final numericValue = int.tryParse(value);

                                    if (numericValue == null) {
                                      return 'Ingrese solo números';
                                    }

                                    if (numericValue < 0 ||
                                        numericValue >= 1000) {
                                      return 'Ingrese un cantidad positiva menor a 1000';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('Fecha de vencimiento'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          return _showDatePicker();
                                        },
                                        child: const Icon(
                                          Icons.calendar_month,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text('$dia/$mes/$anio')
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffb4b4b4).withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextFormField(
                                  controller: _reactivoController,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Reactivo DPD: Unidad',
                                    hintText: '0 Unidad(s)',
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return null;
                                    }

                                    final numericValue = int.tryParse(value);

                                    if (numericValue == null) {
                                      return 'Ingrese solo números';
                                    }

                                    if (numericValue < 0 ||
                                        numericValue >= 1000) {
                                      return 'Ingrese un cantidad positiva menor a 1000';
                                    }

                                    return null;
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Text('Fecha de vencimiento'),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      MaterialButton(
                                        onPressed: () {
                                          return _showDatePicker2();
                                        },
                                        child: const Icon(
                                          Icons.calendar_month,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text('$dia2/$mes2/$anio2')
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _eppController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Epp Global',
                              hintText: '0',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }

                              final numericValue = int.tryParse(value);

                              if (numericValue == null) {
                                return 'Ingrese solo números';
                              }

                              if (numericValue < 0 || numericValue >= 1000) {
                                return 'Ingrese un cantidad positiva menor a 1000';
                              }

                              return null;
                            },
                          ),
                        ),

                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _baldeController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Balde de 5 Litros',
                              hintText: '0 Unidad(s)',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }

                              final numericValue = int.tryParse(value);

                              if (numericValue == null) {
                                return 'Ingrese solo números';
                              }

                              if (numericValue < 0 || numericValue >= 1000) {
                                return 'Ingrese un cantidad positiva menor a 1000';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _balde20Controller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Balde de 20 Litros',
                              hintText: '0 Unidad(s)',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }

                              final numericValue = int.tryParse(value);

                              if (numericValue == null) {
                                return 'Ingrese solo números';
                              }

                              if (numericValue < 0 || numericValue >= 1000) {
                                return 'Ingrese un cantidad positiva menor a 1000';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _mangerasController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Mangeras: Unidad',
                              hintText: '0 Unidad(s)',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }

                              final numericValue = int.tryParse(value);

                              if (numericValue == null) {
                                return 'Ingrese solo números';
                              }

                              if (numericValue < 0 || numericValue >= 1000) {
                                return 'Ingrese un cantidad positiva menor a 1000';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _carretillaController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Carretilla: Unidad',
                              hintText: '0 Unidad(s)',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }

                              final numericValue = int.tryParse(value);

                              if (numericValue == null) {
                                return 'Ingrese solo números';
                              }

                              if (numericValue < 0 || numericValue >= 1000) {
                                return 'Ingrese un cantidad positiva menor a 1000';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _comparadorController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Equipo Comparador de cloro:  Unidad',
                              hintText: '0 Unidad(s)',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return null;
                              }

                              final numericValue = int.tryParse(value);

                              if (numericValue == null) {
                                return 'Ingrese solo números';
                              }

                              if (numericValue < 0 || numericValue >= 1000) {
                                return 'Ingrese un cantidad positiva menor a 1000';
                              }

                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),

                        MaterialButton(
                          textColor: Colors.white,
                          onPressed: () {
                            const CircularProgressIndicator();
                            setState(() {
                              showProgress = true;
                            });

                            productoRegistration(
                              _cloroController.text,
                              _reactivoController.text,
                              _eppController.text,
                              _baldeController.text,
                              _balde20Controller.text,
                              _mangerasController.text,
                              _carretillaController.text,
                              _comparadorController.text,
                              _date,
                              _date2,
                            );
                          },
                          color: const Color(0xff4861FF),
                          child: const Text('registrar'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  productoRegistration(
    String cloro,
    String reactivo,
    String epp,
    String balde,
    String balde20,
    String mangeras,
    String carretilla,
    String comparador,
    DateTime venciCloro,
    DateTime veciReact,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    ProductModel productModel = ProductModel();

    cloro.isEmpty
        ? productModel.cloro = cloro = '0'
        : productModel.cloro = cloro;
    reactivo.isEmpty
        ? productModel.reactivo = reactivo = '0'
        : productModel.reactivo = reactivo;
    epp.isEmpty ? productModel.epp = epp = '0' : productModel.epp = epp;
    balde.isEmpty
        ? productModel.balde = balde = '0'
        : productModel.balde = balde;
    balde20.isEmpty
        ? productModel.balde20 = balde20 = '0'
        : productModel.balde20 = balde;
    mangeras.isEmpty
        ? productModel.mangueras = mangeras = '0'
        : productModel.mangueras = mangeras;
    carretilla.isEmpty
        ? productModel.carretilla = carretilla = '0'
        : productModel.carretilla = carretilla;
    comparador.isEmpty
        ? productModel.equiComp = comparador = '0'
        : productModel.equiComp = comparador;

    productModel.fecVenCloro = venciCloro;
    productModel.fecVenReactivo = veciReact;
    productModel.fecha = DateTime.now();
    productModel.uid = generateUniqueId();

    bool fechCloroNow = (DateTime.now().copyWith(
          hour: 0,
          minute: 0,
          microsecond: 0,
          millisecond: 0,
          second: 0,
        ) ==
        productModel.fecVenCloro!.copyWith(
          hour: 0,
          minute: 0,
          microsecond: 0,
          millisecond: 0,
          second: 0,
        ));
    bool fechCloroAfter = (DateTime.now()
        .copyWith(hour: 0, minute: 0, microsecond: 0, millisecond: 0, second: 0)
        .isAfter(productModel.fecVenCloro!.copyWith(
          hour: 0,
          minute: 0,
          microsecond: 0,
          millisecond: 0,
          second: 0,
        )));

    bool fechReactNow = (DateTime.now().copyWith(
          hour: 0,
          minute: 0,
          microsecond: 0,
          millisecond: 0,
          second: 0,
        ) ==
        productModel.fecVenReactivo!.copyWith(
          hour: 0,
          minute: 0,
          microsecond: 0,
          millisecond: 0,
          second: 0,
        ));
    bool fechReactAfter = (DateTime.now()
        .copyWith(hour: 0, minute: 0, microsecond: 0, millisecond: 0, second: 0)
        .isAfter(productModel.fecVenReactivo!.copyWith(
          hour: 0,
          minute: 0,
          microsecond: 0,
          millisecond: 0,
          second: 0,
        )));
    if (fechCloroNow == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Fecha de caducidad de Cloro no puede ser la de Hoy'),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (fechCloroAfter == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Fecha de caducidad de Cloro no puede ser inferior a la de hoy'),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (fechReactNow == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content:
              Text('Fecha de caducidad de Reactivo DPD no puede ser la de Hoy'),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (fechReactAfter == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Fecha de caducidad de Reactivo DPD no puede ser inferior a la de hoy'),
          backgroundColor: Colors.red,
        ),
      );
    }
    if (fechCloroNow == false &&
        fechCloroAfter == false &&
        fechReactNow == false &&
        fechReactAfter == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Registro exitoso'),
          backgroundColor: Colors.green,
        ),
      );

      Future.delayed(const Duration(seconds: 4), () async {
        await firebaseFirestore
            .collection("producto")
            .doc(productModel.uid)
            .set(productModel.toMap());
        productoRegistration2();

        Navigator.popUntil(
            context, ModalRoute.withName(Routes.productsDetails));
      });
    }
  }

  String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  productoRegistration2() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    ProductModel productModel = ProductModel();

    List<ProductModel> objectList = await getObjectListP();

    int sumaC = 0;
    int sumaRea = 0;
    int sumaEpp = 0;
    int sumaBal5 = 0;
    int sumaBal20 = 0;
    int sumaMang = 0;
    int sumaCarre = 0;
    int sumaEquip = 0;

    for (int i = 0; i < objectList.length; i++) {
      ProductModel element = objectList[i];
      int cloroValue = int.parse(element.cloro.toString());
      sumaC += cloroValue;
      int reactValue = int.parse(element.reactivo.toString());
      sumaRea += reactValue;
      int eppValue = int.parse(element.epp.toString());
      sumaEpp += eppValue;
      int balde5Value = int.parse(element.balde.toString());
      sumaBal5 += balde5Value;
      int balde20Value = int.parse(element.balde20.toString());
      sumaBal20 += balde20Value;
      int mangValue = int.parse(element.mangueras.toString());
      sumaMang += mangValue;
      int carreValue = int.parse(element.carretilla.toString());
      sumaCarre += carreValue;
      int equiValue = int.parse(element.equiComp.toString());
      sumaEquip += equiValue;
    }

    productModel.cloro = sumaC.toString();
    productModel.reactivo = sumaRea.toString();
    productModel.epp = sumaEpp.toString();
    productModel.balde = sumaBal5.toString();
    productModel.balde20 = sumaBal20.toString();
    productModel.mangueras = sumaMang.toString();
    productModel.carretilla = sumaCarre.toString();
    productModel.equiComp = sumaEquip.toString();

    // productModel.fecVenCloro = venciCloro;
    // productModel.fecVenReactivo = veciReact;

    productModel.fecha = DateTime.now();
    productModel.uid = generateUniqueId();

    await firebaseFirestore
        .collection("totalProductos")
        .doc('total2')
        .set(productModel.toMap());
  }
}
