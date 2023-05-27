// ignore_for_file: unused_field, use_build_context_synchronously

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:sistem_weatherv2/models/jass_model.dart';
import 'package:sistem_weatherv2/models/lista_jass.dart';

import 'package:sistem_weatherv2/screens/users_screen/super_admin/super_admin_screen.dart';

import '../../models/password_alea.dart';
import '../../models/user_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  /// generate password aleatorio
  List<String> generatedPasswords = [];
  final generator = PasswordGenerator();

  String currentPassword = '';

  TextEditingController passwordController = TextEditingController();

  void generateNewPassword() {
    String password = generator.generatePassword(8);
    setState(() {
      passwordController.text = password;
    });
  }

  //////
  ///bool showProgress = false;
  bool showProgress = false;
  // ignore:
  final _formkey = GlobalKey<FormState>();

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
    'atm',
    'ingespecialista',
    'operario',
  ];

  var _currentItemSelected = "operario";
  var _currentItemSelectedJass = "cajamarca";
  var rool = "operario";

  var provincia = '';

  @override
  void initState() {
    super.initState();
    generateNewPassword();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  final user = FirebaseAuth.instance.currentUser;
  FocusNode a = FocusNode();
  FocusNode b = FocusNode();
  bool _obscureText = true;
  bool _obscureText2 = true;
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
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //name

                  arguments == 'Registro Usuarios'
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _nameController,
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
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _apellidoController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Apellidos',
                              hintText: 'apellidos',
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
                        )
                      : const Text(''),
                  const SizedBox(height: 20),
                  //email
                  arguments == 'Registro Usuarios'
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'abc@gmail.com',
                              labelText: 'Correo electrónico',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            validator: (value) {
                              String pattern =
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                              RegExp regExp = RegExp(pattern);

                              return regExp.hasMatch(value ?? '')
                                  ? null
                                  : 'Correo electronico invalido';
                            },
                            onChanged: (value) {},
                            keyboardType: TextInputType.emailAddress,
                          ),
                        )
                      : const Text(''),
                  const SizedBox(height: 20),
                  //telefono
                  arguments == 'Registro Usuarios'
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            controller: _telefonoController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              labelText: 'Celular',
                              hintText: 'Celular',
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
                        )
                      : const Text(''),
                  const SizedBox(height: 20),

                  //password
                  arguments == 'Registro Usuarios'
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            autocorrect: false,
                            obscureText: _obscureText,
                            focusNode: a,
                            controller: passwordController,
                            readOnly: true,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(a);
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: '******',
                              labelText: 'Contraseña',
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onChanged: (value) {},
                          ),
                        )
                      : const Text(''),
                  const SizedBox(height: 20),
                  //confirmarPassword
                  arguments == 'Registro Usuarios'
                      ? Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: const Color(0xffb4b4b4).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            autocorrect: false,
                            obscureText: _obscureText2,
                            focusNode: b,
                            controller: passwordController,
                            readOnly: true,
                            onFieldSubmitted: (value) {
                              FocusScope.of(context).requestFocus(b);
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _obscureText2 = !_obscureText2;
                                  });
                                },
                                icon: Icon(
                                  _obscureText2
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              border: InputBorder.none,
                              hintText: '******',
                              labelText: 'Confirmar contraseña',
                              labelStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            onChanged: (value) {},
                          ),
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
                                        });
                                      },
                                    );
                                  }
                                }
                              },
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
                      if (arguments == 'Registro Usuarios') {
                        const CircularProgressIndicator();
                        _passwordController.text = passwordController.text;
                        signUp(
                          _emailController.text,
                          _passwordController.text,
                          rool,
                          _nameController.text,
                          _apellidoController.text,
                          _telefonoController.text,
                          provincia,
                        );
                      } else {
                        jassRegistration(_provinciaController.text);
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
                        'Registrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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

    try {
      if (_formkey.currentState!.validate()) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
              email: email.toString(),
              password: password.toString(),
            )
            .then(
              (value) => {
                postDetailsToFirestore(
                  email,
                  rool,
                  name,
                  apellido,
                  telefono,
                  provincia,
                ),
                sendEmail(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                  _nameController.text.trim(),
                  _apellidoController.text.trim(),
                  _telefonoController.text.trim(),
                  rool,
                  provincia,
                ),
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AdminScreen(
                      id: email,
                    ),
                  ),
                ),
              },
            );
      }
    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          // Manejar el error de correo electrónico en uso
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('El correo electrónico ya está registrado.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  postDetailsToFirestore(String email, String rool, String name,
      String apellido, String telefono, String provincia) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final user = FirebaseAuth.instance.currentUser;
    UserModel userModel = UserModel();
    userModel.name = name;
    userModel.apellido = apellido;
    userModel.email = email;
    userModel.telefono = telefono;
    userModel.rool = rool;
    userModel.jass = provincia;

    userModel.uid = user!.uid;
    await firebaseFirestore
        .collection("user")
        .doc(user.uid)
        .set(userModel.toMap());
  }

  jassRegistration(String provincia) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

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
        builder: (_) => AdminScreen(
          id: 'superadmin',
        ),
      ),
    );
  }

  updateDisplayName(String displayName) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await user.updateDisplayName(displayName);
        // ignore: empty_catches
      } catch (e) {}
    } else {}
  }

  Future sendEmail(String emails, String password, String nombre,
      String apellido, String telefono, String rool, String jass) async {
    const serviceId = 'service_ie50lj9';
    const templateId = 'template_mlrrebg';
    const userId = 'FNPXRUrD5nIw_CQcn';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');

    try {
      final response = await http.post(
        url,
        headers: {
          'origin': 'http://localhost',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          {
            'service_id': serviceId,
            'user_id': userId,
            'template_id': templateId,
            'template_params': {
              'name': nombre,
              'message':
                  'nombre y apellidos: $nombre $apellido\n correo: $emails \n celular: $telefono \n contraseña: $password \n rol asignado: $rool \n Jass: $jass',
              'sender_email': emails,
            }
          },
        ),
      );

      if (response.statusCode == 200) {
      } else {}
      // ignore: empty_catches
    } catch (e) {}
  }
}
