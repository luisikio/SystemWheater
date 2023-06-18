import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/nombreJass_model.dart';

class EditProfileOperarioScreen extends StatefulWidget {
  const EditProfileOperarioScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileOperarioScreen> createState() =>
      _EditProfileOperarioScreenState();
}

class _EditProfileOperarioScreenState extends State<EditProfileOperarioScreen> {
  final _nameController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _telefonoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments2 =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final String name2 = arguments2?['name'];
    final String apellido2 = arguments2?['apellido'];
    final String telefono2 = arguments2?['telefono'];
    final String uid2 = arguments2?['uid'];

    final wid = MediaQuery.of(context).size.width;
    print(wid);

    return Scaffold(
        backgroundColor: const Color(0xff1F2432),
        appBar: AppBar(
          title: const Text('Editar'),
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
                  controller: _nameController..text = name2,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Nombres',
                    hintText: 'nombres',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese nombres para registrar';
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
                  controller: _apellidoController..text = apellido2,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Apellidos',
                    hintText: 'Apellidos',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    return (value != null && value.length >= 2)
                        ? null
                        : 'Ingrese apellidos para registrar';
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
                  controller: _telefonoController..text = telefono2,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Telefono',
                    hintText: 'Telefono',
                    labelStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    String pattern = r'^\+?51[1-9]\d{8}$';
                    RegExp regExp = RegExp(pattern);
                    return regExp.hasMatch(value ?? '')
                        ? null
                        : 'Numero de celular invalido';
                  },
                ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                onPressed: () async {
                  const CircularProgressIndicator();
                  await FirebaseFirestore.instance
                      .collection('user')
                      .doc(uid2)
                      .update(
                    {
                      'name': _nameController.text.trim(),
                      'apellido': _apellidoController.text.trim(),
                      'telefono': _telefonoController.text.trim(),
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
