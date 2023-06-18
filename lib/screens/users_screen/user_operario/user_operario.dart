import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sistem_weatherv2/constants/constants.dart';
import 'package:sistem_weatherv2/models/cloracion_model.dart';
import 'package:sistem_weatherv2/models/monitoreo_model.dart';

import 'package:sistem_weatherv2/models/user_model.dart';
import 'package:sistem_weatherv2/routes/routes.dart';

import '../../../controller/aforo_caudal_calculator.dart';
import '../../../models/nombreJass_model.dart';

class UserOperarioScreen extends StatefulWidget {
  final String id;
  const UserOperarioScreen({super.key, required this.id});

  @override
  State<UserOperarioScreen> createState() => _UserOperarioScreenState();
}

class _UserOperarioScreenState extends State<UserOperarioScreen> {
  final calculatorCtr = Get.put(CalculatoreController());
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();

  int indexD = 0;
  // String? id;
  String? rooll;
  String? emaill;

  UserModel loggIdUser = UserModel();

  final user = FirebaseAuth.instance.currentUser;

  List<String> litros = [
    '1 Litros',
    '4 Litros',
    '10 Litros',
    '20 Litros',
  ];
  List<String> tiempo = [
    '7 Dias',
    '10 Dias',
  ];

  List<String> volumen = [
    '250 L',
    '600 L',
    '750 L',
  ];

  List<String> concentracion = [
    '1 ppm',
    '1.5 ppm',
  ];

  List<String> comercial = [
    '65 %',
    '70 %',
  ];
  var _currentItemSelected = "1 Litros";
  var litrosSelect = "1 Litros";

  var _currentItemSelected2 = "7 Dias";
  var diasSelect = "7 Dias";

  var _currentItemSelected3 = "250 L";
  var volumenSelect = "250 L";

  var _currentItemSelected4 = "1 ppm";
  var concentracionSelect = "1 ppm";

  var _currentItemSelected5 = "65 %";
  var comercialSelect = "65 %";

  final _tiempo1Controller = TextEditingController();
  final _tiempo2Controller = TextEditingController();
  final _tiempo3Controller = TextEditingController();
  final _tiempo4Controller = TextEditingController();

  final _nameController = TextEditingController();
  final _autoridadAcompana = TextEditingController();
  final _reservorio = TextEditingController();
  final _primeraVivienda = TextEditingController();
  final _viviendaIntermedia = TextEditingController();
  final _viviendaFinal = TextEditingController();
  var name;
  var apellidos;
  var email;
  var telefono;
  var jassN;
  var uid;

  var nombreJass;
  var nombreJass2;

