import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../routes/routes.dart';
import '../../../widgets/sliverbar_user.dart';
import '../../../widgets/sliverlist_register.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailsScreen> createState() => _UserDetilsScreenState();
}

class _UserDetilsScreenState extends State<UserDetailsScreen> {
  final String _userDetails = 'userDetails';
  final _nameController = TextEditingController();
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();
  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 21, 29),
      body: Container(
        // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        margin: wid > 900 && wid < 1300
            ? const EdgeInsets.symmetric(horizontal: 200)
            : wid > 1300 && wid < 1600
                ? const EdgeInsets.symmetric(horizontal: 220)
                : wid > 1600
                    ? const EdgeInsets.symmetric(horizontal: 500)
                    : const EdgeInsets.symmetric(horizontal: 0)
                        .copyWith(bottom: 10),
        child: CustomScrollView(
          slivers: [
            const SliverAppBarUser(),
            const SliverListRegister(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => SizedBox(
                  height: 450,
                  child: ListView(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                    children: [
                      Container(
                        padding: const EdgeInsets.all(15),
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 15)
                            .copyWith(bottom: 10),
                        height: 400,
                        decoration: BoxDecoration(
                          color: const Color(0xff272D3D),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff272D3D),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 70,
                              child: TextField(
                                controller: _nameController,
                                onChanged: (value) {
                                  setState(() {
                                    _nameController;
                                  });
                                },
                                decoration: const InputDecoration(
                                  hintText: 'Buscar: nombres',
                                ),
                              ),
                            ),
                            const Text(
                              'Usuarios',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Expanded(child: Text('Nombres')),
                                  Expanded(
                                      child: Text('Rol',
                                          textAlign: TextAlign.center)),
                                  Expanded(
                                      child: Text(
                                    'Jass',
                                    textAlign: TextAlign.end,
                                  )),
                                ],
                              ),
                            ),
                            itemUser(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                childCount: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  StreamBuilder<QuerySnapshot<Object?>> itemUser() {
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
            scrollDirection: Axis.vertical,
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;

              if (_nameController.text.isEmpty) {
                return GestureDetector(
                  onTap: () {
                    String emailH = data['email'];
                    showDialogWithListUser(emailH);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F2432),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  '${data['name'] + ' ' + data['apellido']}')),
                          Expanded(
                            child: Text(
                              data['rool'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${data['jass']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                IconButton(
                                  alignment: Alignment.centerRight,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.edituserprofile,
                                      arguments: {
                                        'name': data['name'].toString(),
                                        'apellido': data['apellido'].toString(),
                                        'email': data['email'].toString(),
                                        'jass': data['jass'].toString(),
                                        'rool': data['rool'].toString(),
                                        'telefono': data['telefono'].toString(),
                                        'uid': data['uid'].toString(),
                                        'userDetails': _userDetails,
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if (_nameController.text
                  .toString()
                  .toLowerCase()
                  .contains(data['name'].toString().toLowerCase())) {
                return GestureDetector(
                  onTap: () {
                    String emailH = data['email'];
                    showDialogWithListUser(emailH);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xff1F2432),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ListTile(
                      title: Row(
                        children: [
                          Expanded(
                              child: Text(
                                  '${data['name'] + ' ' + data['apellido']}')),
                          Expanded(
                            child: Text(
                              data['rool'].toString(),
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${data['jass']}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                                IconButton(
                                  alignment: Alignment.centerRight,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                      context,
                                      Routes.edituserprofile,
                                      arguments: {
                                        'name': data['name'].toString(),
                                        'apellido': data['apellido'].toString(),
                                        'email': data['email'].toString(),
                                        'jass': data['jass'].toString(),
                                        'rool': data['rool'].toString(),
                                        'telefono': data['telefono'].toString(),
                                        'uid': data['uid'].toString(),
                                        'userDetails': _userDetails,
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return const SizedBox();
              }
            }).toList(),
          ),
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
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: objectList.map((obj) {
                if (usuario == obj.email.toString()) {
                  return Column(
                    children: [
                      const Divider(
                        color: Colors.amber,
                        thickness: 3,
                      ),
                      const Divider(
                        color: Colors.amber,
                        thickness: 3,
                      ),
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
