import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditJassScreen extends StatefulWidget {
  const EditJassScreen({Key? key}) : super(key: key);

  @override
  State<EditJassScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditJassScreen> {
  final _departamentoController = TextEditingController();
  final _provinciaController = TextEditingController();
  final _distritoController = TextEditingController();
  final _caserioController = TextEditingController();
  final _nombreController = TextEditingController();
  final _totalFamController = TextEditingController();
  final _famSinCoverturaController = TextEditingController();
  final _famCoverturaController = TextEditingController();
  final _reconocimientoController = TextEditingController();
  final _uidController = TextEditingController();

  var provincia = '';
  var caserio = '';
  var departamento = '';
  var distrito = '';
  var famCovertura = '';
  var famsinCovertura = '';
  var nombre = '';
  var reconocimiento = '';
  var totalFam = '';

  @override
  void initState() {
    super.initState();
    nombre;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    final String departamento = arguments?['departamento'];
    final String provincia = arguments?['provincia'];
    final String distrito = arguments?['distrito'];
    final String caserio = arguments?['caserio'];
    final String nombre = arguments?['nombre'];
    final String totalFam = arguments?['totalFam'];
    final String famSinCovertura = arguments?['famSinCovertura'];
    final String famCovertura = arguments?['famCovertura'];
    final String reconocimiento = arguments?['reconocimiento'];
    final String uid = arguments?['uid'];

    return Scaffold(
        backgroundColor: const Color(0xff1F2432),
        appBar: AppBar(
          title: const Text('Editar Jass'),
        ),
        body: SingleChildScrollView(
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
                  controller: _departamentoController..text = departamento,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'departamento',
                    hintText: 'departamento',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese departamento para registrar';
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
                  controller: _provinciaController..text = provincia,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'provincia',
                    hintText: 'provincia',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese provincia para registrar';
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
                  controller: _distritoController..text = distrito,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'distrito',
                    hintText: 'distrito',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese distrito para Actualizar';
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
                  controller: _caserioController..text = caserio,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'caserio',
                    hintText: 'caserio',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese caserio para Actualizar';
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
                  controller: _nombreController..text = nombre,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'nombre',
                    hintText: 'nombre',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese nombre para Actualizar';
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
                  controller: _totalFamController..text = totalFam,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Total Familias',
                    hintText: 'Total Familias',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese Total Familias para Actualizar';
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
                  controller: _famSinCoverturaController
                    ..text = famSinCovertura,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Familia sin Covertura',
                    hintText: 'Familia sin Covertura',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese Familia sin Covertura para Actualizar';
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
                  controller: _famCoverturaController..text = famCovertura,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Familia con Convertura',
                    hintText: 'Familia con Convertura',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese Familia con Convertura para Actualizar';
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
                  controller: _reconocimientoController..text = reconocimiento,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'reconocimiento',
                    hintText: 'reconocimiento',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese reconocimiento para Actualizar';
                  },
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () async {
                  const CircularProgressIndicator();

                  await FirebaseFirestore.instance
                      .collection('JasRegistration')
                      .doc(uid)
                      .update(
                    {
                      'departamento': _departamentoController.text.trim(),
                      'provincia': _provinciaController.text.trim(),
                      'distrito': _distritoController.text.trim(),
                      'caserio': _caserioController.text.trim(),
                      'nombre': _nombreController.text.trim(),
                      'totalFam': _totalFamController.text.trim(),
                      'famSinCovertura': _famSinCoverturaController.text.trim(),
                      'famCovertura': _famCoverturaController.text.trim(),
                      'reconocimiento': _reconocimientoController.text.trim(),
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
        ));
  }
}
