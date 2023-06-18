import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sistem_weatherv2/routes/routes.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_profile/edit_profile.dart';

import '../../../models/nombreJass_model.dart';
import '../../home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();
  final _nameController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _jass = TextEditingController();
  final _rool = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    print(wid);
    return Scaffold(
      backgroundColor: const Color(0xff1F2432),
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: _usersStream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map(
                (DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;

                  if (data['email'] == user!.email.toString()) {
                    var name = data['name'];
                    var apellidos = data['apellido'];
                    var telefono = data['telefono'];
                    var uid = data['uid'];

                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        margin: wid > 900 && wid < 1300
                            ? const EdgeInsets.symmetric(horizontal: 200)
                            : wid > 1300 && wid < 1600
                                ? const EdgeInsets.symmetric(horizontal: 220)
                                : wid > 1600
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 500)
                                    : const EdgeInsets.symmetric(horizontal: 15)
                                        .copyWith(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.black,
                                ),
                                Text(data['email']),
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xffb4b4b4).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                controller: _nameController
                                  ..text = data['name'],
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Nombres',
                                  hintText: 'Nombres',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xffb4b4b4).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                controller: _apellidoController
                                  ..text = data['apellido'],
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Apellidos',
                                  hintText: 'Apellidos',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xffb4b4b4).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                controller: _emailController
                                  ..text = data['email'],
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Email',
                                  hintText: 'Email',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                String a = data['jass'];

                                showDialogWithList(a);
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffb4b4b4).withOpacity(0.4),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: TextFormField(
                                  controller: _jass..text = data['jass'],
                                  readOnly: true,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Jas Asignada',
                                    hintText: 'Jas Asignada',
                                    labelStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xffb4b4b4).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                controller: _rool..text = data['rool'],
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Rol Asignado',
                                  hintText: 'Rol Asignado',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                color: const Color(0xffb4b4b4).withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextFormField(
                                controller: _telefonoController
                                  ..text = data['telefono'],
                                readOnly: true,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Celular',
                                  hintText: 'Celular',
                                  labelStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    logout(context);
                                  },
                                  icon: const Icon(
                                    Icons.logout,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                IconButton(
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, Routes.edituserOperprofile,
                                        arguments: {
                                          'name': name,
                                          'apellido': apellidos,
                                          'telefono': telefono,
                                          'uid': uid,
                                        });
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 50,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ).toList(),
            );
          },
        ),
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

  Future<void> showDialogWithList(String jass) async {
    List<NameJassModel> objectList = await getObjectList();
    final currentContext = context;

    // ignore: use_build_context_synchronously
    await showDialog(
      context: currentContext,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Datos de tu Jass'),
          content: Column(
            children: objectList.map((obj) {
              if (jass == obj.nombre.toString()) {
                return Column(
                  children: [
                    Text(
                      obj.nombre!.toLowerCase().toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(
                          child: Text('Departamento'),
                        ),
                        Text(
                          obj.departamento!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(child: Text('Provincia')),
                        Text(
                          obj.provincia!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(child: Text('Distrito')),
                        Text(
                          obj.distrito!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(child: Text('Caserio')),
                        Text(
                          obj.caserio!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(child: Text('Nombre')),
                        Text(
                          obj.nombre!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(child: Text('Total de Familias')),
                        Text(
                          obj.totalFam!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(child: Text('Familias sin Convertura')),
                        Text(
                          obj.famSinCovertura!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(child: Text('Familias con Convertura')),
                        Text(
                          obj.famCovertura!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(
                          child: Text(
                            'Reconocimiento de la Muni',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          obj.reconocimiento!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Expanded(
                          child: Text(
                            'cloro',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          obj.cloro!.toLowerCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
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
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
