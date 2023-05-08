import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/models/user_model.dart';
import 'package:sistem_weatherv2/screens/home_screen.dart';

class UserOperarioScreen extends StatefulWidget {
  String id;
  UserOperarioScreen({super.key, required this.id});

  @override
  State<UserOperarioScreen> createState() => _UserOperarioScreenState();
}

class _UserOperarioScreenState extends State<UserOperarioScreen> {
  String? id;
  String? rooll;
  String? emaill;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('operario'),
        actions: [
          IconButton(
            onPressed: () {
              logout(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('UserOperarioScreen'),
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
