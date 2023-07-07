import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:sistem_weatherv2/models/user_model.dart';

import '../../../models/nombreJass_model.dart';

import '../../../widgets/cardView.dart';
import '../../home_screen.dart';

// ignore: must_be_immutable
class AdminScreen extends StatefulWidget {
  String id;

  AdminScreen({super.key, required this.id});

  @override
  State<AdminScreen> createState() => _UserOperarioScreenState();
}

class _UserOperarioScreenState extends State<AdminScreen> {
  String? id;

  String? emaill;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();
  final Stream<QuerySnapshot> _usersStream2 =
      FirebaseFirestore.instance.collection('producto').snapshots();
  final Stream<QuerySnapshot> _usersStream3 =
      FirebaseFirestore.instance.collection('JasRegistration').snapshots();

  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff1F2432),
      appBar: AppBar(
        title: const Text('Admin'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            cardView(
              usersStream3: _usersStream3,
              usersStream: _usersStream,
              usersStream2: _usersStream2,
              rool: 'admin',
            ),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15)
                  .copyWith(bottom: 10),
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xff272D3D),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Usuarios creado Recientes: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Nombres'),
                        Text('Rol'),
                        Text('Jass'),
                      ],
                    ),
                  ),
                  itemsUsers(),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 15)
                  .copyWith(bottom: 10),
              height: 300,
              decoration: BoxDecoration(
                color: const Color(0xff272D3D),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Jas registradas Recientemente: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Departamento'),
                        Text('Caserio'),
                        Text('Nombre'),
                      ],
                    ),
                  ),
                  itemsJass(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> itemsUsers() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Expanded(
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xff1F2432),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 20,
                    child: Text(
                      data['rool'].toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  leading: Container(
                    alignment: Alignment.centerLeft,
                    height: double.infinity,
                    width: 110,
                    child: Text('${data['name'] + ' ' + data['apellido']}'),
                  ),
                  trailing: Container(
                    alignment: Alignment.centerLeft,
                    width: 90,
                    height: double.infinity,
                    child: Text('${data['jass']}'),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> itemsJass() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream3,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Expanded(
          child: ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  String jasAsig = data['nombre'];

                  showDialogWithList(jasAsig);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xff1F2432),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListTile(
                    title: Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 20,
                      child: Text(
                        data['caserio'].toString(),
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    leading: Container(
                      alignment: Alignment.centerLeft,
                      height: double.infinity,
                      width: 110,
                      child: Text('${data['departamento']}'),
                    ),
                    trailing: Container(
                      alignment: Alignment.centerLeft,
                      width: 90,
                      height: double.infinity,
                      child: Text('${data['nombre']}'),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }

  Future<void> showDialogWithList(String jass) async {
    List<NameJassModel> objectList = await getObjectList();
    final currentContext = context;

    // ignore: use_build_context_synchronously
    await showDialog(
      context: currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1F2432),
          title: const Text(
            'Datos de la Jas',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: objectList.map((obj) {
              if (jass == obj.nombre.toString()) {
                return Column(
                  children: [
                    Text(
                      obj.nombre!.toLowerCase().toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Departamento'),
                        Text(
                          obj.departamento!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Provincia'),
                        Text(
                          obj.provincia!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Distrito'),
                        Text(
                          obj.distrito!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Caserio'),
                        Text(
                          obj.caserio!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Nombre'),
                        Text(
                          obj.nombre!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total de Familias'),
                        Text(
                          obj.totalFam!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Familias sin Convertura'),
                        Text(
                          obj.famSinCovertura!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Familias con Convertura'),
                        Text(
                          obj.famCovertura!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Reconocimiento de la Muni',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          obj.reconocimiento!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.white,
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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

  Future<void> showDialogWithListUser(String usuario) async {
    List<UserModel> objectList = await getObjectListUsers();
    final currentContext = context;

    // ignore: use_build_context_synchronously
    await showDialog(
      context: currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xff1F2432),
          title: const Text(
            'Datos de Usuario',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: objectList.map((obj) {
              if (usuario == obj.email.toString()) {
                return Column(
                  children: [
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Nombres'),
                        Text(
                          obj.name!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Apellidos'),
                        Text(
                          obj.apellido!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Email'),
                        Text(
                          obj.email!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Jas Asignada'),
                        Text(
                          obj.jass!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Rol'),
                        Text(
                          obj.rool!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Teléfono'),
                        Text(
                          obj.telefono!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Colors.grey,
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
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
