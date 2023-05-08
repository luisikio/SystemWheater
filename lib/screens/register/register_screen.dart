// ignore_for_file: unused_field, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/models/jass_model.dart';
import 'package:sistem_weatherv2/models/lista_jass.dart';

import 'package:sistem_weatherv2/screens/users_screen/super_admin/super_admin_screen.dart';

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

  CollectionReference ref2 = FirebaseFirestore.instance.collection('jass');
  final _provinciaController = TextEditingController();

  List<String> options = [
    'admin',
    'superadmin',
    'operario',
  ];

  var _currentItemSelected = "operario";
  var _currentItemSelectedJass = "cajamarca";
  var rool = "operario";

  var provincia = '';

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("$arguments"),
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
                  arguments == 'Registro Usuarios'
                      ? TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: 'name',
                          ),
                        )
                      : TextFormField(
                          controller: _provinciaController,
                          decoration: const InputDecoration(
                            hintText: 'provincia',
                          ),
                        ),
                  const SizedBox(height: 20),
                  //apellido
                  arguments == 'Registro Usuarios'
                      ? TextFormField(
                          controller: _apellidoController,
                          decoration: const InputDecoration(
                            hintText: 'apellido',
                          ),
                        )
                      : const Text(''),
                  const SizedBox(height: 20),
                  //email
                  arguments == 'Registro Usuarios'
                      ? TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: 'email',
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                        )
                      : const Text(''),
                  const SizedBox(height: 20),
                  //telefono
                  arguments == 'Registro Usuarios'
                      ? TextFormField(
                          controller: _telefonoController,
                          decoration: const InputDecoration(
                            hintText: 'telefono',
                          ),
                        )
                      : const Text(''),
                  const SizedBox(height: 20),
                  //password
                  arguments == 'Registro Usuarios'
                      ? TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: 'password',
                          ),
                          onChanged: (value) {},
                        )
                      : const Text(''),
                  const SizedBox(height: 20),
                  //confirmarPassword
                  arguments == 'Registro Usuarios'
                      ? TextFormField(
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
                        )
                      : const Text(''),
                  const SizedBox(height: 20),
                  arguments == 'Registro Usuarios'
                      ? Row(
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
                            const SizedBox(width: 20),
                            const Text('JASS'),
                            const SizedBox(width: 20),
                            FutureBuilder(
                              future: getObjectList(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const CircularProgressIndicator(); // Muestra un indicador de progreso mientras se espera la lista de objetos
                                } else {
                                  if (snapshot.hasError) {
                                    return Text('Errors: ${snapshot.error}');
                                  } else {
                                    List<ListJass> objectList = snapshot
                                        .data!; // Obtiene la lista de objetos del snapshot
                                    return DropdownButton<String>(
                                      value: _currentItemSelectedJass,
                                      items: objectList.map((obj) {
                                        return DropdownMenuItem<String>(
                                          value: obj.provincia.toString(),
                                          child: Text(obj.provincia.toString()),
                                        );
                                      }).toList(),
                                      onChanged: (item) {
                                        setState(() {
                                          _currentItemSelectedJass =
                                              item.toString();
                                          provincia = item.toString();
                                          print(item);
                                        });
                                      },
                                    );
                                  }
                                }
                              },
                              // child: DropdownButton<String>(
                              //   value: rool,
                              //   items: options
                              //       .map(
                              //         (item) => DropdownMenuItem(
                              //           value: item,
                              //           child: Text(item),
                              //         ),
                              //       )
                              //       .toList(),
                              //   onChanged: (value) {
                              //     setState(() {
                              //       _currentItemSelected = value!;
                              //       rool = value;
                              //     });
                              //   },
                              // ),
                            ),
                          ],
                        )
                      : const Text(''),
                  MaterialButton(
                    onPressed: () {
                      const CircularProgressIndicator();
                      setState(() {
                        showProgress = true;
                      });
                      arguments == 'Registro Usuarios'
                          ? signUp(
                              _emailController.text,
                              _passwordController.text,
                              rool,
                              _nameController.text,
                              _apellidoController.text,
                              _telefonoController.text,
                              provincia,
                            )
                          : jassRegistration(_provinciaController.text);
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
      String apellido, String telefono, String provincia) async {
    const CircularProgressIndicator();
    if (_formkey.currentState!.validate()) {
      await _auth
          .createUserWithEmailAndPassword(
              email: email.toString(), password: password.toString())
          .then((value) => {
                postDetailsToFirestore(
                    email, rool, name, apellido, telefono, provincia)
              })
          .catchError(
        (e) {
          // ignore: invalid_return_type_for_catch_error
          return null;
        },
      );
    }
  }

  postDetailsToFirestore(String email, String rool, String name,
      String apellido, String telefono, String provincia) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    userModel.name = name;
    userModel.apellido = apellido;
    userModel.email = email;
    userModel.telefono = telefono;
    userModel.rool = rool;
    userModel.jass = provincia;
    //userModel.jassModel = provincia as JassModel?;

    userModel.uid = user!.uid;
    await firebaseFirestore
        .collection("user")
        .doc(user.uid)
        .set(userModel.toMap());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SuperAdminScreen(
          id: 'superadmin',
        ),
      ),
    );
  }

  jassRegistration(String provincia) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    //User? user = _auth.currentUser;
    JassModel jassModel = JassModel();
    jassModel.uid = provincia;
    jassModel.provincia = provincia;
    await firebaseFirestore
        .collection("jass")
        .doc(provincia)
        .set(jassModel.toMap());

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => SuperAdminScreen(
          id: 'superadmin',
        ),
      ),
    );
  }
}
