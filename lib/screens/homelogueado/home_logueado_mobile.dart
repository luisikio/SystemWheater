import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:sistem_weatherv2/constants/constants.dart';
import 'package:sistem_weatherv2/models/user_model.dart';
import 'package:sistem_weatherv2/readData/read_user.dart';
import 'package:sistem_weatherv2/routes/routes.dart';

import '../../widgets/drawer_log.dart';

class HomeLogueadoMobileScreen extends StatefulWidget {
  const HomeLogueadoMobileScreen({Key? key}) : super(key: key);

  @override
  State<HomeLogueadoMobileScreen> createState() => _HomeLogueadoScreenState();
}

class _HomeLogueadoScreenState extends State<HomeLogueadoMobileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  //documentsIDS

  // @override
  // void initState() {
  //   getDocIds();
  //   super.initState();
  // }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('user').snapshots();
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
          children: [
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[400],
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
                        return ListTile(
                          title: Text(data['name'] + '  ' + data['apellido']),
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(data['email']),
                              Text(data['rool']),
                            ],
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
                  color: Colors.grey[400],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
