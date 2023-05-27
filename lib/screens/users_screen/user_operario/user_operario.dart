import 'package:animate_do/animate_do.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sistem_weatherv2/constants/constants.dart';

import 'package:sistem_weatherv2/models/user_model.dart';
import 'package:sistem_weatherv2/screens/home_screen.dart';

import '../../../controller/aforo_caudal_calculator.dart';

class UserOperarioScreen extends StatefulWidget {
  final String id;
  const UserOperarioScreen({super.key, required this.id});

  @override
  State<UserOperarioScreen> createState() => _UserOperarioScreenState();
}

class _UserOperarioScreenState extends State<UserOperarioScreen> {
  final calculatorCtr = Get.put(CalculatoreController());

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
  int valor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' ${user?.email}'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
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
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: indexD,
        children: [
          screen1(),
          screen2(),
          const Center(
            child: Text('3'),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView screen1() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text('AFORO DEL CAUDAL'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              //////volumen
              const Text('Ingrese volumen del recipiente'),
              DropdownButton<String>(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            () => Text('Q= ${calculatorCtr.caudal()} LT/S'),
          )
        ],
      ),
    );
  }

  SingleChildScrollView screen2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          const Text('CLORACION'),
          //CAULDAL
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Caudal (Q)'),
              Container(
                width: 130,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xffb4b4b4).withOpacity(0.4),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Obx(
                  () => Text(' ${calculatorCtr.caudal()} L/S'),
                ),
              ),
            ],
          ),
          //TIEMPO DE RECARGA
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Ingrese tiempo de recarga'),
              DropdownButton<String>(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('Volumen del tanque de cloracion'),
              DropdownButton<String>(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Concentracion de \ncloro residual en el reservorio',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              DropdownButton<String>(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Concentracion de cloro comercial',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              DropdownButton<String>(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('qg'),
              Text('${calculatorCtr.qg()} MI/min'),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomeScreen(),
      ),
    );
  }
}
