import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/screens/users_screen/splash.dart';
import 'package:sistem_weatherv2/screens/users_screen/super_admin/super_admin_screen.dart';
import 'package:sistem_weatherv2/screens/users_screen/user_admin/user_admin_screen.dart';
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
        .doc(user!.uid)
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
      return UserAdminScreen(
        id: 'admin',
      );
    }
    if (rooll == 'superadmin') {
      return SuperAdminScreen(
        id: id ?? "default",
      );
    }
    if (rooll == 'operario') {
      return UserOperarioScreen(
        id: id ?? "default",
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
