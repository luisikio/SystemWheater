import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/constants/constants.dart';
import 'package:sistem_weatherv2/routes/routes.dart';

import '../../widgets/drawer_log.dart';

class HomeLogueadoMobileScreen extends StatefulWidget {
  const HomeLogueadoMobileScreen({Key? key}) : super(key: key);

  @override
  State<HomeLogueadoMobileScreen> createState() => _HomeLogueadoScreenState();
}

class _HomeLogueadoScreenState extends State<HomeLogueadoMobileScreen> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: DraweLog(user: user),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
      ),
    );
  }
}
