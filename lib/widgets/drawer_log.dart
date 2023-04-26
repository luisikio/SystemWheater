import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../routes/routes.dart';

class DraweLog extends StatefulWidget {
  const DraweLog({
    super.key,
    required this.user,
  });

  final User? user;

  @override
  State<DraweLog> createState() => _DraweLogState();
}

class _DraweLogState extends State<DraweLog> {
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
              itemExtent: 200,
              itemBuilder: (context, index) {
                final item = draweListLog[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.registro,
                        arguments: item.title);
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
                Text(' ${widget.user?.email}'),
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
