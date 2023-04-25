// ignore_for_file: unused_field

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //////
  // ignore:
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  CollectionReference ref = FirebaseFirestore.instance.collection('users');
  final _nameController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirpasswordController = TextEditingController();

  var options = [
    'admin',
    'operario',
  ];

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("${arguments}"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //name
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'name',
                  ),
                ),
                const SizedBox(height: 20),
                //apellido
                TextField(
                  controller: _apellidoController,
                  decoration: const InputDecoration(
                    hintText: 'apellido',
                  ),
                ),
                const SizedBox(height: 20),
                //email
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'email',
                  ),
                ),
                const SizedBox(height: 20),
                //telefono
                TextField(
                  controller: _telefonoController,
                  decoration: const InputDecoration(
                    hintText: 'telefono',
                  ),
                ),
                const SizedBox(height: 20),
                MaterialButton(
                  onPressed: () {},
                  color: Colors.amber,
                  child: const Text('registrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
