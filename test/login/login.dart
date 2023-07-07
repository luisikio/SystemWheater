// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// class MockUser extends Mock implements User {}

// class MockFirebaseAuth extends Mock implements FirebaseAuth {
//   @override
//   Future<UserCredential> signInWithEmailAndPassword({
//     required String email,
//     required String password,
//   }) {
//     // Provide your desired implementation here
//     return Future.value(null);
//   }
// }

// void main() {
//   final MockFirebaseAuth mockAuth = MockFirebaseAuth();

//   setUp(() {});
//   tearDown(() {});

//   test('iniciar Sesion', () async {
//     when(mockAuth.signInWithEmailAndPassword(
//       email: 'asdf@gmail.com',
//       password: '123456',
//     )).thenAnswer((_) => Future.value(null));

//     // Rest of your test code...
//   });
// }
