import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../routes/routes.dart';

class DraweLog extends StatefulWidget {
  final User? user;
  const DraweLog({
    super.key,
    required this.user,
  });

  @override
  State<DraweLog> createState() => _DraweLogState();
}

class _DraweLogState extends State<DraweLog> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  void dispose() {
    user!.email;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffCEEBF3),
      child: Column(
        children: [
          Expanded(
            child: Container(),
          ),
          const Divider(
            thickness: 2,
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: draweListLog.length,
              itemExtent: 150,
              itemBuilder: (context, index) {
                final item = draweListLog[index];
                return GestureDetector(
                  onTap: () {
                    if (item.title == 'Productos') {
                      Navigator.pushNamed(context, Routes.productosscreen);
                    } else {
                      Navigator.pushNamed(context, Routes.registro,
                          arguments: item.title);
                    }
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.all(10).copyWith(right: 0, left: 0),
                    color: Colors.amber,
                    child: Row(
                      children: [
                        Icon(item.icon),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(item.title),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(
            thickness: 2,
          ),
          Expanded(
            child: Column(
              children: [
                MaterialButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.home, (route) => false);
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text('salir'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
