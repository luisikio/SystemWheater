import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../widgets/drawer_log.dart';
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
  final user = FirebaseAuth.instance.currentUser;

  final Stream<QuerySnapshot> _usersStream2 =
      FirebaseFirestore.instance.collection('jass').snapshots();

  @override
  void dispose() {
    user!.email;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("soy id que se envia de register ${widget.id}");
    // print('soy super ${user!.email}');
    return Scaffold(
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
      drawer: DraweLog(user: user),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(
                                data['name'] + '  ' + data['apellido'] + '  '),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data['email']),
                                Text(data['rool']),
                                Text(data['jass']!),
                                GestureDetector(
                                  onTap: () async {
                                    id = data['uid'];
                                    FirebaseFirestore.instance
                                        .collection('user')
                                        .doc(id)
                                        .delete();
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    id = data['uid'];
                                  },
                                  child: const Icon(
                                    Icons.disabled_by_default,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: StreamBuilder<QuerySnapshot>(
                  stream: _usersStream2,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: Text(data['provincia']),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      ),
    );
  }
}
