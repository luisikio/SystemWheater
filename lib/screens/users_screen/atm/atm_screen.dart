import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../models/user_model.dart';
import '../../../widgets/drawer_log.dart';
import '../../home_screen.dart';

// ignore: must_be_immutable
class AtmScreen extends StatefulWidget {
  String id;
  AtmScreen({super.key, required this.id});

  @override
  State<AtmScreen> createState() => _UserOperarioScreenState();
}

class _UserOperarioScreenState extends State<AtmScreen> {
  String? id;

  String? emaill;

  UserModel loggIdUser = UserModel();

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    // print(user);
    return Scaffold(
      appBar: AppBar(
        title: Text('${user!.displayName}'),
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
      body: const Center(
        child: Text('Atm'),
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
