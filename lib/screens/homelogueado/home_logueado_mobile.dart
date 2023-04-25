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
  List<String> docIds = [];
  //GET docsIDS
  Future getDocIds() async {
    await FirebaseFirestore.instance.collection('user').get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIds.add(document.reference.id);
          }),
        );
  }

  // @override
  // void initState() {
  //   getDocIds();
  //   super.initState();
  // }

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
                child: FutureBuilder(
                  future: getDocIds(),
                  builder: (context, snapshot) {
                    return ListView.builder(
                      itemCount: docIds.length,
                      itemBuilder: (context, index) {
                        final item = docIds[index];
                        return ListTile(
                          title: ReadUser(documenId: item),
                        );
                      },
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
