import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/nombreJass_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _jassController = TextEditingController();
  final _roolController = TextEditingController();
  final _telefonoController = TextEditingController();
  List<String> options = [
    'admin',
    'atm',
    'ingespecialista',
    'operario',
  ];

  var _currentItemSelected = "operario";
  var roolEdit = "operario";

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

    final String name = arguments?['name'];
    final String apellido = arguments?['apellido'];
    final String email = arguments?['email'];
    final String jass = arguments?['jass'];
    final String rool = arguments?['rool'];
    final String telefono = arguments?['telefono'];
    final String uid = arguments?['uid'];
    final String userDetails = arguments?['userDetails'];

    final wid = MediaQuery.of(context).size.width;
    print(wid);

    return Scaffold(
        backgroundColor: const Color(0xff1F2432),
        appBar: AppBar(
          title: const Text('Editar'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              margin: wid > 900 && wid < 1300
                  ? const EdgeInsets.symmetric(horizontal: 200)
                  : wid > 1300 && wid < 1600
                      ? const EdgeInsets.symmetric(horizontal: 220)
                      : wid > 1600
                          ? const EdgeInsets.symmetric(horizontal: 500)
                          : const EdgeInsets.symmetric(horizontal: 15)
                              .copyWith(bottom: 10),
              decoration: BoxDecoration(
                color: const Color(0xffb4b4b4).withOpacity(0.4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: TextFormField(
                controller: _nameController..text = name,
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
                controller: _apellidoController..text = apellido,
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
                controller: _emailController..text = email,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Email',
                  hintText: 'Email',
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                validator: (value) {
                  return (value != null && value.length >= 2)
                      ? null
                      : 'Ingrese Email para Actualizar';
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
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: false,
                      controller: _jassController..text = nombre,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Jas    $jass',
                        hintText: 'Jas',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          nombre = value;
                        });
                      },
                      validator: (value) {
                        return (value != null && value.length >= 2)
                            ? null
                            : 'Ingrese Jass para Actualizar';
                      },
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff4861FF),
                      ),
                      onPressed: () {
                        showDialogWithList();
                      },
                      child: const Text('Jas'),
                    ),
                  ),
                ],
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
                children: [
                  Expanded(
                    child: TextFormField(
                      readOnly: true,
                      controller: _roolController..text = roolEdit,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Rol     $rool',
                        hintText: 'Rol',
                        labelStyle: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      validator: (value) {
                        return (value != null && value.length >= 2)
                            ? null
                            : 'Ingrese Rol para Actualizar';
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('ROL'),
                        const SizedBox(width: 20),
                        DropdownButton<String>(
                          borderRadius: BorderRadius.circular(20),
                          dropdownColor: const Color(0xff1F2432),
                          value: roolEdit,
                          items: options
                              .map(
                                (item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              _currentItemSelected = value!;
                              roolEdit = value;
                              print(roolEdit);
                              _roolController.text = roolEdit;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
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
                controller: _telefonoController..text = telefono,
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
                    .doc(uid)
                    .update(
                  {
                    'name': _nameController.text.trim(),
                    'apellido': _apellidoController.text.trim(),
                    'email': _emailController.text.trim(),
                    'jass': _jassController.text.trim(),
                    'rool': _roolController.text.trim(),
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
        ));
  }

  Future<void> showDialogWithList() async {
    List<NameJassModel> objectList = await getObjectList();

    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1F2432),
          title: const Text(
            'Jas Registradas',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            children: objectList.map((obj) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    nombre;
                  });
                  provincia = obj.nombre!;
                  caserio = obj.caserio!;
                  departamento = obj.departamento!;
                  distrito = obj.distrito!;
                  famCovertura = obj.famCovertura!;
                  famsinCovertura = obj.famSinCovertura!;
                  nombre = obj.nombre!;
                  reconocimiento = obj.reconocimiento!;
                  totalFam = obj.totalFam!;
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      //content: Text('Selecciono Jass '),
                      content: Text('Selecciono Jass $nombre'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 4),
                    ),
                  );
                },
                child: ListTile(
                  title: Text(obj.nombre!.toUpperCase()),
                  subtitle: Text(obj.caserio!),
                ),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content:
                        Text('No selecciono jas, seleccione una por favor'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text(
                'Cerrar',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
