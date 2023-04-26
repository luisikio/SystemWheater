// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/screens/homelogueado/home_logueado_mobile.dart';

import '../../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //////
  ///bool showProgress = false;
  bool showProgress = false;
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

  List<String> options = [
    'admin',
    'operario',
  ];

  var _currentItemSelected = "operario";
  var rool = "operario";

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("${arguments}"),
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
                      hintText: 'name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  //apellido
                  TextFormField(
                    controller: _apellidoController,
                    decoration: const InputDecoration(
                      hintText: 'apellido',
                    ),
                  ),
                  const SizedBox(height: 20),
                  //email
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      hintText: 'email',
                    ),
                    onChanged: (value) {},
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  //telefono
                  TextFormField(
                    controller: _telefonoController,
                    decoration: const InputDecoration(
                      hintText: 'telefono',
                    ),
                  ),
                  const SizedBox(height: 20),
                  //password
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: 'password',
                    ),
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 20),
                  //confirmarPassword
                  TextFormField(
                    controller: _confirpasswordController,
                    decoration: const InputDecoration(
                      hintText: 'confirmarPassword',
                    ),
                    validator: (value) {
                      if (_confirpasswordController.text !=
                          _passwordController.text) {
                        return "Password did not match";
                      } else {
                        return null;
                      }
                    },
                    onChanged: (value) {},
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('ROL'),
                      const SizedBox(width: 20),
                      DropdownButton<String>(
                        value: rool,
                        items: options
                            .map(
                              (item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _currentItemSelected = value!;
                            rool = value;
                          });
                        },
                      ),
                    ],
                  ),
                  MaterialButton(
                    onPressed: () {
                      const CircularProgressIndicator();
                      setState(() {
                        showProgress = true;
                      });
                      signUp(
                        _emailController.text,
                        _passwordController.text,
                        rool,
                        _nameController.text,
                        _apellidoController.text,
                        _telefonoController.text,
                      );
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

  void signUp(String email, String password, String rool, String name,
      String apellido, String telefono) async {
    const CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.toString(), password: password.toString())
          .then((value) =>
              {postDetailsToFirestore(email, rool, name, apellido, telefono)})
          .catchError(
        (e) {
          return null;
        },
      );
    }
  }

  postDetailsToFirestore(String email, String rool, String name,
      String apellido, String telefono) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.name = name;
    userModel.apellido = apellido;
    userModel.email = email;
    userModel.telefono = telefono;
    userModel.rool = rool;
    userModel.uid = user!.uid;
    await firebaseFirestore
        .collection("user")
        .doc(user.uid)
        .set(userModel.toMap());
    // Navigator.pushReplacementNamed(context, LoginPage());
    // Navigator.pushAndRemoveUntil(context, Register(), (route) => false);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => const HomeLogueadoMobileScreen(),
      ),
    );
  }
}
