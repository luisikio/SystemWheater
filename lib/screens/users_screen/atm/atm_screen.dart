import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../widgets/cardView.dart';
import '../../home_screen.dart';

// ignore: must_be_immutable
class AtmScreen extends StatefulWidget {
  String id;
  AtmScreen({super.key, required this.id});

  @override
  State<AtmScreen> createState() => _UserOperarioScreenState();
}

class _UserOperarioScreenState extends State<AtmScreen> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();
  final Stream<QuerySnapshot> _usersStream2 =
      FirebaseFirestore.instance.collection('producto').snapshots();
  final Stream<QuerySnapshot> _usersStream3 =
      FirebaseFirestore.instance.collection('JasRegistration').snapshots();

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final wid = MediaQuery.of(context).size.width;
    print(wid);
    return Scaffold(
      backgroundColor: const Color(0xff1F2432),
      appBar: AppBar(
        title: Text('${user!.displayName} Atm'),
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
              cardView(
                usersStream3: _usersStream3,
                usersStream: _usersStream,
                usersStream2: _usersStream2,
                rool: 'atm',
              ),
            ],
          ),
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
    eliminarSharPre();
  }

  void eliminarSharPre() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('adminEmail');
    prefs.remove('adminPassword');
  }
}
