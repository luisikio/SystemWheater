// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/models/product_model.dart';

import 'package:sistem_weatherv2/screens/users_screen/super_admin/super_admin_screen.dart';

class ProductosScreeen extends StatefulWidget {
  const ProductosScreeen({Key? key}) : super(key: key);

  @override
  State<ProductosScreeen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<ProductosScreeen> {
  //////
  ///bool showProgress = false;
  bool showProgress = false;
  // ignore:
  final _formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final _nameController = TextEditingController();
  final _cantidadController = TextEditingController();
  final _marcaController = TextEditingController();
  final _precioController = TextEditingController();

  // CollectionReference ref2 = FirebaseFirestore.instance.collection('jass');
  // final _provinciaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro Productos"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //name
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'nombre',
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _cantidadController,
                    decoration: const InputDecoration(
                      hintText: 'cantidad',
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextFormField(
                    controller: _marcaController,
                    decoration: const InputDecoration(
                      hintText: 'marca',
                    ),
                    onChanged: (value) {},
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _precioController,
                    decoration: const InputDecoration(
                      hintText: 'precio',
                    ),
                  ),
                  const SizedBox(height: 20),

                  MaterialButton(
                    onPressed: () {
                      const CircularProgressIndicator();
                      setState(() {
                        showProgress = true;
                      });
                      jassRegistration(
                          _nameController.text,
                          _cantidadController.text,
                          _marcaController.text,
                          _precioController.text);
                      //_nameController.clear();
                    },
                    color: Colors.amber,
                    child: const Text('registrar'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  jassRegistration(
      String name, String cantidad, String marca, String precio) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    ProductModel productModel = ProductModel();
    productModel.name = name;
    productModel.cantidad = cantidad;
    productModel.marca = marca;
    productModel.precio = precio;

    await firebaseFirestore
        .collection("producto")
        .doc(name)
        .set(productModel.toMap());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => AdminScreen(
          id: 'superadmin',
        ),
      ),
    );
  }
}
