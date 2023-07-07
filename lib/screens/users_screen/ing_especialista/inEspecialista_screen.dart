// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../models/user_model.dart';
import '../../../routes/routes.dart';
import '../../home_screen.dart';

// ignore: must_be_immutable
class IngEspecialistaScreen extends StatefulWidget {
  String id;
  IngEspecialistaScreen({super.key, required this.id});

  @override
  State<IngEspecialistaScreen> createState() => _UserOperarioScreenState();
}

class _UserOperarioScreenState extends State<IngEspecialistaScreen> {
  String? id;
  String? rooll;
  String? emaill;

  final Stream<QuerySnapshot> _usersStreamMonitoreo =
      FirebaseFirestore.instance.collection('monitoreo').snapshots();
  final Stream<QuerySnapshot> _usersStreamCloracion =
      FirebaseFirestore.instance.collection('cloracion').snapshots();

  UserModel loggIdUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user") //.where('uid', isEqualTo: user!.uid)
        .doc(id)
        .get()
        .then((value) {
      loggIdUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        emaill = loggIdUser.email.toString();
        rooll = loggIdUser.rool.toString();
        id = loggIdUser.uid.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text('ing especialista'),
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Divider(),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.cloracionDetails);
                },
                child: Container(
                  margin: wid > 900 && wid < 1300
                      ? const EdgeInsets.symmetric(horizontal: 300)
                      : wid > 1300 && wid < 1600
                          ? const EdgeInsets.symmetric(horizontal: 300)
                          : wid > 1600
                              ? const EdgeInsets.symmetric(horizontal: 300)
                              : const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff272D3D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Cloración',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _usersStreamCloracion,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          int totaljass = snapshot.data!.docs.length;

                          return Column(
                            children: [
                              Text(
                                'Total de Cloración: $totaljass',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          );
                        },
                      ),
                      Flexible(
                        child: LottieBuilder.asset(
                          'assets/cloracion.json',
                          fit: BoxFit.fill,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            ///////
            const Divider(),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.monitoreoDetails);
                },
                child: Container(
                  margin: wid > 900 && wid < 1300
                      ? const EdgeInsets.symmetric(horizontal: 300)
                      : wid > 1300 && wid < 1600
                          ? const EdgeInsets.symmetric(horizontal: 300)
                          : wid > 1600
                              ? const EdgeInsets.symmetric(horizontal: 300)
                              : const EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xff272D3D),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'Monitoreo',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      StreamBuilder<QuerySnapshot>(
                        stream: _usersStreamMonitoreo,
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          int totaljass = snapshot.data!.docs.length;

                          return Column(
                            children: [
                              Text(
                                'Total de Monitoreos: $totaljass',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          );
                        },
                      ),
                      Flexible(
                        child: LottieBuilder.asset(
                          'assets/monitoreo.json',
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Divider(),
          ],
        ));
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
}
