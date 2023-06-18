// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/models/caserio_model.dart';
import 'package:sistem_weatherv2/models/departamento_Model.dart';
import 'package:sistem_weatherv2/models/distrito_model.dart';
import 'package:sistem_weatherv2/models/nombreJass_model.dart';

import 'package:sistem_weatherv2/models/provincia_model.dart';
import 'package:uuid/uuid.dart';

import '../../routes/routes.dart';

class JassRegisterScreeen extends StatefulWidget {
  const JassRegisterScreeen({Key? key}) : super(key: key);

  @override
  State<JassRegisterScreeen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<JassRegisterScreeen> {
  //////
  bool isChecked = false;
  bool showProgress = false;
  // ignore:
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _departamentoController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _distritoController = TextEditingController();
  final _caserioController = TextEditingController();
  final _nombreController = TextEditingController();
  final _totalController = TextEditingController();
  final _famSinConverturaController = TextEditingController();
  final _famConCoverturaController = TextEditingController();
  final _reconocidaController = TextEditingController();

  final String _Details = 'jassDetails';

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    print(wid);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 21, 29),
      appBar: AppBar(
        title: const Text("Registro Jas"),
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
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffb4b4b4).withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextFormField(
                        controller: _departamentoController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Departamento',
                          hintText: 'Departamento',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          return (value != null && value.length >= 2)
                              ? null
                              : 'Ingrese Departamento para registrar';
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
                        controller: _provinciaController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Provincia',
                          hintText: 'Provincia',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          return (value != null && value.length >= 2)
                              ? null
                              : 'Ingrese Provincia para registrar';
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
                        controller: _distritoController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Distrito',
                          hintText: 'Distrito',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          return (value != null && value.length >= 2)
                              ? null
                              : 'Ingrese Provincia para registrar';
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
                        controller: _caserioController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Caserio',
                          hintText: 'Caserio',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          return (value != null && value.length >= 2)
                              ? null
                              : 'Ingrese Caserio para registrar';
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
                        controller: _nombreController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Nombre',
                          hintText: 'Nombre',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          return (value != null && value.length >= 2)
                              ? null
                              : 'Ingrese Nombre para registrar';
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
                        controller: _totalController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Total de Familias',
                          hintText: 'Total de Familias',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese Total de Familias para registrar';
                          }

                          final regex = RegExp(r'^[0-9]+$');
                          if (!regex.hasMatch(value)) {
                            return 'Ingrese solo números';
                          }

                          if (value.length < 2) {
                            return 'El valor debe tener al menos 2 dígitos';
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
                        controller: _famSinConverturaController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Familias sin coverturas',
                          hintText: 'Familias sin coverturas',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese Total de Familias sin covertura para registrar';
                          }

                          final regex = RegExp(r'^[0-9]+$');
                          if (!regex.hasMatch(value)) {
                            return 'Ingrese solo números';
                          }

                          if (value.length < 2) {
                            return 'El valor debe tener al menos 2 dígitos';
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
                        controller: _famConCoverturaController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Familias con Covertura',
                          hintText: 'Familias con Covertura',
                          labelStyle: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Ingrese Total de Familias con covertura para registrar';
                          }

                          final regex = RegExp(r'^[0-9]+$');
                          if (!regex.hasMatch(value)) {
                            return 'Ingrese solo números';
                          }

                          if (value.length < 2) {
                            return 'El valor debe tener al menos 2 dígitos';
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text('Familias Reconocidas'),
                          Checkbox(
                            activeColor: Colors.amber,
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    MaterialButton(
                      onPressed: () {
                        const CircularProgressIndicator();
                        setState(() {
                          showProgress = true;
                        });

                        departamentoRegistration(
                          _departamentoController.text,
                        );
                        provinciaRegistration(
                          _departamentoController.text,
                          _provinciaController.text,
                        );
                        distritoRegistration(
                          _departamentoController.text,
                          _provinciaController.text,
                          _distritoController.text,
                        );
                        caserioRegistration(
                          _departamentoController.text,
                          _provinciaController.text,
                          _distritoController.text,
                          _caserioController.text,
                        );
                        nombreJassRegistration(
                          _departamentoController.text,
                          _provinciaController.text,
                          _distritoController.text,
                          _caserioController.text,
                          _nombreController.text,
                          _totalController.text,
                          _famSinConverturaController.text,
                          _famConCoverturaController.text,
                          _reconocidaController.text =
                              isChecked == true ? 'si' : 'no',
                        );
                        _departamentoController.clear();
                        _provinciaController.clear();
                        _distritoController.clear();
                        _caserioController.clear();
                        _nombreController.clear();
                        _totalController.clear();
                        _famSinConverturaController.clear();
                        _famConCoverturaController.clear();
                        _reconocidaController.clear();
                      },
                      color: const Color(0xff4861FF),
                      child: const Text(
                        'registrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  departamentoRegistration(String departamento) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    DepartamentoModel dep = DepartamentoModel();
    dep.departamento = departamento;

    await firebaseFirestore
        .collection("departamento")
        .doc(departamento.replaceAll(' ', '').toLowerCase())
        .set(dep.toMap());
  }

  provinciaRegistration(String departamento, String provincia) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    ProvinciaModel pro = ProvinciaModel();
    pro.departamento = departamento;
    pro.provincia = provincia;

    await firebaseFirestore
        .collection("provincia")
        .doc(provincia.replaceAll(' ', '').toLowerCase())
        .set(pro.toMap());
  }

  distritoRegistration(
      String departamento, String provincia, String distrito) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    DistritoModel dis = DistritoModel();
    dis.departamento = departamento;
    dis.provincia = provincia;
    dis.distrito = distrito;

    await firebaseFirestore
        .collection("distrito")
        .doc(distrito.replaceAll(' ', '').toLowerCase())
        .set(dis.toMap());
  }

  caserioRegistration(String departamento, String provincia, String distrito,
      String caserio) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    CaserioModel cas = CaserioModel();
    cas.departamento = departamento;
    cas.provincia = provincia;
    cas.distrito = distrito;
    cas.caserio = caserio;

    await firebaseFirestore
        .collection("caserio")
        .doc(caserio.replaceAll(' ', '').toLowerCase())
        .set(cas.toMap());
  }

  nombreJassRegistration(
      String departamento,
      String provincia,
      String distrito,
      String caserio,
      String nombre,
      String totalFam,
      String famSinCovertura,
      String famCovertura,
      String reconocimiento) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    NameJassModel jass = NameJassModel();
    jass.departamento = departamento;
    jass.provincia = provincia;
    jass.distrito = distrito;
    jass.caserio = caserio;
    jass.nombre = nombre;
    jass.totalFam = totalFam;
    jass.famSinCovertura = famSinCovertura;
    jass.famCovertura = famCovertura;
    jass.reconocimiento = reconocimiento;
    jass.cloro = '0';
    jass.reactivo = '0';
    jass.epp = '0';
    jass.balde = '0';
    jass.balde20 = '0';
    jass.mangueras = '0';
    jass.carretilla = '0';
    jass.equiComp = '0';
    jass.fecVenCloro = DateTime(2023);
    jass.fecVenReactivo = DateTime(2023);

    jass.uid = generateUniqueId();

    await firebaseFirestore
        .collection("JasRegistration")
        .doc(jass.uid)
        .set(jass.toMap());

    Navigator.popUntil(context, ModalRoute.withName(Routes.jassDetails));
  }

  String generateUniqueId() {
    var uuid = const Uuid();
    return uuid.v4();
  }
}