  int valor = 0;
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    print(wid);
    return Scaffold(
      backgroundColor: const Color(0xff1F2432),
      appBar: AppBar(
        title: const Text('OPERADOR'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(blurRadius: 10.0),
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            ),
            gradient: LinearGradient(
              colors: [
                Color(0xff4861FF),
                Colors.blue,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              const Divider(
                thickness: 2,
              ),
              Expanded(
                flex: 3,
                child: ListView.builder(
                  itemCount: drawerOperador.length,
                  itemExtent: 100,
                  itemBuilder: ((context, index) {
                    final item = drawerOperador[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      height: 20,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        title: BounceInRight(
                            child: Text(
                          item.title,
                          style: const TextStyle(color: Colors.white),
                        )),
                        onTap: () {
                          setState(() {
                            //selectedDrawerItem = item;
                            indexD = index;
                          });
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.userprofile);
                      },
                      icon: const Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: indexD,
        children: [
          screen1(wid),
          screen2(wid),
          screen3(wid),
        ],
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> screen3(double wid) {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            if (data['email'] == user!.email.toString()) {
              name = data['name'];
              apellidos = data['apellido'];
              telefono = data['telefono'];
              email = data['email'];
              jassN = data['jass'];
              uid = data['uid'];
              return SingleChildScrollView(
                child: Container(
                  margin: wid > 900 && wid < 1300
                      ? const EdgeInsets.symmetric(horizontal: 200)
                      : wid > 1300 && wid < 1600
                          ? const EdgeInsets.symmetric(horizontal: 220)
                          : wid > 1600
                              ? const EdgeInsets.symmetric(horizontal: 600)
                              : const EdgeInsets.symmetric(horizontal: 15)
                                  .copyWith(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Monitoreo de cloro residual',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        data['jass'],
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
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
                          controller: _nameController
                            ..text = data['name'] + ' ' + data['apellido'],
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Responsable',
                            hintText: 'Nombres',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
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
                          controller: _autoridadAcompana,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Autoridad',
                            hintText: 'Autoridad que acompaña',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Registrar información',
                        style: TextStyle(fontWeight: FontWeight.bold),
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
                          controller: _reservorio,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Reservorio',
                            hintText: 'reservorio',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
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
                          controller: _primeraVivienda,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Primera vivenda',
                            hintText: 'primera vivienda',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
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
                          controller: _viviendaIntermedia,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Vivienda Intermedia',
                            hintText: 'vivienda intermedia',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
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
                          controller: _viviendaFinal,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            labelText: 'Vivienda Final',
                            hintText: 'vivienda final',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      MaterialButton(
                        onPressed: () async {
                          List<NameJassModel> objectList =
                              await getObjectList();

                          objectList.forEach((e) {
                            if (jassN == e.nombre.toString()) {
                              nombreJass2 = e.nombre.toString();
                            }
                          });
                          print(nombreJass2);
                          const CircularProgressIndicator();
                          if (!_autoridadAcompana.text.isEmpty &&
                              !_reservorio.text.isEmpty &&
                              !_primeraVivienda.text.isEmpty &&
                              !_viviendaFinal.text.isEmpty &&
                              !_viviendaIntermedia.text.isEmpty) {
                            monitoreoRegistration(
                              _nameController.text.trim(),
                              _autoridadAcompana.text.trim(),
                              _reservorio.text.trim(),
                              _primeraVivienda.text.trim(),
                              _viviendaIntermedia.text.trim(),
                              _viviendaFinal.text.trim(),
                              nombreJass2,
                            );
                            _autoridadAcompana.clear();
                            _reservorio.clear();
                            _primeraVivienda.clear();
                            _viviendaIntermedia.clear();
                            _viviendaFinal.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Monitoreo Registrado.'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Complete los campos antes de registrar'),
                                backgroundColor: Colors.red,
                              ),
                            );
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
                            'Registrar Monitoreo',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.registrosMonitOperario);
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
                            'Ver mis Registros de Monitoreo',
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
              );
            }
            return const SizedBox();
          }).toList(),
        );
      },
    );
  }

  SingleChildScrollView screen1(double wid) {
    return SingleChildScrollView(
      child: Container(
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
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'AFORO DEL CAUDAL',
              style: TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //////volumen
                const Text('Ingrese volumen del recipiente'),
                DropdownButton<String>(
                  dropdownColor: const Color(0xff1F2432),
                  value: _currentItemSelected,
                  items: litros
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      // value == '1 Litros' ? a == '1' : a = '0';

                      _currentItemSelected = value!;

                      litrosSelect = value;

                      calculatorCtr.addVolumRecipiente(value);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text('INGRESE TIEMPOS DE LLENADO DEL RECIPIENTE'),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //////TIEMPO 1
                const Text('Tiempo 1'),
                Container(
                  width: 130,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffb4b4b4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _tiempo1Controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Segundos',
                      hintText: 'Segundos',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    validator: (value) {
                      return value == null ? 'ingrese tiempo 1' : '';
                    },
                    onChanged: (value) {
                      if (!value.contains(RegExp(r'[^0-9]'))) {
                        setState(() {
                          calculatorCtr.addTiempo1(value);
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///TIEMPO 2
                const Text('Tiempo 2'),
                Container(
                  width: 130,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffb4b4b4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _tiempo2Controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Segundos',
                      hintText: 'Segundos',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) {
                      if (!value.contains(RegExp(r'[^0-9]'))) {
                        setState(() {
                          calculatorCtr.addTiempo2(_tiempo2Controller.text);
                        });
                      }
                    },
                    validator: (value) {
                      // ignore: prefer_is_empty
                      return (value != null && value.length >= 0)
                          ? null
                          : 'Ingrese apellidos para registrar';
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /////TIEMPO 3
                const Text('Tiempo 3'),
                Container(
                  width: 130,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffb4b4b4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: _tiempo3Controller,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Segundos',
                      hintText: 'Segundos',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) {
                      if (!value.contains(RegExp(r'[^0-9]'))) {
                        setState(() {
                          calculatorCtr.addTiempo3(_tiempo3Controller.text);
                        });
                      }
                    },
                    validator: (value) {
                      return (value != null && value.isNotEmpty)
                          ? null
                          : 'Ingrese apellidos para registrar';
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///TIEMPO4
                const Text('Tiempo 4'),
                Container(
                  width: 130,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffb4b4b4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _tiempo4Controller,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: 'Segundos',
                      hintText: 'Segundos',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    onChanged: (value) {
                      if (!value.contains(RegExp(r'[^0-9]'))) {
                        setState(() {
                          calculatorCtr.addTiempo4(_tiempo4Controller.text);
                        });
                      }
                    },
                    validator: (value) {
                      return (value != null && value.isNotEmpty)
                          ? null
                          : 'Ingrese apellidos para registrar';
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            //TIEMPO PROMEDIO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Tiempo promedio'),
                Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: 130,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xffb4b4b4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${calculatorCtr.tiempoProme()} segundos',
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Obx(
              () => Text(
                'Q= ${calculatorCtr.caudal()} LT/S',
                style: const TextStyle(fontSize: 40),
              ),
            )
          ],
        ),
      ),
    );
  }

  SingleChildScrollView screen2(double wid) {
    return SingleChildScrollView(
      child: Container(
        margin: wid > 900 && wid < 1300
            ? const EdgeInsets.symmetric(horizontal: 200)
            : wid > 1300 && wid < 1600
                ? const EdgeInsets.symmetric(horizontal: 220)
                : wid > 1600
                    ? const EdgeInsets.symmetric(horizontal: 500)
                    : const EdgeInsets.symmetric(horizontal: 15)
                        .copyWith(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              'CLORACION',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            //CAULDAL
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Caudal (Q)'),
                Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xffb4b4b4).withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Obx(() {
                    return Text(
                      ' ${calculatorCtr.caudal()} L/S',
                      textAlign: TextAlign.center,
                    );
                  }),
                ),
              ],
            ),
            //TIEMPO DE RECARGA
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ingrese tiempo de recarga'),
                DropdownButton<String>(
                  dropdownColor: const Color(0xff1F2432),
                  value: _currentItemSelected2,
                  items: tiempo
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentItemSelected2 = value!;

                      diasSelect = value;

                      calculatorCtr.timepoRecarga(value);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            ///Volumen del tanque
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Volumen del tanque de cloracion'),
                DropdownButton<String>(
                  dropdownColor: const Color(0xff1F2432),
                  value: _currentItemSelected3,
                  items: volumen
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentItemSelected3 = value!;

                      volumenSelect = value;

                      calculatorCtr.volumenTanque(value);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            ///Concentracion de cloro
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Concentracion de \ncloro residual en el reservorio',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                DropdownButton<String>(
                  dropdownColor: const Color(0xff1F2432),
                  value: _currentItemSelected4,
                  items: concentracion
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentItemSelected4 = value!;

                      concentracionSelect = value;

                      calculatorCtr.cloroResid(value);
                    });
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            ///CONC cloro comercial
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Concentracion de cloro comercial',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                DropdownButton<String>(
                  dropdownColor: const Color(0xff1F2432),
                  value: _currentItemSelected5,
                  items: comercial
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _currentItemSelected5 = value!;

                      comercialSelect = value;

                      calculatorCtr.cloroComerc(value);
                    });
                  },
                ),
              ],
            ),
            ///////
            const SizedBox(
              height: 20,
            ),

            /// gramos
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('P(gr)'),
                Text('Pesar ${calculatorCtr.gramos()} gramos'),
              ],
            ),
            const SizedBox(
              height: 20,
            ),

            /// qg
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('qg'),
                Text('${calculatorCtr.qg()} MI/min'),
              ],
            ),
            const Divider(),

            Container(
              height: 150,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  Text(
                    'En un balde de 20L diluye el agua el hipoclorito de calcio',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  Text(
                    'Deja reposar 15 minutos y luego agrega al tanque de cloración.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            MaterialButton(
              onPressed: () async {
                String nombreOpe = name + ' ' + apellidos;

                List<NameJassModel> objectList = await getObjectList();

                objectList.forEach((e) {
                  if (jassN == e.nombre.toString()) {
                    nombreJass = e.nombre.toString();
                  }
                });

                if (calculatorCtr.caudal() != 0.0) {
                  cloracionRegistration(
                    calculatorCtr.caudal().toString(),
                    calculatorCtr.tiempoRecarga.toString(),
                    calculatorCtr.volumTanque.toString(),
                    calculatorCtr.cloroResidual.toString(),
                    calculatorCtr.coloroComercial.toString(),
                    calculatorCtr.gramos().toString(),
                    calculatorCtr.qg().toString(),
                    nombreOpe,
                    nombreJass,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cloracion registrada.'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('El caudal no puede ser 0.0 L/S'),
                      backgroundColor: Colors.red,
                    ),
                  );
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
                  'Registrar Cloración',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.registrosCloraOperario);
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
                  'Ver mis Registros de Cloración',
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
    );
  }

  cloracionRegistration(
    String caudal,
    String timepoRecarga,
    String volCloracion,
    String residualReservorio,
    String cloroComercial,
    String pGr,
    String qg,
    String nameOpe,
    String nameJas,
  ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    CloracionModel cloracion = CloracionModel();
    cloracion.nameOperador = nameOpe;
    cloracion.nameJas = nameJas;
    cloracion.caudal = caudal;
    cloracion.tiempoRecarga = timepoRecarga;
    cloracion.volCloracion = volCloracion;
    cloracion.residualReservorio = residualReservorio;
    cloracion.cloroComercial = cloroComercial;
    cloracion.pGr = pGr;
    cloracion.qg = qg;
    cloracion.fecha = now;
    cloracion.iud = user!.uid;

    int year = now.year;
    int month = now.month;
    int day = now.day;

    String doc =
        year.toString() + month.toString() + day.toString() + user!.uid;

    await firebaseFirestore
        .collection("cloracion")
        .doc(doc)
        .set(cloracion.toMap());
  }

  monitoreoRegistration(
      String responsable,
      String autoridad,
      String reservorio,
      String primeraVivienda,
      String viviendaIntermedia,
      String viviendaFinal,
      String nombreJ) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    DateTime now = DateTime.now();
    MonitoreoModel monitoreo = MonitoreoModel();
    monitoreo.nameJass = nombreJ;

    monitoreo.responsable = responsable;
    monitoreo.autoridad = autoridad;
    monitoreo.reservorio = reservorio;
    monitoreo.primeraVivenda = primeraVivienda;
    monitoreo.viviendaIntermedia = viviendaIntermedia;
    monitoreo.viviendaFinal = viviendaFinal;
    monitoreo.fecha = now;
    monitoreo.iud = user!.uid;

    int year = now.year;
    int month = now.month;
    int day = now.day;

    String doc =
        year.toString() + month.toString() + day.toString() + user!.uid;

    await firebaseFirestore
        .collection("monitoreo")
        .doc(doc)
        .set(monitoreo.toMap());
  }
}
