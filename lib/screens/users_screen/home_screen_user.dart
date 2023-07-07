import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:sistem_weatherv2/screens/users_screen/ing_especialista/inEspecialista_screen.dart';
import 'package:sistem_weatherv2/screens/users_screen/splash.dart';
import 'package:sistem_weatherv2/screens/users_screen/super_admin/super_admin_screen.dart';
import 'package:sistem_weatherv2/screens/users_screen/atm/atm_screen.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_operario/user_operario.dart';

import '../../models/user_model.dart';

class HomeScreenUsers extends StatefulWidget {
  const HomeScreenUsers({Key? key}) : super(key: key);

  @override
  State<HomeScreenUsers> createState() => _HomeScreenUsersState();
}

class _HomeScreenUsersState extends State<HomeScreenUsers> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? rooll;
  String? emaill;
  String? id;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("user") //.where('uid', isEqualTo: user!.uid)
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
    }).whenComplete(() {
      const CircularProgressIndicator();
      setState(() {
        emaill = loggedInUser.email.toString();
        rooll = loggedInUser.rool.toString();
        id = loggedInUser.uid.toString();
      });
    });
  }

  routing() {
    const CircularProgressIndicator();
    if (rooll == 'admin') {
      // print(id);
      return AdminScreen(
        id: rooll!,
      );
    }
    if (rooll == 'ingespecialista') {
      return IngEspecialistaScreen(
        id: rooll!,
      );
    }
    if (rooll == 'atm') {
      return AtmScreen(
        id: rooll!,
      );
    }
    if (rooll == 'operario') {
      //print(id);
      return UserOperarioScreen(
        id: rooll!,
      );
    } else {
      return const SpashScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    const CircularProgressIndicator();
    return routing();
  }
}
