// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../routes/routes.dart';

class EditProductsScreen extends StatefulWidget {
  const EditProductsScreen({Key? key}) : super(key: key);

  @override
  State<EditProductsScreen> createState() => _EditProductsScreenState();
}

class _EditProductsScreenState extends State<EditProductsScreen> {
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
  final _mangerasController = TextEditingController();
  final _carretillaController = TextEditingController();
  final _comparadorController = TextEditingController();
  final _balde20Controller = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final String cloro = arguments?['cloro'];
    final String reactivo = arguments?['reactivo'];
    final String epp = arguments?['epp'];
    final String balde = arguments?['balde'];
    final String balde20 = arguments?['balde20'];
    final String mangeras = arguments?['mangeras'];
    final String carretilla = arguments?['carretilla'];
    final String equiComp = arguments?['equiComp'];

    final String uid = arguments?['uid'];

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
        title: const Text("Editar Productos"),
      ),
      body: Container(
        margin: wid > 900 && wid < 1300
            ? const EdgeInsets.symmetric(horizontal: 200)
            : wid > 1300 && wid < 1600
                ? const EdgeInsets.symmetric(horizontal: 220)
                : wid > 1600
                    ? const EdgeInsets.symmetric(horizontal: 600)
                    : const EdgeInsets.symmetric(horizontal: 0)
                        .copyWith(bottom: 10),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
                                  controller: _cloroController..text = cloro,
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
                                  controller: _reactivoController
                                    ..text = reactivo,
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
                            controller: _eppController..text = epp,
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
                            controller: _baldeController..text = balde,
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
                            controller: _balde20Controller..text = balde20,
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
                            controller: _mangerasController..text = mangeras,
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
                            controller: _carretillaController
                              ..text = carretilla,
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
                            controller: _comparadorController..text = equiComp,
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
                          onPressed: () async {
                            // bool fechCloroNow = (DateTime.now().copyWith(
                            //       hour: 0,
                            //       minute: 0,
                            //       microsecond: 0,
                            //       millisecond: 0,
                            //       second: 0,
                            //     ) ==
                            //     productModel.fecVenCloro);
                            // bool fechCloroAfter = (DateTime.now()
                            //     .copyWith(
                            //         hour: 0,
                            //         minute: 0,
                            //         microsecond: 0,
                            //         millisecond: 0,
                            //         second: 0)
                            //     .isAfter(productModel.fecVenCloro!));

                            // bool fechReactNow = (DateTime.now().copyWith(
                            //       hour: 0,
                            //       minute: 0,
                            //       microsecond: 0,
                            //       millisecond: 0,
                            //       second: 0,
                            //     ) ==
                            //     productModel.fecVenReactivo);
                            // bool fechReactAfter = (DateTime.now()
                            //     .copyWith(
                            //         hour: 0,
                            //         minute: 0,
                            //         microsecond: 0,
                            //         millisecond: 0,
                            //         second: 0)
                            //     .isAfter(productModel.fecVenReactivo!));
                            // if (fechCloroNow == true) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text(
                            //           'Fecha de caducidad de Cloro no puede ser la de Hoy'),
                            //       backgroundColor: Colors.red,
                            //     ),
                            //   );
                            // }
                            // if (fechCloroAfter == true) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text(
                            //           'Fecha de caducidad de Cloro no puede ser inferior a la de hoy'),
                            //       backgroundColor: Colors.red,
                            //     ),
                            //   );
                            // }
                            // if (fechReactNow == true) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text(
                            //           'Fecha de caducidad de Reactivo DPD no puede ser la de Hoy'),
                            //       backgroundColor: Colors.red,
                            //     ),
                            //   );
                            // }
                            // if (fechReactAfter == true) {
                            //   ScaffoldMessenger.of(context).showSnackBar(
                            //     const SnackBar(
                            //       content: Text(
                            //           'Fecha de caducidad de Reactivo DPD no puede ser inferior a la de hoy'),
                            //       backgroundColor: Colors.red,
                            //     ),
                            //   );
                            // }

                            await FirebaseFirestore.instance
                                .collection('producto')
                                .doc(uid)
                                .update(
                              {
                                'cloro': _cloroController.text.trim(),
                                'reactivo': _reactivoController.text.trim(),
                                'epp': _eppController.text.trim(),
                                'balde': _baldeController.text.trim(),
                                'balde20': _balde20Controller.text.trim(),
                                'mangueras': _mangerasController.text.trim(),
                                'carretilla': _carretillaController.text.trim(),
                                'equiComp': _comparadorController.text.trim(),
                                'fecVenCloro': _date,
                                'fecVenReactivo': _date2,
                                'uid': uid,
                              },
                            ).then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Datos actualizados.'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              _cloroController.clear();
                              _reactivoController.clear();
                              _eppController.clear();
                              _baldeController.clear();
                              _balde20Controller.clear();
                              _mangerasController.clear();
                              _carretillaController.clear();
                              _comparadorController.clear();
                            });
                            Future.delayed(const Duration(seconds: 4),
                                () async {
                              Navigator.pushNamed(
                                  context, Routes.productsDetails);
                            });
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
                              'Actualizar',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
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
}
