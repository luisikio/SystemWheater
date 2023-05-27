import 'package:cloud_firestore/cloud_firestore.dart';

class ListJass {
  final String provincia;
  final String uid;

  ListJass({required this.provincia, required this.uid});

  factory ListJass.fromMap(Map<String, dynamic> map) {
    return ListJass(
      provincia: map['provincia'],
      uid: map['iud'],
    );
  }
}

Future<List<ListJass>> getObjectList() async {
  List<ListJass> objectList = [];

  QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection('jass').get();
  List<QueryDocumentSnapshot> documentList = querySnapshot.docs;

  for (var document in documentList) {
    ListJass object = ListJass(
        provincia: document.get('provincia'), uid: document.get('uid'));
    objectList.add(object);
  }

  return objectList;
}
